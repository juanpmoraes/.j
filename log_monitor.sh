#!/bin/bash

# log_monitor.sh - Script para monitorar logs por palavra-chave

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 ARQUIVO_LOG PALAVRA_CHAVE"
    echo "    ARQUIVO_LOG    Caminho completo do arquivo de log"
    echo "    PALAVRA_CHAVE  Palavra-chave a ser monitorada"
    exit 1
}

# Verifica se foram fornecidos exatamente dois argumentos
if [ $# -ne 2 ]; then
    show_help
fi

# Armazena os argumentos
LOG_FILE=$1
KEYWORD=$2

# Monitora o log em tempo real buscando pela palavra-chave
tail -n 0 -f "$LOG_FILE" | grep --line-buffered "$KEYWORD"
