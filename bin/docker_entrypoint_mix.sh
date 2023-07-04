#!/bin/bash

# echo "Rebuilding hnsw to ensure architecture compatibility"
# pip install --force-reinstall --no-cache-dir hnswlib
uvicorn chromadb.app:app --reload --workers 1 --host 0.0.0.0 --port 8000 --log-config log_config.yml
