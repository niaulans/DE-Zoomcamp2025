#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import pyarrow.parquet as pq
import argparse
import os
from time import time
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    
    file_name = 'output.parquet'
    
    os.system(f'wget {url} -O {file_name}')
    
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    df = pq.read_table(file_name)
    df = df.to_pandas()

    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='append')
    df.to_sql(name=table_name, con=engine, if_exists='append')
    
    # Chunksize
    chunk_size = 100000

    # Split DataFrame into chunks using iloc
    df_iter = (df.iloc[i:i + chunk_size] for i in range(0, df.shape[0], chunk_size))

    # Start iterating through chunks
    for chunk in df_iter:
        try:
            t_start = time()

            # Save data into tables
            chunk.to_sql(name=table_name, con=engine, if_exists='append')

            t_end = time()
            print("Inserted another chunk..., took %.3f second" % (t_end - t_start))

        except Exception as e:
            print(f"An error occurred: {e}")
            break

    print("No more data to insert. Exiting loop.")

if __name__ == '__main__':
    
    parser = argparse.ArgumentParser(description='Ingest Parquet data to Postgres')
        
    parser.add_argument('--user', help='username for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table_name', help='name of the table where we will write the results to')
    parser.add_argument('--url', help='url of the data')

    args = parser.parse_args()
    
    main(args)

