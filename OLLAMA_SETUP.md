# Ollama Docker Setup

This setup allows you to run a local Ollama server using Docker with the following models:
- **mistral-nemo:12b**
- **llama3.1:8b**

## Prerequisites

- Docker and Docker Compose installed
- Sufficient disk space (models are large - expect 10-15GB total)
- (Optional) NVIDIA GPU for faster inference

## Quick Start

### 1. Start the Ollama Server (with automatic model download)

```bash
docker-compose up -d
```

This will **automatically**:
- Pull the official Ollama Docker image
- Start the Ollama server on port 11434
- Create a persistent volume for model storage
- **Pull mistral-nemo:12b and llama3.1:8b models in the background**

**Note**: The server starts immediately, but model downloads happen in the background and can take 10-30 minutes. You can use the server right away, but the specific models won't be available until downloads complete.

### 2. Monitor Model Download Progress

Watch the logs to see download progress:

```bash
docker-compose logs -f ollama
```

Or check which models are available:

```bash
docker exec ollama-server ollama list
```

### 3. Manual Model Management (Optional)

If you need to manually pull additional models or re-download:

```bash
# Run the initialization script
docker exec ollama-server bash /init-models.sh

# Or pull specific models
docker exec ollama-server ollama pull mistral-nemo:12b
docker exec ollama-server ollama pull llama3.1:8b
```

## Usage

### Run a Model Interactively

```bash
# Run mistral-nemo:12b
docker exec -it ollama-server ollama run mistral-nemo:12b

# Run llama3.1:8b
docker exec -it ollama-server ollama run llama3.1:8b
```

### Use the API

The Ollama API is available at `http://localhost:11434`

Example using curl:

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.1:8b",
  "prompt": "Why is the sky blue?",
  "stream": false
}'
```

Example using Python:

```python
import requests

response = requests.post('http://localhost:11434/api/generate',
    json={
        'model': 'llama3.1:8b',
        'prompt': 'Explain quantum computing in simple terms',
        'stream': False
    }
)

print(response.json()['response'])
```

## GPU Support (NVIDIA)

If you have an NVIDIA GPU, uncomment the GPU section in `docker-compose.yml`:

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: all
          capabilities: [gpu]
```

You'll also need the NVIDIA Container Toolkit installed:

```bash
# Install NVIDIA Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

## Management Commands

### View Logs

```bash
docker-compose logs -f ollama
```

### Stop the Server

```bash
docker-compose down
```

### Stop and Remove All Data

```bash
docker-compose down -v
```

### Check Container Status

```bash
docker-compose ps
```

### Access Container Shell

```bash
docker exec -it ollama-server bash
```

## Troubleshooting

### Models Not Downloading

- Check internet connection
- Verify container is running: `docker-compose ps`
- Check container logs: `docker-compose logs ollama`

### Out of Disk Space

Models require significant space:
- mistral-nemo:12b: ~7GB
- llama3.1:8b: ~4.7GB

Free up space or increase Docker's disk allocation.

### Port Already in Use

If port 11434 is already in use, modify the port mapping in `docker-compose.yml`:

```yaml
ports:
  - "11435:11434"  # Use port 11435 instead
```

### GPU Not Detected

- Ensure NVIDIA drivers are installed
- Verify NVIDIA Container Toolkit is installed
- Check GPU is available: `nvidia-smi`

## Model Information

### mistral-nemo:12b
- Parameters: 12 billion
- Context length: 128k tokens
- Use case: General purpose, good for complex reasoning

### llama3.1:8b
- Parameters: 8 billion
- Context length: 128k tokens
- Use case: Fast inference, good balance of speed and quality

## Additional Resources

- [Ollama Documentation](https://github.com/ollama/ollama)
- [Ollama Docker Image](https://hub.docker.com/r/ollama/ollama)
- [Ollama API Reference](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Available Models](https://ollama.com/library)

## File Structure

```
.
├── docker-compose.yml    # Docker Compose configuration
├── Dockerfile           # Alternative Dockerfile for custom builds
├── entrypoint.sh        # Automatic startup script (runs server + pulls models)
├── init-models.sh       # Manual script to pull models
└── OLLAMA_SETUP.md      # This file
```
