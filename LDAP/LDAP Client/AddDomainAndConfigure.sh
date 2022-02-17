#!/bin/bash
# A simple Bash script
sudo apt update -y
sudo apt-get install wget
sudo wget -P /etc/ldap 192.168.1.2/ad.crt
sudo cp /etc/ldap/ad.crt /usr/local/share/ca-certificates
sudo update-ca-certificates
sudo pam-auth-update
sudo rm /etc/ldap/ldap.conf
sudo wget -P /etc/ldap 192.168.1.2/ldap.conf
sudo chmod 777 /etc/ldap/ad.crt
sudo apt install sssd libpam-sss libnss-sss sssd-tools libsss-sudo
sudo wget -P /etc/sssd 192.168.1.2/sssd.conf
sudo chmod 600 -R /etc/sssd
sudo wget -P /usr/local/bin 192.168.1.2/fetchSSHKeysFromLDAP
sudo chmod +x /usr/local/bin/fetchSSHKeysFromLDAP
sudo echo -e "\nAuthorizedKeysCommand /usr/local/bin/fetchSSHKeysFromLDAP\nAuthorizedKeysCommandUser nobody\n" >> /etc/ssh/sshd_config
sudo systemctl restart sssd
sudo systemctl restart sshd
echo Done!