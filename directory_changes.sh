#!/bin/bash

# directory_changes.sh - Script para monitorar alterações em diretório

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 DIRETORIO"
    echo "    DIRETORIO   Diretório a ser monitorado"
    exit 1
}

# Verifica se foi fornecido exatamente um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Armazena o argumento
DIR=$1

# Monitora alterações no diretório em tempo real
inotifywait -m -r -e create,delete,modify,move "$DIR"
