from typing import Annotated, Any
from os import path
import shutil
from functools import cache

from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import FileResponse, Response
from pydantic import BaseModel

from docservice import generation

TYPST = 'typst'
TEMPLATE = path.abspath(path.join(path.dirname(__file__), 'template'))


@cache
def get_template():
    template_path = path.join(TEMPLATE, 'document_list.typ')
    with open(template_path, 'r') as fd:
        return fd.read()


class DocumentList(BaseModel):
    title: str
    tag: str
    numbered: bool = True
    lines: bool = True
    header: list[str]
    data: list[list[Any]]


app = FastAPI()

@app.get("/")
def read_root():
    return FileResponse(path.join(TEMPLATE, 'index.html'))

@app.get("/example")
def get_example():
    return FileResponse(path.join(TEMPLATE, 'backliste.json'))

@app.post("/")
def generate_doc(file: DocumentList):

    header_len = len(file.header)
    for e in file.data:
        if len(e) != header_len:
            raise HTTPException(status_code=400, detail="The length of the header must be equal to the length of all rows")

    try:
        pdf = generation.generate_document(get_template(), {'data.json': file.model_dump_json()})
    except generation.GenerationException as e:
        raise HTTPException(status_code=500, detail=e.reason)

    return Response(content=pdf, media_type='application/pdf')

