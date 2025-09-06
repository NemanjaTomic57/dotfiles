#!/bin/bash

# Step 1: Prepare your server
sudo apt update && sudo apt upgrade -y
sudo apt install postfix dovecot-core dovecot-imapd dovecot-pop3d -y

# Select Internet Site and enter you domain


# Step 2: Prepare Postfix
# Edit /etc/postfix/main.cf and /etc/postfix/master.cf
# See ./postfix for more information

# Restart
sudo systemctl restart postfix


# Step 3: Configure Dovecot
# Edit /etc/dovecot/dovecot.conf
protocols = imap pop3 lmtp

# Edit /etc/dovecot/conf.d/10-master.conf to enable authentication
service auth {
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
    group = postfix
  }
}

# Edit /etc/dovecot/conf.d/10-ssl.conf for certs
ssl_cert = </etc/letsencrypt/live/tonit.dev/fullchain.pem
ssl_key = </etc/letsencrypt/live/tonit.dev/privkey.pem

# Edit /etc/dovecot/conf.d/10-mail.conf
# mail_driver = mbox
# mail_home = /home/%{user|username}
# mail_path = %{home}/mail
# mail_inbox_path = /var/mail/%{user}
mail_driver = maildir
mail_path = ~/Maildir

# Restart
sudo systemctl restart dovecot


# Step 4: Secure with SSL/TLS
sudo certbot certonly --standalone -d tonit.dev


# Step 5: Create Mail User
useradd -m -s /usr/bin/bash mailuser
passwd mailuser


# Step 6: Open Firewall Ports
sudo apt install ufw
sudo ufw allow 22/tcp
sudo ufw allow 25/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 465/tcp
sudo ufw allow 587/tcp
sudo ufw allow 993/tcp
sudo ufw allow 995/tcp
sudo ufw enable
sudo ufw reload

# Now you can log in via SMTP (e.g. with Thunderbird)
# The username is just the system username, WITHOUT the domain
# Password is the user password
# Ports: 587 SMTP and 993 IMAP


# Step 7: DKIM configuration
sudo apt install opendkim opendkim-tools -y
sudo vim /etc/opendkim.conf

# Generate DKIM Keys
sudo mkdir -p /etc/dkimkeys
cd /etc/dkimkeys
sudo opendkim-genkey -s mail -d tonit.dev
sudo chown opendkim:opendkim mail.private

# Configure KeyTable, SigningTable, TrustedHosts
# /etc/opendkim/KeyTable
mail._domainkey.tonit.dev tonit.dev:mail:/etc/dkimkeys/mail.private
# /etc/opendkim/SigningTable
*@tonit.dev mail._domainkey.tonit.dev
# /etc/opendkim/TrustedHosts
127.0.0.1
localhost
*.tonit.dev

sudo systemctl enable opendkim
sudo systemctl restart opendkim
sudo systemctl restart postfix

# Set DNS Record
mail._domainkey IN TXT ( "v=DKIM1; k=rsa; p=MIIBIjANBgkqh..." ) ; # DKIM key mail for tonit.dev

# Test email delivery
sudo apt install mailutils
echo "This is a test email" | mail -aFrom:debian@tonit.dev -s "Test Email" test-qk5ykkekv@srv1.mail-tester.com

