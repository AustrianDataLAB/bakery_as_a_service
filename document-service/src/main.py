from typing import Any
from os import path
from functools import cache
import base64

from fastapi import FastAPI, HTTPException
from fastapi.responses import FileResponse, Response, RedirectResponse

from docservice import generation, model

TEMPLATE = path.abspath(path.join(path.dirname(__file__), "template"))


@cache
def get_template(name: str):
    template_path = path.join(TEMPLATE, name + ".typ")
    with open(template_path, "r") as fd:
        return fd.read()


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
def get_list_example():
    return FileResponse(path.join(TEMPLATE, "backliste.json"))

@app.get(
    "/example/invoice",
    summary="Example JSON invoice data",
    description="""
    Retrieve an example JSON document that can be passed to the invoice endpoint.
    The data contains an example base64-encoded logo, as well as several items.
    """
)
def get_invoice_example():
    return FileResponse(path.join(TEMPLATE, "invoice.json"))

@app.post(
    "/generate/list",
    summary="Generate baker list pdf",
    description="""
        Generate a pdf that contains a todo-list/work-list for bakers.
        Headers and all rows must have the same length.
    """,
)
def generate_doc(file: model.DocumentList, encoding: str="base64"):

    try:
        file.verify_document_list()
    except model.MalformedDocumentListException as e:
        raise HTTPException(
            status_code=400,
            detail=e.msg,
        )

    try:
        pdf = generation.generate_document(
            get_template("document_list"), {"data": file.model_dump_json()}
        )
    except generation.GenerationException as e:
        raise HTTPException(status_code=500, detail=e.reason + "\n" + e.detail)

    if encoding == "base64":
        data = str(base64.b64encode(pdf), 'utf8')
        return Response(content=data, media_type="application/pdf;base64")

    return Response(content=pdf, media_type="application/pdf")

@app.post(
    "/generate/invoice",
    summary="Generate invoice pdf",
    description="""
        Generate a pdf that contains an invoice for customers.
        The logo must be base64 encoded and either png or jpeg
    """,
)
def generate_invoice(file: model.DocumentInvoice, encoding: str="base64"):
    try:
        pdf = generation.generate_document(
            get_template("document_invoice"), {"data": file.model_dump_json()}
        )
    except generation.GenerationException as e:
        raise HTTPException(status_code=500, detail=e.reason + "\n" + e.detail)
    
    if encoding == "base64":
        data = str(base64.b64encode(pdf), 'utf8')
        return Response(content=data, media_type="application/pdf;base64")

    return Response(content=pdf, media_type="application/pdf")
