#!/bin/bash

# count_files_by_type.sh - Script para contar arquivos por tipo em um diretório

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 DIRETORIO"
    echo "    DIRETORIO   Diretório para contar arquivos por tipo"
    exit 1
}

# Verifica se foi fornecido exatamente um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Armazena o argumento
DIR=$1

# Conta arquivos por tipo (extensão)
find "$DIR" -type f | awk -F . '{print $NF}' | sort | uniq -c | sort -nr
