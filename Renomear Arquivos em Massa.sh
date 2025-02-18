#!/bin/bash
echo “Boas vindas ao script: Renomeando Arquivos”
read -p “Insira o caminho do diretório: ” dir
for file in “$dir”/*.md; do
mv”$file””${file%.md}_old.md”
done
echo “Arquivos renomeados com sucesso.”