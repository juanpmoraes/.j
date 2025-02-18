#!/bin/bash

# Array com os nomes dos bancos de dados
databases=("oemdb" "orcldb" "juandb" "xpdb")

lsnrctl stop || lsnrctl status

for DB in "${databases[@]}"; do
    # Configurar ORACLE_SID
    unset ORACLE_SID
    export ORACLE_SID=$DB
echo
   # Tentar iniciar o banco de dados
    result=$(sqlplus -s / as sysdba <<EOF
shut immediate
EXIT;
EOF
)

    # Verifica o status da execução
    if [[ $? -ne 0 ]]; then
        echo "Erro: Banco de dados não encontrado ou falha de conexão: $DB"
    else
        echo "Banco: $DB desligado com sucesso."
    fi

    echo "---------------------------------"
done
echo
