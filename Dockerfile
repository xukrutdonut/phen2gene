FROM arm64v8/python:3.9-slim

WORKDIR /app

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y git curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clona el repositorio
RUN git clone https://github.com/WGLab/Phen2Gene.git .

# Instala dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Descarga el archivo del preprocesamiento necesario (puede tardar)
RUN curl -L -o gene_id_mapping.txt https://raw.githubusercontent.com/WGLab/Phen2Gene/master/data/gene_id_mapping.txt

# Establece el punto de entrada
ENTRYPOINT ["python3", "Phen2Gene_CLI.py"]
