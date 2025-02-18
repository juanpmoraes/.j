#!/bin/bash

# batch_image_conversion.sh - Script para converter imagens em lote

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 DIRETORIO_ORIGEM DIRETORIO_DESTINO FORMATO_DESTINO"
    echo "    DIRETORIO_ORIGEM   Diretório que contém as imagens originais"
    echo "    DIRETORIO_DESTINO  Diretório onde as imagens convertidas serão salvas"
    echo "    FORMATO_DESTINO     Formato de imagem de destino (e.g., jpg, png)"
    exit 1
}

# Verifica se foram fornecidos exatamente três argumentos
if [ $# -ne 3 ]; then
    show_help
fi

# Armazena os argumentos
SRC_DIR=$1
DEST_DIR=$2
FORMAT=$3

# Converte as imagens
echo "Convertendo imagens de $SRC_DIR para $DEST_DIR no formato $FORMAT..."
mkdir -p "$DEST_DIR"
for img in "$SRC_DIR"/*; do
    if [ -f "$img" ]; then
        filename=$(basename -- "$img")
        filename_noext="${filename%.*}"
        convert "$img" "$DEST_DIR/$filename_noext.$FORMAT" > /dev/null 2>&1
        echo "Imagem $filename convertida."
    fi
done
echo "Conversão concluída."
