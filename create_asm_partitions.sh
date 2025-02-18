#!/bin/bash

# create_asm_partitions.sh - Script para criar partições em discos ASM

##########################################################
##                                                      ##
##           Reconhecendo Discos ASM no SO              ##
##                                                      ##
##########################################################

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 [-d DISK1,DISK2,DISK3,...] [-h]"
    echo "    -d DISKS   Lista de discos separados por vírgulas (e.g., /dev/sdb,/dev/sdc)"
    echo "    -h         Exibir esta ajuda"
    exit 1
}

# Verifica se pelo menos um argumento foi fornecido
if [ $# -eq 0 ]; then
    show_help
fi

# Processa os argumentos fornecidos
while getopts "d:h" opt; do
    case ${opt} in
        d)
            IFS=',' read -r -a DISKS <<< "$OPTARG"
            ;;
        h)
            show_help
            ;;
        *)
            show_help
            ;;
    esac
done

# Função para criar partição em um disco
function create_partition {
    local DISK=$1
    echo "Criando partição no disco: $DISK"
    (
        echo n    # Adicionar uma nova partição
        echo p    # Partição primária
        echo 1    # Número da partição
        echo      # Usar o valor padrão para o primeiro setor
        echo      # Usar o valor padrão para o último setor
        echo p    # Exibir a tabela de partições
        echo w    # Escrever alterações e sair
    ) | fdisk $DISK
}

# Cria partições nos discos fornecidos
for DISK in "${DISKS[@]}"; do
    create_partition "$DISK"
done

# Exibe os discos e suas novas partições
echo "Verificando discos e partições:"
ls -l /dev/sd*

# Mensagem final
echo "Partições criadas com sucesso nos discos especificados."

