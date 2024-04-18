FROM python:3.11-slim

EXPOSE 3030

RUN pip install poetry --no-cache-dir --disable-pip-version-check

ENV POETRY_VIRTUALENVS_IN_PROJECT=0 \
    POETRY_VIRTUALENVS_CREATE=0 \
    POETRY_NO_INTERACTION=1

WORKDIR /app
COPY pyproject.toml poetry.lock /app/
RUN poetry install --no-cache

COPY ./dagster_example /app/dagster_example

CMD ["dagster", "api", "grpc", "--host", "0.0.0.0", "--port", "3030", "--python-file", "./dagster_example/definitions.py"]