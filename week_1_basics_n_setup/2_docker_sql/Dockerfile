FROM python:3.9

RUN apt install wget
RUN pip install pandas sqlalchemy psycopg2 pyarrow

WORKDIR /app

COPY taxi+_zone_lookup.csv /app/taxi+_zone_lookup.csv
COPY green_tripdata_2019-09.csv /app/green_tripdata_2019-09.csv

COPY ingest_data.py ingest_data.py

ENTRYPOINT [ "bash" ]

# ENTRYPOINT [ "python", "ingest_data.py" ]