#!/bin/bash

# Script to pull Ollama models
# This script should be run inside the Ollama container

echo "Starting Ollama model initialization..."

# Wait for Ollama service to be ready
sleep 5

# Pull mistral-nemo:12b
echo "Pulling mistral-nemo:12b model..."
ollama pull mistral-nemo:12b

# Pull llama3.1:8b
echo "Pulling llama3.1:8b model..."
ollama pull llama3.1:8b

echo "All models downloaded successfully!"
echo "Available models:"
ollama list
