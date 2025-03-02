#!/bin/bash -e
clear
echo
echo "#######################################################################################"
echo "#######################################################################################"
echo "##                                                                                   ##"
echo "##                                                                                   ##"
echo "##                  Automatização de substituição de arquivos                        ##"
echo "##                                                                                   ##"
echo "##                                                                                   ##"
echo "#######################################################################################"
echo "#######################################################################################"
echo "                                                                         Versão: 1.0.8"
echo
read -p "Qual é o nome do arquivo que será levado para o diretorio? " arquivo
read -p "Qual é o nome do zip? " arq_zip
read -p "Qual é o nome do diretorio onde o novo arquivo está? " diretorio_atual
read -p "Para qual diretorio deseja levar o arquivo? " diretorio_dest
read -p "Numero da Change: " change
echo
sleep 1
cd $diretorio_dest
ls -ltra $arquivo
cd $diretorio_atual
ls -ltra $arq_zip*
mkdir ~/arq_antigo || ls -ltra ~/arq_antigo
clear
echo
echo "#######################################################################################"
echo "#######################################################################################"
echo "##                                                                                   ##"
echo "##                                                                                   ##"
echo "##                  Automatização de substituição de arquivos                        ##"
echo "##                                                                                   ##"
echo "##                                                                                   ##"
echo "#######################################################################################"
echo "#######################################################################################"
echo "                                                                         Versão: 1.0.8"
echo "+----------------------------------------------------------+"
echo "| Change: "$(echo $change)
echo "| Arquivo: "$(echo $arquivo)
echo "| Arquivo ZIP: "$(echo $arq_zip)
echo "| Diretorio origem: "$(echo $diretorio_atual)
echo "| Diretorio destino: "$(echo $diretorio_dest)
echo "+----------------------------------------------------------+"
sleep 1
echo
cd $diretorio_dest
echo "Acessando o diretou que estao o arquivo atual"
echo
echo "Fazendo Backup do "$arquivo" atual, no diretorio: "$diretorio_dest
sleep 1
mv $arquivo $arquivo.$(date|cut -c5-19|tr " " "_"|tr ":" "_")_$change".bkp" && ls -ltra $arquivo.$(date|cut -c5-19|tr " " "_"|tr ":" "_")_$change".bkp" > ~/arq_antigo/arq_antigo.txt
echo
echo -e "\aArquivo gerado com sucesso!"
echo
cat ~/arq_antigo/arq_antigo.txt
echo
cd $diretorio_atual
echo ""
ls -ltra $diretorio_atual/$arq_zip*
echo
echo "Validando existencia do: $(ls -l $arq_zip*)"
echo
sleep 1
unzip -l $arq_zip*
echo
echo "Descompactando: $(ls -l $arq_zip*)"
sleep 1
echo
unzip $arq_zip*
cd $arq_zip || ls -ltra $arquivo
echo
cat ~/arq_antigo/arq_antigo.txt
echo
read -p "Qual sera á permissão do chmod? " perm
echo
read -p "Tem certeza que a permiçao será $perm (s/n)? " resposta
        if [[ "$resposta" == "s" || "$resposta" == "S" ]]; then
                echo "Você escolheu continuar."
fi
echo
echo "Dando a permissão!"
sleep 1
chmod $perm $arquivo
echo
echo "Nova permição é: $(ls -l $arquivo)"
echo
read -p "Qual sera o owner do arquivo? " own
read -p "Qual sera o grupo do arquivo? " grupo
echo
 read -p "Tem certeza que é o owner e o grupo é $own:$grupo (s/n)? " resposta2
if [[ "$resposta2" == "s" || "$resposta2" == "S" ]]; then
    echo "Alterando owner e o grupo!"
fi
sleep 1
chown $own:$grupo $arquivo
echo
echo "tranferindo arquivo $arquivo para o diretorio $diretorio_dest"
sleep 1
mv $arquivo $diretorio_dest/$arquivo
echo
echo "Tranferido com sucesso"
echo
cd $diretorio_dest
echo "Validando se o arquivo esta no diretorio correto"
echo
echo "Diretorio atual: $(pwd) | Diretorio onde deve estar o arquivo: $diretorio_dest"
echo
cd $diretorio_atual
rm -rf $arq_zip
echo
echo "+------------------------------------------------------------------------------------------------+"
echo "| Change: "$(echo $change)" - "$(date)
echo "| Arquivo: "$(echo $arquivo)
echo "| Arquivo ZIP: "$(echo $arq_zip)."zip"
echo "| Diretorio origem: "$(echo $diretorio_atual)
echo "| Diretorio destino: "$(echo $diretorio_dest)
echo "+------------------------------------------------------------------------------------------------+"
echo "| Arquivo novo:   $(ls -l $diretorio_dest/$arquivo)"
echo "| Arquivi antigo: $(cat ~/arq_antigo/arq_antigo.txt)"
echo "+------------------------------------------------------------------------------------------------+"
echo
