FROM python:3.9-slim

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /cvefixes

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    sqlite3 \
    gzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY Code/ ./Code/
COPY .CVEfixes.ini ./

RUN useradd -m -u 1000 cvefixes && \
    chown -R cvefixes:cvefixes /cvefixes
USER cvefixes

ENV PYTHONPATH=/cvefixes

CMD ["python", "Code/collect_projects.py"]

