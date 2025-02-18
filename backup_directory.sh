#!/bin/bash

# backup_directory.sh - Script para criar backup de um diretório

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 DIRETORIO DESTINO"
    echo "    DIRETORIO   Diretório a ser feito backup"
    echo "    DESTINO     Diretório onde o backup será salvo"
    exit 1
}

# Verifica se foram fornecidos dois argumentos
if [ $# -ne 2 ]; then
    show_help
fi

# Captura os argumentos
SOURCE_DIR=$1
DESTINATION=$2

# Verifica se o diretório de origem existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erro: Diretório de origem não encontrado."
    show_help
fi

# Cria o diretório de destino, se não existir
mkdir -p "$DESTINATION"

# Nome do arquivo de backup
BACKUP_FILE="$DESTINATION/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# Cria o backup compactado
echo "Criando backup de $SOURCE_DIR em $BACKUP_FILE..."
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .
echo "Backup concluído em $BACKUP_FILE."
