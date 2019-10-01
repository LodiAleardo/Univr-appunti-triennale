#!/bin/sh
# Script per l'installazione di SIS su macOS

# 1) controllo se esiste /usr/local, altrimenti la creo
# (su alcune vecchie versioni di OSX non é presente di default)
if [ ! -d "/usr/local" ]; then
    sudo mkdir /usr/local
fi

# 2) Copia della directory in /usr/local
sudo cp -r ./sis /usr/local

# 3) Impostazione del path della bash 
echo 'export PATH="$PATH:/usr/local/sis/bin"' >> ~/.bashrc
echo 'export MANPATH="$MANPATH:/usr/local/sis/man"' >> ~/.bashrc

# 4) installazione terminata
echo "Installazione terminata!"
echo "NB: per utilizzare sis, riaprire la shell e digitare sis!"
