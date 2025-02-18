#!/bin/bash

# create_temp_files.sh - Script para criar arquivos temporários

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 NUM_ARQUIVOS TAMANHO"
    echo "    NUM_ARQUIVOS   Número de arquivos temporários a serem criados"
    echo "    TAMANHO        Tamanho de cada arquivo em bytes (opcional, padrão: 1K)"
    exit 1
}

# Verifica se foi fornecido pelo menos um argumento
if [ $# -lt 1 ]; then
    show_help
fi

# Armazena os argumentos
NUM_FILES=$1
SIZE=${2:-1024} # Tamanho padrão é 1K

# Cria os arquivos temporários
echo "Criando $NUM_FILES arquivos temporários de tamanho $SIZE bytes..."
for ((i=1; i<=$NUM_FILES; i++)); do
    dd if=/dev/zero of=tempfile$i bs=$SIZE count=1 > /dev/null 2>&1
    echo "Arquivo tempfile$i criado."
done
