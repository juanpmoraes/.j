#!/bin/bash

#Script para localizar discos específicos no sistema

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 [-s] [-a] [-o] [-d DISK] [-h]"
    echo "    -s       Localizar discos do sistema"
    echo "    -a       Localizar discos ASM"
    echo "    -o       Localizar outros discos"
    echo "    -d DISK  Localizar um disco específico"
    echo "    -h       Exibir esta ajuda"
    exit 1
}

# Verifica se pelo menos um argumento foi fornecido
if [ $# -eq 0 ]; then
    show_help
fi

# Função para localizar discos do sistema
function locate_system_disks {
    echo "Localizando discos do sistema..."
    lsblk -o NAME,TYPE,SIZE,MOUNTPOINT | grep -E "sda|nvme0n1"
}

# Função para localizar discos ASM
function locate_asm_disks {
    echo "Localizando discos ASM..."
    # Adaptar o comando abaixo para o seu ambiente ASM
    sudo ls -l /dev/oracleasm/disks/
}

# Função para localizar outros discos
function locate_other_disks {
    echo "Localizando outros discos..."
    lsblk -o NAME,TYPE,SIZE,MOUNTPOINT | grep -E "sd[b-z]|nvme[1-9]n1"
}

# Função para localizar um disco específico
function locate_specific_disk {
    echo "Localizando disco específico: $1"
    lsblk -o NAME,TYPE,SIZE,MOUNTPOINT | grep "$1"
}

# Processa os argumentos fornecidos
while getopts "saod:h" opt; do
    case ${opt} in
        s)
            SYSTEM_DISKS=1
            ;;
        a)
            ASM_DISKS=1
            ;;
        o)
            OTHER_DISKS=1
            ;;
        d)
            SPECIFIC_DISK=$OPTARG
            ;;
        h)
            show_help
            ;;
        *)
            show_help
            ;;
    esac
done

# Localiza discos com base nos argumentos fornecidos
if [ ! -z "$SYSTEM_DISKS" ]; then
    locate_system_disks
fi

if [ ! -z "$ASM_DISKS" ]; then
    locate_asm_disks
fi

if [ ! -z "$OTHER_DISKS" ]; then
    locate_other_disks
fi

if [ ! -z "$SPECIFIC_DISK" ]; then
    locate_specific_disk "$SPECIFIC_DISK"
fi

# Exibe mensagem se nenhum tipo de disco foi especificado
if [ -z "$SYSTEM_DISKS" ] && [ -z "$ASM_DISKS" ] && [ -z "$OTHER_DISKS" ] && [ -z "$SPECIFIC_DISK" ]; then
    show_help
fi

