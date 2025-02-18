#!/b

# Define o arquivo de log com data e hora no nome
 arquivo de log com data e hora no nome
LOG_FILE="execucao_$(date '+%Y_%m_%d_%H_%M_%S').log"

# Cria ou limpa o arquivo de log
> "$LOG_FILE"

# Verifica se o arquivo dbs.txt existe
if [[ ! -f dbs.txt ]]; then
    echo "Erro: Arquivo dbs.txt não encontrado." | tee -a "$LOG_FILE"
    echo "Log gerado em: $(realpath "$LOG_FILE")"
    exit 1
fi

# Lê as conexões do arquivo dbs.txt
DB_LIST=($(cat dbs.txt))

echo | tee -a "$LOG_FILE"
# Itera sobre cada conexão e executa o comando SQL
for DB in "${DB_LIST[@]}"; do
    echo "Conectando ao banco: $DB" | tee -a "$LOG_FILE"

    # Executa o comando SQL e captura a saída
    RESULT=$(sqlplus -s "$DB" <<EOF
WHENEVER SQLERROR EXIT FAILURE;
SET HEADING OFF
SET FEEDBACK OFF
select sysdate from dual;
EXIT;
EOF
    2>&1) # Redireciona erros também para o log

    # Verifica o status da execução
    if [[ $? -ne 0 ]]; then
        echo "Erro: Banco de dados não encontrado ou falha de conexão: $DB" | tee -a "$LOG_FILE"
    else
        echo "Data atual no banco $DB: $RESULT" | tee -a "$LOG_FILE"
    fi

    echo "---------------------------------" | tee -a "$LOG_FILE"
done

# Exibe o caminho completo do log gerado
echo "Log gerado em: $(realpath "$LOG_FILE")"
echo
