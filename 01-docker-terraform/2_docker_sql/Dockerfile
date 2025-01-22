FROM python:3.9.1

RUN apt-get install wget
RUN pip install pandas pyarrow sqlalchemy psycopg2 

WORKDIR /app
COPY ingest_data.py ingest_data.py

# Melewati prompt dan langsung masuk ke bash
# ENTRYPOINT [ "bash" ] 
ENTRYPOINT [ "python", "ingest_data.py" ]

