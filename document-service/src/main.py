from typing import Union, Annotated
import tempfile
from os import path
import subprocess
import shutil

from fastapi import FastAPI, File, UploadFile
from fastapi.responses import FileResponse, Response
from pydantic import BaseModel

TYPST = 'typst'
TEMPLATE = path.abspath(path.join(path.dirname(__file__), 'template'))

app = FastAPI()

@app.get("/")
def read_root():
    return FileResponse(path.join(TEMPLATE, 'index.html'))

@app.get("/example")
def get_example():
    return FileResponse(path.join(TEMPLATE, 'students.csv'))

@app.post("/")
def generate_doc(file: Annotated[bytes, File()]):
    with tempfile.TemporaryDirectory(prefix='doc_service_') as tmpdir:
        print(tmpdir)
        with open(path.join(tmpdir, 'students.csv'), 'wb') as fd:
            fd.write(file)
        shutil.copy(path.join(TEMPLATE, 'students.typ'), tmpdir)
        sub = subprocess.run([TYPST, 'compile', 'students.typ'], cwd=tmpdir, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        print(sub.returncode)
        print(sub.stdout)
        print(sub.stderr)
        with open(path.join(tmpdir, 'students.pdf'), 'rb') as fd:
            pdf = fd.read()
        return Response(content=pdf, media_type='application/pdf')
