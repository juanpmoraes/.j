#!/bin/bash

# clear_dns_cache.sh - Script para limpar cache de DNS

# Verifica se o usuário tem permissão de root
if [[ $EUID -ne 0 ]]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

# Limpa o cache de DNS
echo "Limpando cache de DNS..."
if command -v systemd-resolve &> /dev/null; then
    systemd-resolve --flush-caches
    echo "Cache de DNS limpo."
elif command -v service &> /dev/null; then
    service nscd restart
    echo "Cache de DNS limpo."
else
    echo "Cache de DNS não pôde ser limpo. Verifique sua configuração."
fi
