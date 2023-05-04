#!/bin/bash

# Esse script deve funcionar para a maioria das instalações, mas caso não funcione por completo, faça os ajustes necessários.
# Autor: Rodrigus Feitosa
# Data: 03-05-2023

echo "Baixando a chave de assinatura do repositorio"
wget -qO- https://www.bacula.org/downloads/Bacula-4096-Distribution-Verification-key.asc \
        | gpg --dearmor | tee /usr/share/keyrings/bacula-archive-keyring.gpg

# Defina o endereço do repositorio com a versao mais proxima da versao do SO cliente. Versoes disponiveis para distro Debian/Ubuntu:
# Debian -> bullseye (11.0), buster (10.0)
# Ubuntu -> focal (20.04), jammy (22.04)

DISTRO=bullseye

echo "Instalando dependências"
apt-get install -y apt-transport-https

echo "Adicionando o repositorio do Bacula na lista do apt"
echo "deb [signed-by=/usr/share/keyrings/bacula-archive-keyring.gpg] https://www.bacula.org/packages/64393bc3a8bf5/debs/13.0.2 $DISTRO main" > /etc/apt/sources.list.d/bacula-community.list

echo "Atualizando o repositorio local e instalando dependências"
apt-get update | apt-get install -y apt-transport-https

echo "Instalando o Bacula Client"
apt-get install -y bacula-client

echo " "
echo "Instalação finalizada."

echo " "
echo "Pre-configurando o File Daemon do cliente"
cp /etc/bacula/bacula-fd.conf /etc/bacula/bacula-fd.conf.bkp
sed -i s/$(hostname -s)-dir/bacula-dir/g /etc/bacula/bacula-fd.conf
sed -i s/$(hostname -s)-mon/bacula-mon/g /etc/bacula/bacula-fd.conf

echo " "
echo "Recarregando o Bacula Client"
service bacula-fd force-reload

echo " "
echo " "
echo "*************************************************************************************"
echo "*                                   IMPORTANTE                                      "
echo "*                                                                                   "
echo "* 1 - Informe ao Administrador do Backup o Nome, Password e IP deste cliente.       "
echo "*     Nome = `hostname -s`-fd                                                       "
echo "*   `cat /etc/bacula/bacula-fd.conf | grep -m 1 Password`                           "
echo "*                                                                                   "
echo "* 2 - Altere o parâmetro FDaddress no arquivo /etc/bacula/bacula-fd.conf informando "
echo "*     o endereço local que será ser usado para a comunicação com o Bacula Director  "
echo "*                                                                                   "
echo "* Em caso de dúvidas, entre em contato com o Administrador de Backup local          "
echo "*                                                                                   "
echo "*************************************************************************************"

