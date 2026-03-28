#!/bin/bash

# This script starts the llamafile server with the specified model and settings.
# Usage: ./qwens.sh

# Start llamafile with the specified model and server settings
# QwenCoder Small 4GB
./llamafile -m ~/.ollama/models/blobs/sha256-60e05f2100071479f596b964f89f510f057ce397ea22f2833a0cfe029bfc2463 --host 0.0.0.0 --server --nobrowser --port 8888
