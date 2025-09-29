# Use the official Python image for ARM64 architecture (Raspberry Pi 5)
FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    ca-certificates \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Update CA certificates and configure tools
RUN update-ca-certificates && \
    git config --global http.sslverify false

# Clone the original Phen2Gene repository
RUN git clone https://github.com/WGLab/Phen2Gene.git .

# Install Python dependencies with trusted hosts
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --no-cache-dir -r requirements.txt

# Download and install the knowledge base manually
RUN curl -L --insecure -o H2GKBs.zip https://github.com/WGLab/Phen2Gene/releases/download/1.1.0/H2GKBs.zip && \
    mkdir -p ./lib && \
    unzip -q H2GKBs.zip -d ./lib && \
    rm H2GKBs.zip && \
    echo "/app/lib" > ./lib/h2gpath.config

# Set the entry point to the main script
ENTRYPOINT ["python3", "phen2gene.py"]

# Default command shows help
CMD ["-h"]
