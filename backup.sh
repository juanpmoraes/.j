#!/bin/bash

# backup.sh - Script para criar backup de um diretório

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 DIRETORIO_ORIGEM DIRETORIO_DESTINO"
    echo "    DIRETORIO_ORIGEM   Diretório que será feito o backup"
    echo "    DIRETORIO_DESTINO  Diretório onde o backup será salvo"
    exit 1
}

# Verifica se foram fornecidos exatamente dois argumentos
if [ $# -ne 2 ]; then
    show_help
fi

# Armazena os argumentos
SRC_DIR=$1
DEST_DIR=$2
BACKUP_NAME=$(basename "$SRC_DIR")_$(date +%Y%m%d%H%M%S).tar.gz

# Cria o backup
echo "Criando backup de $SRC_DIR em $DEST_DIR/$BACKUP_NAME..."
tar -czf "$DEST_DIR/$BACKUP_NAME" -C "$SRC_DIR" .

# Verifica se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
    echo "Backup criado com sucesso!"
else
    echo "Erro ao criar o backup."
fi
