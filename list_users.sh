#!/bin/bash

# list_users.sh - Script para listar informações de todos os usuários do sistema

echo "Listando todos os usuários do sistema:"
echo "-------------------------------------"
echo

# Utiliza o comando getent para listar os usuários do sistema
getent passwd | while IFS=: read -r username _ uid gid comment home shell; do
    echo "Usuário: $username"
    echo "  UID: $uid"
    echo "  GID: $gid"
    echo "  Comentário: $comment"
    echo "  Diretório Inicial: $home"
    echo "  Shell Padrão: $shell"
    echo
done
