#!/bin/bash

# Entrypoint script that starts Ollama server and pulls models automatically

echo "Starting Ollama server..."

# Start Ollama server in the background
ollama serve &
OLLAMA_PID=$!

echo "Waiting for Ollama server to be ready..."
sleep 5

# Check if models already exist to avoid re-downloading
echo "Checking for existing models..."

# Function to check if model exists
model_exists() {
    ollama list | grep -q "$1"
}

# Pull models in the background if they don't exist
{
    if ! model_exists "mistral-nemo:12b"; then
        echo "Pulling mistral-nemo:12b model (this may take 10-20 minutes)..."
        ollama pull mistral-nemo:12b
        echo "✓ mistral-nemo:12b downloaded successfully"
    else
        echo "✓ mistral-nemo:12b already exists, skipping download"
    fi

    if ! model_exists "llama3.1:8b"; then
        echo "Pulling llama3.1:8b model (this may take 5-15 minutes)..."
        ollama pull llama3.1:8b
        echo "✓ llama3.1:8b downloaded successfully"
    else
        echo "✓ llama3.1:8b already exists, skipping download"
    fi

    echo ""
    echo "=== All models ready ==="
    echo "Available models:"
    ollama list
    echo "========================"
} &

# Wait for the Ollama server process
wait $OLLAMA_PID
