#!/bin/bash

# Função para verificar o uso do disco e alertar se necessário
check_disk_usage() {
    # Diretório ou partição que será verificada
    local disk="/"

    # Obtém a porcentagem de uso do disco
    local usage
    usage=$(df -h "$disk" | awk 'NR==2 {gsub("%",""); print $5}')

    # Verifica se o uso está acima de 81%
    if [ "$usage" -gt 81 ]; then
        echo 1  # Retorna 1 se o uso for maior que 81%
        # Enviar alerta para o Zabbix ou outro sistema
        echo "ALERTA: Uso do disco em $disk está acima de 81% ($usage%)"
    else
        echo 0  # Retorna 0 se o uso for menor ou igual a 81%
    fi
}

# Chama a função

