# %%
import os
import sys
import json
import requests
import copy
import base64
import re

from baas_dump import url, get_session, DUMP_FILE, get_placeholder_urls, ADMIN_USER

s = get_session()

print("== Checking for existing Data")
res = s.get(url("/collections"))
if not res.ok:
    print("Error from directus: ", res.status_code)
    print(res.text)
    sys.exit(1)

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

# %%

# Idempotency; check whether Customer collection exists
res = s.get(url("/collections/Customer"))
if res.ok:
    print("existing collections were found, exiting")
    print(res.json())
    sys.exit(0)

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

PLACEHOLDER_URL_LUT = get_placeholder_urls()

def replace_placeholder(url):
    m = re.search(r'{{((\w|_|\d)+)}}', url)
    if m is None:
        return url
    placeholder_name = m.groups()[0]

    if placeholder_name not in PLACEHOLDER_URL_LUT:
        print("ERROR: Placeholder URL _not_ provided:")
        print("Include the URL in FLOW_SERVICE_URL env variable")
        sys.exit(1)

    placeholder_value = PLACEHOLDER_URL_LUT[placeholder_name]
    
    url = url.replace("{{" + placeholder_name + "}}", placeholder_value)

    return replace_placeholder(url)


# inefficient but does the job
while len(to_insert) > 0:
    op = to_insert.pop(0)
    
    ok_dep = op["resolve"] is not None and op["resolve"] not in inserted
    fail_dep = op["reject"] is not None and op["reject"] not in inserted

    if  ok_dep or fail_dep:
        # unmet dependencies -> will fail (FK constraint)
        to_insert.append(op)
        continue

    if op["type"] == "request":
        op["options"]["url"] = replace_placeholder(op["options"]["url"])

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

# %% Restore Items
print("== Restoring Users")

# getting admin role for demo purposes
r = check(s.get(url(f"/roles/")))
role = r.json()["data"][0]["id"]

for u in data["users"]:

    if u["email"] == ADMIN_USER:
        print("Skipping Admin")
        continue

    print("Add", u["first_name"], u["last_name"])
    
    # no password -> demo / set admin role
    if u["password"] == '**********':
        email = u["email"].lower()
        at_location = email.find('@')
        pw = email[:at_location]

        u["password"] = pw
        u["role"] = role

    check(s.post(url("/users/"), json=u))


# %%

print("OK")

# %%
