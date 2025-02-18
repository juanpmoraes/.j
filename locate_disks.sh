#!/bin/bash

# locate_disks.sh - Script para localizar discos no sistema

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 [-h]"
    echo "    -h    Exibir esta ajuda"
    exit 1
}

# Processa os argumentos fornecidos
while getopts "h" opt; do
    case ${opt} in
        h)
            show_help
            ;;
        *)
            show_help
            ;;
    esac
done

# Verifica se nenhum argumento foi fornecido
if [ $# -eq 0 ]; then
    show_help
fi

# Função para localizar discos
function locate_disks {
    echo "Localizando discos no sistema..."

    # Usando lsblk para listar blocos de dispositivos
    echo -e "\nUsando lsblk:"
    lsblk

    # Usando fdisk para listar tabelas de partições de todos os discos
    echo -e "\nUsando fdisk:"
    sudo fdisk -l

    # Usando lshw para obter informações detalhadas sobre hardware
    echo -e "\nUsando lshw (pode exigir permissões sudo):"
    sudo lshw -class disk -short
}

# Localiza discos no sistema
locate_disks

