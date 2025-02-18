#!/bin/bash

# generate_password.sh - Script para gerar senha segura

# Função para gerar senha aleatória
function generate_password {
    local LENGTH=${1:-16}
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c $LENGTH | xargs
}

# Exibe a senha gerada
echo "Senha gerada: $(generate_password)"
