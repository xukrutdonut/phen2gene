#!/bin/bash

# Script de construcción y prueba para Phen2Gene en Raspberry Pi 5

echo "🔧 Construyendo imagen Docker para Raspberry Pi 5..."
docker build -t phen2gene-rpi .

if [ $? -eq 0 ]; then
    echo "✅ Construcción exitosa!"
    
    echo "📋 Probando la imagen..."
    docker run --rm phen2gene-rpi
    
    echo ""
    echo "🧬 Probando con términos HPO de ejemplo..."
    mkdir -p output
    docker run --rm -v $(pwd)/output:/app/out phen2gene-rpi -m HP:0000252 HP:0000365 -v -n "test_result"
    
    echo ""
    echo "📂 Archivos generados en ./output/:"
    ls -la output/
    
    echo ""
    echo "✨ ¡Todo listo! Puedes usar la imagen phen2gene-rpi"
    echo ""
    echo "Ejemplos de uso:"
    echo "docker run --rm -v \$(pwd)/output:/app/out phen2gene-rpi -m HP:0000252 HP:0000365 -v"
    echo "docker-compose up --build"
    
else
    echo "❌ Error en la construcción. Revisa los logs anteriores."
    exit 1
fi