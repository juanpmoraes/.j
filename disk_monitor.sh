#!/bin/bash

# disk_monitor.sh - Script para monitorar o uso de disco

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 LIMITE_USO"
    echo "    LIMITE_USO   Limite de uso de disco em porcentagem (e.g., 80)"
    exit 1
}

# Verifica se foi fornecido exatamente um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Armazena o argumento
LIMIT=$1

# Verifica o uso de disco
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Envia um alerta se o uso de disco ultrapassar o limite
if [ "$DISK_USAGE" -gt "$LIMIT" ]; then
    echo "Alerta: Uso de disco ultrapassou o limite de $LIMIT% (uso atual: $DISK_USAGE%)"
fi
