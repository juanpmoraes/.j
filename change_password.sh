#!/bin/bash

# change_password.sh - Script para alterar a senha de usuário

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 USUARIO"
    echo "    USUARIO   Nome do usuário para alterar a senha"
    exit 1
}

# Verifica se foi fornecido um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Captura o nome de usuário
USERNAME=$1

# Altera a senha do usuário
echo "Alterando senha para o usuário $USERNAME..."
passwd $USERNAME
