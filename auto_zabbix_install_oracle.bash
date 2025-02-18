#!/bin/bash -e
clear
echo
echo '#############################################################'
echo '##                                                         ##'
echo '##    Automatização de instalação do Zabbix no Oracle 8    ##'
echo '##                                                         ##'
echo '#############################################################'
echo
read -p "Você deseja instalar o Zabbix nesta máquina? (s/S para continuar): " RESPOSTA

if [[ "$RESPOSTA" != "s" && "$RESPOSTA" != "S" ]]; then
    echo "Saindo do script."
    exit 0
fi

echo
echo "Instalando os repositórios do Zabbix"
sleep 1
rpm -Uvh https://repo.zabbix.com/zabbix/7.0/oracle/8/x86_64/zabbix-release-latest.el8.noarch.rpm && dnf clean all
sleep 1
echo
echo "Repositório instalado com sucesso"
echo
echo "Alterando a versão do módulo DNF para PHP"
sleep 1
dnf module switch-to php:8.2 -y
sleep 1
echo "Alterado com sucesso"
echo
echo "Instalando o servidor, o frontend e o agente Zabbix"
sleep 1
dnf install zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent -y
echo
echo "Instalado com sucesso"
echo
echo "Instalando o MySQL"
sleep 1
yum install mysql-server -y
systemctl start mysqld
systemctl status mysqld
systemctl enable mysqld --now
echo
echo "MySQL instalado com sucesso"
echo
echo "Configurando o banco de dados do Zabbix"
mysql -uroot -p <<EOF
CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'oracle';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
FLUSH PRIVILEGES;
EOF
echo
echo "Banco de dados do Zabbix configurado com sucesso"
echo
echo "Importando o esquema inicial do Zabbix para o banco de dados"
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p'oracle' zabbix
echo
echo "Esquema do banco de dados importado com sucesso"
echo
echo "Configurando o arquivo zabbix_server.conf"
sed -i 's/^DBPassword=.*/DBPassword=oracle/' /etc/zabbix/zabbix_server.conf
echo
echo "Arquivo zabbix_server.conf configurado"
echo
echo "Iniciando e habilitando os serviços do Zabbix e Apache"
systemctl enable zabbix-server zabbix-agent httpd
systemctl start zabbix-server zabbix-agent httpd
echo
echo "Todos os serviços foram iniciados e habilitados com sucesso"
echo
echo "Instalação do Zabbix completa! Acesse o frontend via seu navegador."
