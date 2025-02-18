#!/bin/bash

# top_custom.sh - Script para exibir informações detalhadas do sistema com o comando top

# Definindo variáveis de configuração
DELAY=1      # Intervalo de atualização em segundos
ITERATIONS=0 # Número de iterações (0 para infinito)
SORT_COLUMN=9 # Coluna padrão para classificação (uso de CPU)

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 [OPCOES]"
    echo "    -n NUM   Número de iterações do top (padrão: 0 - infinito)"
    echo "    -d DELAY Intervalo de atualização em segundos (padrão: 1)"
    echo "    -s COL   Coluna para ordenação inicial (padrão: 9 - CPU)"
    echo "    -h       Exibir esta ajuda"
    exit 1
}

# Verificando os argumentos fornecidos
while getopts "n:d:s:h" opt; do
    case ${opt} in
        n)
            ITERATIONS=$OPTARG
            ;;
        d)
            DELAY=$OPTARG
            ;;
        s)
            SORT_COLUMN=$OPTARG
            ;;
        h)
            show_help
            ;;
        *)
            show_help
            ;;
    esac
done

# Executando o comando top com as opções configuradas
top -b -n $ITERATIONS -d $DELAY -o $SORT_COLUMN
