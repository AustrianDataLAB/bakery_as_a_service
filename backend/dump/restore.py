# %%
import os
import sys
import json
import requests
import copy
import base64

from baas_dump import url, get_session, DUMP_FILE

s = get_session()

print("== Reading File Dump")
print("reading", DUMP_FILE)

if not os.path.exists(DUMP_FILE):
    print("ERROR: Dump File does not exist!")
    print("exiting")
    sys.exit(1)

with open(DUMP_FILE) as fd:
    data = json.load(fd)

def check(res: requests.Response) -> requests.Response:
    if not res.ok:
        print("ERROR: API returned an error")
        print(res.status_code)
        print(res.text)
        sys.exit(1)
    return res

# %% Create Collections

print("== Restoring Collections")
for c in data["collections"]:
    print("Add", c["collection"])
    fields = list(filter(lambda f: f["collection"] == c["collection"], data["fields"]))
    c["fields"] = fields
    check(s.post(url("/collections"), json=c))

# %% Flows

print("== Restoring Flows")
for c in data["flows"]:
    print("Add", c["name"])
    c = copy.deepcopy(c)
    c.pop("operation")
    c.pop("operations")
    c.pop("user_created")
    check(s.post(url("/flows"), json=c))

# %%

ops = {op["id"]:op for op in data["operations"]}
to_insert = copy.deepcopy(data["operations"])
inserted = set()

# inefficient but does the job
while len(to_insert) > 0:
    op = to_insert.pop(0)
    
    ok_dep = op["resolve"] is not None and op["resolve"] not in inserted
    fail_dep = op["reject"] is not None and op["reject"] not in inserted

    if  ok_dep or fail_dep:
        # unmet dependencies -> will fail (FK constraint)
        to_insert.append(op)
        continue

    print(f"Add Operation {op["name"]} ({op["id"]})")
    check(s.post(url("/operations"), json=op))
    inserted.add(op["id"])

# %%

# patch the flows with the operations (i.e. connections)
for c in data["flows"]:
    print("Patch", c["name"])
    c = copy.deepcopy(c)
    c.pop("operations")
    c.pop("user_created")
    check(s.patch(url("/flows/" + c["id"]), json=c))

# %% Restore File Uploads
print("== Restoring Files")
fileLut = {}

for f in data["files"]:
    contents = base64.b64decode(f["content"])
    file = f["name"]
    print("Uploading", file)

    formdata = {
        file: (
            file,
            contents,
            f["type"],
            {"filename_download": file}
        )
    }
    res = check(s.post(url("/files"), files=formdata))
    fileLut[file] = res.json()["data"]["id"]

# %% Restore Items
print("== Restoring Items")

def replace_image_product(prod):
    # replace filename with image upload id
    prod["image"] = fileLut[prod["image"]]
    return prod

handler = {
    "Products": replace_image_product
}

for collection, contents in data["items"].items():
    # Replace file name with upload id
    h = handler.get(collection, lambda x: x)

    for c in contents:
        c = h(c)
        res = check(s.post(url(f"/items/{collection}"), json=c))

print("OK")

# %%
