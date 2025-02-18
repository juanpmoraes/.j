#!/bin/bash
echo “Boas vindas ao script: Contagem de Arquivos”
read -p “Insira o caminho do diretório: ” dir
count=$(ls -1 $dir | wc -l)
echo “O diretório $dir contém $count arquivos.”