#!/bin/bash

# Verifica se o nome do diretório foi fornecido como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <nome_do_diretorio>"
  exit 1
fi

# Nome do diretório a ser procurado
DIR_NAME=$1

# Diretório inicial da busca (pode ser alterado conforme necessário)
START_DIR="/"

# Executa o comando find para buscar o diretório
find "$START_DIR" -type d -name "$DIR_NAME" 2>/dev/null

# Verifica se o diretório foi encontrado
if [ $? -eq 0 ]; then
  echo "Busca concluída."
else
  echo "Diretório '$DIR_NAME' não encontrado."
fi
