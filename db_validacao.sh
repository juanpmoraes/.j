#!/bin/bash -e
clear
echo
echo "#######################################################################"
echo "#######################################################################"
echo "####                                                               ####"
echo "#### Nome: db_validação                                            ####"
echo "####                                                               ####"
echo "#### Descrição: Valida se a DB está ligada                         ####"
echo "####                                                               ####"
echo "#### Autor = Juan Pablo                                            ####"
echo "#### Data de criação: 08/10/2024                                   ####"
echo "####                                                               ####"
echo "#### VERSION: 1.4                                                  ####"
echo "####                                                               ####"
echo "#######################################################################"
echo "#######################################################################"
echo "| ORACLE_HOME: $(echo $ORACLE_HOME) | ORACLE_SID: $(echo $ORACLE_SID) |"
echo "| Você está com o usuário: $(whoami)"
echo
echo "Validando acesso!"
sleep 2
if [ "$(whoami)" != "oracle" ]; then
  echo
  echo "Você precisa estar logado como oracle para executar esse script."
  exit
fi
sleep 1
echo
echo "Acessando a base de dados $(echo $ORACLE_SID)"
sleep 2
sqlplus / as sysdba << EOF
spool sets.out
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0
spool off
spool results.out
select * from db_status;
spool off
exit;
EOF
sleep 1
echo
echo "Base de dados validada com sucesso"
echo
echo "O status da base de dados é:"
echo
sleep 1
cat /tmp/.j/results.out|grep "ACTIVE"
echo "---------------------------------"
echo
