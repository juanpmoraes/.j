#!/bin/bash
echo “Boas vindas ao script: Backup de Arquivos”
read -p “Insira o caminho do diretório para backup: ” src
read -p “Insira o caminho onde o backup será armazenado: ” dest
tar -czf “$dest/backup-$(date +’%Y%m%d’).tar.gz” “$src”
echo “Backup completo em $dest.”