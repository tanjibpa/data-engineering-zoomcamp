docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    --network pg-network \
    --name pg-database \
postgres:13

URL="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet"

python ingest_data.py \
    --user=root \
    --password=root \
    --host=localhost \
    --port=5432 \
    --db=ny_taxi \
    --table-name=ny_taxi_trips \
    --url=${URL}

docker run -it --network=2_docker_sql_default \
    ny_taxi \
    --host=pgdatabase \
    --user=root \
    --password=root \
    --port=5432 \
    --db=ny_taxi \
    --table-name=zones \
    --file_name=taxi+_zone_lookup.csv