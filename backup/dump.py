# %%
import os
import sys
from baas_dump import get_session, url, DUMP_FILE
import json
import requests

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


# %% Save dump

print("== Creating File Dump")
print("Writing", DUMP_FILE)
with open(DUMP_FILE, 'w') as fd:
    json.dump(output, fd, indent=2)

print("OK")
