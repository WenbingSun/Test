# Alternative Dockerfile approach for Ollama
# Note: docker-compose.yml is recommended for easier management

FROM ollama/ollama:latest

# Copy the initialization script
COPY init-models.sh /usr/local/bin/init-models.sh
RUN chmod +x /usr/local/bin/init-models.sh

# Expose Ollama API port
EXPOSE 11434

# Set environment variable
ENV OLLAMA_HOST=0.0.0.0:11434

# Start Ollama server
CMD ["ollama", "serve"]
