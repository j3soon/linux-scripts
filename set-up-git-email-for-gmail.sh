#!/bin/bash -e
# Ref: https://stackoverflow.com/a/68238913

sudo apt-get update
sudo apt-get install -y git-email

sudo PERL_MM_USE_DEFAULT=1 cpan Authen::SASL MIME::Base64 Net::SMTP::SSL

read -p "Name: " NAME
read -p "Email: " EMAIL

echo "Follow step 4 of https://stackoverflow.com/a/68238913 to generate an app-specific password."
read -s -p "App-specific Password: " PASSWORD

cat << EOF > ~/.gitconfig
[user]
    name = $NAME
    email = $EMAIL
[sendemail]
    smtpServer = smtp.gmail.com
    smtpServerPort = 587
    smtpEncryption = tls
    smtpUser = $EMAIL
    smtpPass = $PASSWORD
[credential]
    helper = store
EOF

echo "Done."
