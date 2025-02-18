#!/bin/bash -e
clear
echo
echo '#############################################################'
echo '##                                                         ##'
echo '##     Automatização de instalação do Zabbix no Debian     ##'
echo '##                                                         ##'
echo '#############################################################'
echo
read -p "Você deseja instalar o Zabbix nesta máquina Debian? (s/S para continuar): " RESPOSTA

if [[ "$RESPOSTA" != "s" && "$RESPOSTA" != "S" ]]; then
    echo "Saindo do script."
    exit 0
fi

echo
echo "Instalando o repositório do Zabbix"
sleep 1
wget -4 https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_latest+debian12_all.deb
dpkg -i zabbix-release_latest+debian12_all.deb
apt update
sleep 1
echo
echo "Repositório instalado com sucesso"
echo
echo "Instalando o servidor, o frontend e o agente Zabbix"
sleep 1
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
echo
sleep 1
echo "Instalado com sucesso"
echo
echo "Instalando o MariaDB-server"
sleep 1
apt install -y mariadb-server
echo
echo "MariaDB instalado com sucesso"
echo
sleep 1
echo "Configurando o banco de dados do Zabbix"
mysql -uroot -p <<EOF
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'zabbix';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
FLUSH PRIVILEGES;
EOF
echo
echo "Banco de dados do Zabbix configurado com sucesso"
echo
echo "Importando o esquema inicial do Zabbix para o banco de dados"
echo "A senha do banco de dados zabbix é: zabbix"
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
echo
echo "Esquema do banco de dados importado com sucesso"
echo
echo "Desativando log_bin_trust_function_creators"
mysql -uroot <<EOF
set global log_bin_trust_function_creators = 0;
EOF
echo
echo "Configurando o arquivo zabbix_server.conf"
sed -i 's/^Hostname=.*/Hostname=Zabbix-server/' /etc/zabbix/zabbix_server.conf
sed -i 's/^DBPassword=.*/DBPassword=oracle/' /etc/zabbix/zabbix_server.conf
sed -i 's/^DBName=.*/DBName=zabbix/' /etc/zabbix/zabbix_server.conf
sed -i 's/^DBUser=.*/DBUser=zabbix/' /etc/zabbix/zabbix_server.conf
echo
echo "Arquivo zabbix_server.conf configurado"
echo
echo "Iniciando e habilitando os serviços do Zabbix e Apache"
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
echo
echo "Todos os serviços foram iniciados e habilitados com sucesso"
echo
echo "Instalação do Zabbix completa! Acesse o frontend via seu navegador."
echo
IP_SERVIDOR=$(hostname -I | awk '{print $1}')
echo "Acesse http://$IP_SERVIDOR/zabbix"
