#!/bin/bash

# check_service.sh - Script para verificar o status de um serviço

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 SERVICO"
    echo "    SERVICO   Nome do serviço a ser verificado"
    exit 1
}

# Verifica se foi fornecido exatamente um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Armazena o argumento
SERVICE=$1

# Verifica o status do serviço
echo "Verificando o status do serviço $SERVICE..."
sudo systemctl status "$SERVICE"

# Verifica se o comando foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "O serviço $SERVICE está ativo."
else
    echo "O serviço $SERVICE não está ativo."
fi
