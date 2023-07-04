FROM python:3.10-slim-bullseye as builder

RUN apt-get update --fix-missing && apt-get install -y --fix-missing build-essential

RUN mkdir /install
WORKDIR /install

COPY ./requirements.txt requirements.txt

RUN pip install --no-cache-dir --upgrade --prefix="/install" -r requirements.txt

FROM clickhouse/clickhouse-server:22.9

RUN apt-get update && apt-get install -y python3

RUN mkdir /chroma
WORKDIR /chroma

COPY --from=builder /usr/local /usr/local
COPY --from=builder /install /usr/local
COPY ./bin/docker_entrypoint.sh /chroma/docker_entrypoint.sh
COPY ./ /chroma

ENV CHROMA_DB_IMPL=clickhouse
ENV CLICKHOUSE_HOST=localhost
ENV CLICKHOUSE_PORT=8123
ENV ALLOW_EMPTY_PASSWORD=yes
ENV CLICKHOUSE_TCP_PORT=9000
ENV CLICKHOUSE_HTTP_PORT=8123

EXPOSE 8000

CMD ["/chroma/docker_entrypoint.sh"]
