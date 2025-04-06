FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    git \
    wget \
    rsync \
 && apt-get clean

WORKDIR /app/gutenberg

COPY gutenberg/requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt