# Alternative Dockerfile approach for Ollama
# Note: docker-compose.yml is recommended for easier management

FROM ollama/ollama:latest

# Copy scripts
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY init-models.sh /usr/local/bin/init-models.sh
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/init-models.sh

# Expose Ollama API port
EXPOSE 11434

# Set environment variable
ENV OLLAMA_HOST=0.0.0.0:11434

# Start Ollama server and auto-pull models
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
