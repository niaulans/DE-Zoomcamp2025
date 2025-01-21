FROM python:3.9.1

RUN pip install pandas

WORKDIR /app
COPY pipeline.py pipeline.py

# Melewati prompt dan langsung masuk ke bash
# ENTRYPOINT [ "bash" ] 
ENTRYPOINT [ "python", "pipeline.py" ]

