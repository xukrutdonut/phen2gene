# Phen2Gene para Raspberry Pi 5

Este proyecto adapta [Phen2Gene](https://github.com/WGLab/Phen2Gene) para funcionar en Docker en Raspberry Pi 5.

## ¿Qué es Phen2Gene?

Phen2Gene es una herramienta de priorización de genes impulsada por fenotipos que toma datos de entrada HPO (Human Phenotype Ontology) y genera una lista priorizada de genes sospechosos.

## Instalación y Uso en Raspberry Pi 5

### Prerrequisitos

- Raspberry Pi 5 con sistema operativo actualizado
- Docker instalado
- Git instalado

### Instalación de Docker en Raspberry Pi 5

```bash
# Actualizar el sistema
sudo apt update && sudo apt upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Agregar tu usuario al grupo docker
sudo usermod -aG docker $USER

# Reiniciar sesión para aplicar cambios
```

### Construcción de la imagen Docker

```bash
# Clonar este repositorio
git clone https://github.com/xukrutdonut/phen2gene.git
cd phen2gene

# Construir la imagen Docker
docker build -t phen2gene-rpi .
```

### Uso básico

#### 1. Mostrar ayuda
```bash
docker run --rm phen2gene-rpi
```

#### 2. Análisis con términos HPO manuales
```bash
docker run --rm -v $(pwd)/output:/app/out phen2gene-rpi -m HP:0000252 HP:0000365 -v
```

#### 3. Análisis con archivo de entrada
```bash
# Crear directorio de entrada
mkdir input output

# Crear archivo con términos HPO (ejemplo)
echo "HP:0000252" > input/hpo_terms.txt
echo "HP:0000365" >> input/hpo_terms.txt

# Ejecutar análisis
docker run --rm -v $(pwd)/input:/app/input:ro -v $(pwd)/output:/app/out phen2gene-rpi -f /app/input/hpo_terms.txt -v
```

#### 4. Usando docker-compose (recomendado)
```bash
# Editar docker-compose.yml según tus necesidades
docker-compose up --build
```

### Ejemplos de términos HPO

- `HP:0000252`: Microcefalia
- `HP:0000365`: Pérdida auditiva
- `HP:0000821`: Hipotiroidismo
- `HP:0001250`: Convulsiones

### Opciones principales

- `-m [HPID ...]`: Ingresar HPO IDs uno por uno
- `-f [FILE ...]`: Archivo(s) de entrada con HP IDs
- `-v`: Mostrar flujo de trabajo detalladamente
- `-out OUTPUT`: Especificar ruta para archivos de salida
- `-json`: Formato de salida en JSON
- `-w MODELO`: Modelo de ponderación (w|u|s|ic|d)

### Estructura de archivos

```
phen2gene/
├── Dockerfile              # Configuración Docker para RPi 5
├── docker-compose.yml      # Configuración Docker Compose
├── README.md               # Este archivo
├── input/                  # Directorio para archivos de entrada (crear)
└── output/                 # Directorio para resultados (crear)
```

### Solución de problemas

1. **Error de permisos**: Asegúrate de estar en el grupo docker
2. **Espacio insuficiente**: La imagen ocupa ~2GB, asegúrate de tener espacio
3. **Arquitectura ARM64**: Esta versión está optimizada para Raspberry Pi 5 (ARM64)

### Contribuir

Este es un fork adaptado para Raspberry Pi 5. Para contribuciones al proyecto original, visita: https://github.com/WGLab/Phen2Gene

### Licencias

Este proyecto mantiene la misma licencia que el proyecto original Phen2Gene.