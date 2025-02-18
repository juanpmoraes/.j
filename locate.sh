#!/bin/bash

# locate.sh - Script para localizar diretórios ou arquivos no sistema

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 [-d DIRETORIO] [-f ARQUIVO] [-h]"
    echo "    -d DIRETORIO    Diretório a ser localizado"
    echo "    -f ARQUIVO      Arquivo a ser localizado"
    echo "    -h              Exibir esta ajuda"
    exit 1
}

# Verifica se pelo menos um argumento foi fornecido
if [ $# -eq 0 ]; then
    show_help
fi

# Processa os argumentos fornecidos
while getopts "d:f:h" opt; do
    case ${opt} in
        d)
            DIRECTORY=$OPTARG
            ;;
        f)
            FILE=$OPTARG
            ;;
        h)
            show_help
            ;;
        *)
            show_help
            ;;
    esac
done

# Função para localizar diretório
function locate_directory {
    echo "Localizando diretório: $1"
    find / -type d -name "$1" 2>/dev/null
}

# Função para localizar arquivo
function locate_file {
    echo "Localizando arquivo: $1"
    find / -type f -name "$1" 2>/dev/null
}

# Localiza o diretório ou arquivo com base nos argumentos fornecidos
if [ ! -z "$DIRECTORY" ]; then
    locate_directory "$DIRECTORY"
fi

if [ ! -z "$FILE" ]; then
    locate_file "$FILE"
fi

# Exibe mensagem se nenhum diretório ou arquivo foi especificado
if [ -z "$DIRECTORY" ] && [ -z "$FILE" ]; then
    show_help
fi

