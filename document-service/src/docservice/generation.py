import subprocess
import tempfile
import os

class GenerationException(Exception):
    reason: str
    detail: str

    def __init__(self, reason:str, detail:str = ""):
        self.reason = reason
        self.detail = detail


TYPST = os.getenv('TYPST_BIN', 'typst')


def generate_document(template: str, data: dict[str,str], timeout:int = 5000):
    with tempfile.TemporaryDirectory(prefix='doc_service_') as tmpdir:

        for filename, contents in data.items():
            with open(os.path.join(tmpdir, filename), 'w') as fd:
                fd.write(contents)
        
        sub = subprocess.Popen(
            [TYPST, 'compile', '-', 'out.pdf'],
            cwd=tmpdir,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True)
        
        sub.stdin.write(template)
        sub.stdin.close()

        try:
            ret = sub.wait(timeout)
        except subprocess.TimeoutExpired:
            raise GenerationException("Timeout was reached while generating the document")

        if ret != 0:
            raise GenerationException("Generation was not successful", sub.stdout.read())

        with open(os.path.join(tmpdir, 'out.pdf'), 'rb') as fd:
            return fd.read()
