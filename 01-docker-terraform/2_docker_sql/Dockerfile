FROM python:3.9.1

RUN apt-get install wget
RUN pip install pandas pyarrow sqlalchemy psycopg2 

RUN mkdir /app

WORKDIR /app
COPY data-loading-parquet.py data-loading-parquet.py

# Melewati prompt dan langsung masuk ke bash
# ENTRYPOINT [ "bash" ] 
ENTRYPOINT [ "python", "data-loading-parquet.py" ]

