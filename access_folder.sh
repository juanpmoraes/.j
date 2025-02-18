#!/bin/bash

# access_folder.sh - Script para acessar uma pasta digitando apenas o nome dela

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 NOME_DA_PASTA"
    echo "    NOME_DA_PASTA   Nome da pasta para acessar"
    exit 1
}

# Verifica se foi fornecido exatamente um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Armazena o nome da pasta fornecida como argumento
FOLDER_NAME=$1

# Verifica se a pasta existe no diretório atual
if [ -d "$FOLDER_NAME" ]; then
    echo "Acessando a pasta: $FOLDER_NAME"
    cd "$FOLDER_NAME" || exit 1
    pwd
else
    echo "Pasta não encontrada: $FOLDER_NAME"
    exit 1
fi

