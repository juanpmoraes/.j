#!/bin/bash

# clean_tmp.sh - Script para limpar arquivos temporários

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 DIRETORIO"
    echo "    DIRETORIO   Diretório onde os arquivos temporários serão limpos"
    exit 1
}

# Verifica se foi fornecido exatamente um argumento
if [ $# -ne 1 ]; then
    show_help
fi

# Armazena o argumento
DIR=$1

# Limpa arquivos temporários
echo "Limpando arquivos temporários em $DIR..."
find "$DIR" -type f -name '*.tmp' -exec rm -f {} +

# Verifica se a limpeza foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Arquivos temporários limpos com sucesso!"
else
    echo "Erro ao limpar arquivos temporários."
fi
