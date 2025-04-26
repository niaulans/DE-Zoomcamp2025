#!/usr/bin/env python
# coding: utf-8

import argparse, os, sys
from time import time
import pandas as pd 
import pyarrow.parquet as pq
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    
    if url.endswith('.csv.gz'):
        file_name = 'output.csv.gz'
    else:
        file_name = 'output.csv'
    
    # Download file from url
    os.system(f'wget {url} -O {file_name}')
    
    # Create SQL engine
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # Read csv file
    df_iter = pd.read_csv(file_name, iterator=True, chunksize=100000)
 
    # Insert values    
    while True: 
        try:
            t_start = time()
            
            df = next(df_iter)

            # Convert data type to datetime
            df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
            df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

            # Create tthe table
            df.to_sql(name=table_name, con=engine, if_exists='append')

            t_end = time()

            print('Inserted another chunk, took %.3f second' % (t_end - t_start))

        except StopIteration:
            print("Finished ingesting data into the Postgres database")
            break
        
if __name__ == '__main__':
    
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')
        
    parser.add_argument('--user', help='Username for Postgres.')
    parser.add_argument('--password', help='Password to the username for Postgres.')
    parser.add_argument('--host', help='Hostname for Postgres.')
    parser.add_argument('--port', help='Port for Postgres connection.')
    parser.add_argument('--db', help='Databse name for Postgres')
    parser.add_argument('--table_name', help='Destination table name for Postgres.')
    parser.add_argument('--url', help='URL for .parquet file.')

    args = parser.parse_args()
    main(args)

