import subprocess
import os
import time

class GenerationException(Exception):
    reason: str
    detail: str

    def __init__(self, reason: str, detail: str = ""):
        self.reason = reason
        self.detail = detail


TYPST = os.getenv("TYPST_BIN", "typst")


def generate_document(template: str, data: dict[str, str], timeout: int = 5):

    args = []
    for name, contents in data.items():
        args += ["--input", f'{name}={contents}']

    try:
        res = subprocess.run(
            [TYPST, "compile", "--format", "pdf"] + args + ["-", '/dev/stdout'],
            input=template.encode("utf-8"),
            capture_output=True,
            cwd='/tmp',
            timeout=5
        )
    except subprocess.TimeoutExpired:
        raise GenerationException("Timeout was reached while generating the document")
    
    if res.returncode != 0:
        raise GenerationException(
            "Generation was not successful", str(sub.stderr.read(), "utf-8")
        )
    
    return res.stdout
