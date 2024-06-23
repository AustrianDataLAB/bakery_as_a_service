import os
import sys
from functools import cache
import urllib
import urllib.parse

import requests
import requests.cookies

ADMIN_USER = os.getenv("ADMIN_EMAIL", "admin@example.com")
ADMIN_PASSWORD = os.getenv("ADMIN_PASSWORD", "admin")
BASE_URL = os.getenv("BASE_URL", "http://localhost:8055")
DUMP_FILE = os.getenv("DUMP_FILE", "directus_dump.json")

@cache
def get_session() -> requests.Session:
    print("session is being created")
    auth_response = requests.post(BASE_URL + "/auth/login", json={
        "email": ADMIN_USER,
        "password": ADMIN_PASSWORD
    })

    if not auth_response.ok:
        print("requesting auth not ok:")
        print(auth_response.text)
        sys.exit(1)

    token = auth_response.json()["data"]["access_token"]
    print("authentication successful: ", token)

    session = requests.Session()
    session.cookies.set("directus_session_token", token)

    return session


@cache
def url(path: str) -> str:
    return urllib.parse.urljoin(BASE_URL, path)
