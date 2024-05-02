FROM python:3.12-alpine

COPY --from=ghcr.io/typst/typst:latest /bin/typst /bin/typst

WORKDIR /code/app

COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./src /code/app

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
