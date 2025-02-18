#!/bin/bash

# Executa um comando como o usuário 'juan' usando SSH
ssh juan@localhost <<EOF
echo "Executando como usuário juan"
whoami
exit
EOF

