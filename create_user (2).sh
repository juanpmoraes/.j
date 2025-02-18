#!/bin/bash
#Criar usuário e senha
echo “Boas vindas ao script: Criando usuário e senha”
read -p “Insira o nome do usuário: ” username
read -sp “Insira a senha do usuário: ” password
echo
password_hash=$(openssl passwd -1 “$password”)
sudo useradd -m -p “$password_hash” -d /home/”$username” -s /bin/bash “$username”
if [ $? -eq 0 ]; then
echo”Usuário $username criado com sucesso!”
else
echo”Ocorreu um erro ao criar o usuário.”
fi