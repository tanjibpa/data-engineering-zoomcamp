import os
import argparse

import pandas as pd
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    # file_name = 'output.csv'
    file_name = params.file_name
    
    # os.system(f"wget {url} -o {file_name}")

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # df = pd.read_parquet('yellow_tripdata_2021-01.parquet')
    df = pd.read_csv(file_name)

    if 'lpep_pickup_datetime' in df:
        df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

    print(pd.io.sql.get_schema(df, name=table_name, con=engine))

    df.to_sql(name=table_name, con=engine, if_exists='replace')

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Ingest parquet data to postgres")
    parser.add_argument('--user', help="user name of pg")
    parser.add_argument('--password', help="password of pg")
    parser.add_argument('--host', help="host name of pg")
    parser.add_argument('--port', help="port of pg")
    parser.add_argument('--db', help="database name of pg")
    parser.add_argument('--table-name', help="table name")
    parser.add_argument('--url', help="url of the csv file")
    parser.add_argument('--file_name', help="name of the csv file")


    args = parser.parse_args()
    # print(args.accumulate(args.integers))
    
    main(args)




