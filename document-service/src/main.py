from typing import Any
from os import path
from functools import cache

from fastapi import FastAPI, HTTPException
from fastapi.responses import FileResponse, Response, RedirectResponse
from pydantic import BaseModel

from docservice import generation

TEMPLATE = path.abspath(path.join(path.dirname(__file__), "template"))


@cache
def get_template():
    template_path = path.join(TEMPLATE, "document_list.typ")
    with open(template_path, "r") as fd:
        return fd.read()


class DocumentList(BaseModel):
    title: str
    tag: str | None
    numbered: bool = True
    lines: bool = True
    header: list[str]
    rows: list[list[Any]]


app = FastAPI(
    title="BaaS Document Service",
    summary="Create documents for Bakeries.",
    description="Create documents such as lists for bakers or invoices tailored to bakeries.",
    version="0.1.0",
)


@app.get("/")
def read_root():
    return RedirectResponse("/docs")


@app.get(
    "/example/list",
    summary="Example JSON baker lists",
    description="Retrieve an example JSON documents that can be passed to the baker list generation endpoint",
)
def get_example():
    return FileResponse(path.join(TEMPLATE, "backliste.json"))


@app.post(
    "/generate/list",
    summary="Generate baker list pdf",
    description="""
        Generate a pdf that contains a todo-list/work-list for bakers.
        Headers and all rows must have the same length.
    """,
)
def generate_doc(file: DocumentList):

    header_len = len(file.header)
    for e in file.rows:
        if len(e) != header_len:
            raise HTTPException(
                status_code=400,
                detail="The length of the header must be equal to the length of all rows",
            )

    try:
        pdf = generation.generate_document(
            get_template(), {"data": file.model_dump_json()}
        )
    except generation.GenerationException as e:
        raise HTTPException(status_code=500, detail=e.reason + "\n" + e.detail)

    return Response(content=pdf, media_type="application/pdf")
