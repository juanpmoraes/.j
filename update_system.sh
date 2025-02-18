#!/bin/bash

# update_system.sh - Script para atualizar todos os pacotes do sistema

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0"
    echo "    Atualiza todos os pacotes instalados no sistema"
    exit 1
}

# Atualiza os pacotes
echo "Atualizando todos os pacotes do sistema..."
sudo apt update && sudo apt upgrade -y

# Verifica se a atualização foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Pacotes atualizados com sucesso!"
else
    echo "Erro ao atualizar os pacotes."
fi
