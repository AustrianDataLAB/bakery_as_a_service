# %%
import os
import sys
from baas_dump import get_session, url, DUMP_FILE
import json
import requests
import base64

s = get_session()

output = {}

def check(res: requests.Response) -> dict:
    if not res.ok:
        print(res.text)
        sys.exit(1)
    return res.json()

# %%
# Save collections

not_directus = lambda c: not c["collection"].startswith("directus_")

print("== Exporting Collections")
res = check(s.get(url("/collections")))
collections = list(filter(not_directus, res["data"]))

print("== Exporting Fields (For Collections)")
res = check(s.get(url("/fields")))
fields = list(filter(not_directus, res["data"]))

output["collections"] = collections
output["fields"] = fields

# %% Export flows

print("== Exporting Flows")
res = check(s.get(url("/flows")))
output["flows"] = res["data"]

print("== Exporting Operations (for Flows)")
res = check(s.get(url("/operations")))
output["operations"] = res["data"] 

# %% Export images

oldFileIdLut = {}
files = []
print("== Exporting Files")
res = check(s.get(url("/files")))
for file in res["data"]:
    fid = file["id"]
    name = file["filename_download"]
    oldFileIdLut[fid] = name

    print(f"Getting {name}")
    res = s.get(url(f"/assets/{fid}"))
    if not res.ok:
        print(res.text)
        sys.exit(1)

    files.append({
        "name": name,
        "type": file["type"],
        "content": str(base64.b64encode(res.content), 'utf-8'),
    })
output["files"] = files

# %% Export Products

def replace_image_product(prod):
    # replace image id with filename
    prod["image"] = oldFileIdLut[prod["image"]]
    return prod

handler = {
    "Products": replace_image_product
}

output["items"] = {}

print("== Export Items")
for collection in collections:
    name = collection["collection"]
    print("Getting", name)
    res = check(s.get(url(f"/items/{name}")))
    collection_content = list(map(handler.get(name, lambda x: x), res["data"]))
    output["items"][name] = collection_content


# %% Save dump

print("== Creating File Dump")
print("Writing", DUMP_FILE)
with open(DUMP_FILE, 'w') as fd:
    json.dump(output, fd, indent=2)

print("OK")

# %%
