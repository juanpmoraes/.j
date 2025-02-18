clear
echo "#############################################################"
echo "##                                                         ##"
echo "##                    Primeiro script                      ##"
echo "##                                                         ##"
echo "#############################################################"
echo
echo "+-----------------------------------------------------------+"
echo '|  Está executando com o usuário: $(whoami)'
echo "+-----------------------------------------------------------+"

# Faz a pergunta
read -p "Você deseja continuar? (s/n): " resposta

# Verifica a resposta
if [[ "$resposta" == "s" || "$resposta" == "S" ]]; then
    echo "Você escolheu continuar."
    echo
    mkdir -p /home/juan/teste_script && cd /home/juan/teste_script && for i in {1..50}; do echo Linha "$i" >> Linhas.txt ; done
    echo
    echo "Criou o diretório teste_script e adicionou o arquivo Linhas.txt"
    echo
    chmod -R 770 /home/juan/teste_script
    echo
    echo "Deu a permissão 770 de forma recursiva"
    echo
    mkdir -p teste2/teste5 && cd teste2/teste5 && for i in {1..500}; do echo Linha "$i" >> Linhas.txt ; done
    echo
    echo "Criou os diretórios teste2/teste5 e adicionou o arquivo Linhas.txt"
    echo
    cat Linhas.txt > ok.txt 2> erro.txt
    echo
    echo "Leu o arquivo Linhas.txt e colocou a saída positiva em ok.txt e a saída de erro em erro.txt"
    echo
    df -h >> ok.txt 2>> erro.txt
    echo
    echo "Verificou os espaços dos diretórios principais e adicionou ao arquivo ok.txt"
    echo
    chown -R juan:dba /home/juan/teste_script
    echo
    echo "Mudando o diretorio /home/juan/teste_script para o usuario juan e o grupo dba."
    echo
"primeiro_script.sh" 50L, 1920C
