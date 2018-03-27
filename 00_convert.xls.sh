#!/usr/bin/env bash

# Necessário para simplificar a análise.
# quando as tabelas são baixadas do sisvan, na verdade o arquivo é um html com extensão xls
cd dados/
echo "removing csv"
rm -f dados/*.csv
echo "converting xls to csv"
# Sudo needed for conversion. Not sure why.
sudo su -c 'for i in *.xls; do  echo "processing $i"; libreoffice --headless --convert-to csv "$i" ; chown $USER:$USER "$i"; done'
cd -
echo "done"
