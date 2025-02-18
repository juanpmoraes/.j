#!/bin/bash

# check_port_connections.sh - Script para verificar conexões de rede por porta

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 PORTA"
    echo "    PORTA   Número da porta para verificar conexões"
    exit 1
}

# Verifica se foi fornecido exatamente um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Armazena o argumento
PORT=$1

# Verifica as conexões de rede na porta especificada
netstat -an | grep LISTEN | grep ":$PORT\b"
