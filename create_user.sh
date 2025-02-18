#!/bin/bash

# create_user.sh - Script para automatizar a criação de usuário

# Função para exibir a ajuda do script
function show_help {
    echo "Uso: $0 OPCOES"
    echo "    -u USUARIO         Nome do usuário a ser criado (obrigatório)"
    echo "    -d DIRETORIO       Diretório inicial do usuário (padrão: /home/USUARIO)"
    echo "    -s SHELL           Shell padrão do usuário (padrão: /bin/bash)"
    echo "    -c COMENTARIO      Comentário para o usuário (opcional)"
    echo "    -h                 Exibir esta ajuda"
    exit 1
}

# Verifica se foram fornecidos argumentos
if [ $# -eq 0 ]; then
    show_help
fi

# Variáveis padrão
DIR_HOME="/home"
DEFAULT_SHELL="/bin/bash"

# Captura dos argumentos
while getopts "u:d:s:c:h" opt; do
    case ${opt} in
        u)
            USERNAME=$OPTARG
            ;;
        d)
            DIR_HOME=$OPTARG
            ;;
        s)
            DEFAULT_SHELL=$OPTARG
            ;;
        c)
            COMMENT=$OPTARG
            ;;
        h)
            show_help
            ;;
        *)
            show_help
            ;;
    esac
done

# Verifica se o nome de usuário foi especificado
if [ -z "$USERNAME" ]; then
    echo "Erro: Nome de usuário não especificado."
    show_help
fi

# Cria o usuário
echo "Criando usuário $USERNAME..."

# Comando para criação do usuário
useradd -m -d "$DIR_HOME/$USERNAME" -s "$DEFAULT_SHELL" -c "${COMMENT:-}" "$USERNAME"

# Verifica se o usuário foi criado com sucesso
if [ $? -eq 0 ]; then
    echo "Usuário $USERNAME criado com sucesso."
else
    echo "Erro ao criar usuário $USERNAME."
fi
