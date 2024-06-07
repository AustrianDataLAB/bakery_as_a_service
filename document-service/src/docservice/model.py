from typing import Any
from pydantic import BaseModel, Field


class MalformedDocumentListException(Exception):
    
    msg: str

    def __init__(self, msg: str, *args) -> None:
        super().__init__(*args)
        self.msg = msg


class DocumentList(BaseModel):
    title: str
    tag: str | None
    numbered: bool = True
    lines: bool = True
    header: list[str]
    rows: list[list[Any]]

    def verify_document_list(self):
        header_len = len(self.header)
        for e in self.rows:
            if len(e) != header_len:
                raise MalformedDocumentListException("The length of the header must be equal to the length of all rows")


class B64Image(BaseModel):
    image: str
    format: str

class InvoiceInfo(BaseModel):
    name: str
    contents: list[tuple[str,str]]

class InvoiceHeader(BaseModel):
    logo: B64Image
    recipient: list[str]
    sender: list[str]
    info: InvoiceInfo

class InvoiceContent(BaseModel):
    title: str
    content: str
    colwidth: list[str|int]
    align: list[str]
    fields: list[str]
    entries: list[list[str]]
    postmessage: str
    totals: list[tuple[str,str]]
    bankinfo: dict[str, str]

class DocumentInvoice(BaseModel):
    header: InvoiceHeader
    content: InvoiceContent
