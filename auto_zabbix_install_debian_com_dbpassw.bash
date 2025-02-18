#!/bin/bash -e
clear
echo
echo '#############################################################'
echo '##                                                         ##'
echo '##     Automatização de instalação do Zabbix no Debian     ##'
echo '##                                                         ##'
echo '#############################################################'
echo

# Confirmação de instalação
read -p "Você deseja instalar o Zabbix nesta máquina Debian? (s/S para continuar): " RESPOSTA

if [[ "$RESPOSTA" != "s" && "$RESPOSTA" != "S" ]]; then
    echo "Saindo do script."
    exit 0
fi

# Verificação de dependências
if ! command -v wget &> /dev/null || ! command -v dpkg &> /dev/null; then
    echo "wget e dpkg são necessários. Instale-os e tente novamente."
    exit 1
fi

# Solicita a senha do MySQL root uma vez
echo
read -sp "Digite a senha do MySQL root: " MYSQL_ROOT_PASSWORD
echo

# Instalação do repositório Zabbix
echo "Instalando o repositório do Zabbix"
sleep 1
wget -4 https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_latest+debian12_all.deb
dpkg -i zabbix-release_latest+debian12_all.deb
apt update
rm zabbix-release_latest+debian12_all.deb
echo "Repositório instalado com sucesso"
echo

# Instalação do Zabbix e dependências
echo "Instalando o servidor, o frontend e o agente Zabbix"
sleep 1
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
echo "Instalação do Zabbix concluída"
echo

# Instalação do MariaDB
echo "Instalando o MariaDB-server"
sleep 1
apt install -y mariadb-server
echo "MariaDB instalado com sucesso"
echo

# Configuração do banco de dados
echo "Configurando o banco de dados do Zabbix"
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
SET GLOBAL log_bin_trust_function_creators = 1;
FLUSH PRIVILEGES;
EOF
echo "Banco de dados do Zabbix configurado com sucesso"
echo

# Importação do esquema inicial
echo "Importando o esquema inicial do Zabbix para o banco de dados"
echo "A senha é: zabbix"
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -poracle zabbix
echo "Esquema do banco de dados importado com sucesso"
echo

# Desativação de log_bin_trust_function_creators
echo "Desativando log_bin_trust_function_creators"
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SET GLOBAL log_bin_trust_function_creators = 0;"
echo

# Configuração do zabbix_server.conf
echo "Configurando o arquivo zabbix_server.conf"
sed -i 's/^DBPassword=.*/DBPassword=oracle/' /etc/zabbix/zabbix_server.conf
sed -i 's/^DBName=.*/DBName=zabbix/' /etc/zabbix/zabbix_server.conf
sed -i 's/^DBUser=.*/DBUser=zabbix/' /etc/zabbix/zabbix_server.conf
echo "Arquivo zabbix_server.conf configurado"
echo

# Início e habilitação dos serviços
echo "Iniciando e habilitando os serviços do Zabbix e Apache"
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
echo "Todos os serviços foram iniciados e habilitados com sucesso"
echo

# Informações finais
echo "Instalação do Zabbix completa! Acesse o frontend via seu navegador."
IP_SERVIDOR=$(hostname -I | awk '{print $1}')
echo "Acesse http://$IP_SERVIDOR/zabbix"
