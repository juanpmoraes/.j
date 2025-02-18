#!/bin/bash

# remove_user.sh - Script para remover um usuário do sistema

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 USUARIO"
    echo "    USUARIO   Nome do usuário a ser removido"
    exit 1
}

# Verifica se foi fornecido um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Captura o nome de usuário
USERNAME=$1

# Remove o usuário
echo "Removendo usuário $USERNAME..."
userdel -r $USERNAME
