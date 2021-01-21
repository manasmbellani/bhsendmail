#!/bin/bash
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
SMTP_CONFIG_FILE="/etc/ssmtp/ssmtp.conf"
USAGE="[-] $0 <smtp_username> <smtp_password> <sender> <sender_name> <recipients> <subject> <body> [smtp_server=$SMTP_SERVER] [smtp_port=$SMTP_PORT]" 
BASH_PATH="/bin/bash"

if [ $# -lt 7 ]; then
    echo "$USAGE"
    exit 1
fi
smtp_username="$1"
smtp_password="$2"
sender="$3"
sender_name="$4"
recipients_list="$5"
subject="$6"
body="$7"
smtp_server=${8:-"$SMTP_SERVER"}
smtp_port=${9:-"$SMTP_PORT"}

if [ -f "$recipients_list" ]; then
    echo "[*] Listing all recipients from file: $recipients_list"
    recipients=$(cat "$recipients_list" | tr -s "\r\n" " ")
    recipients_comma=$(cat "$recipients_list" | tr -s "\r\n" ",")
else
    echo "[*] Listing all recipients from list: $recipients_list"
    recipients=$(echo "$recipients_list" | tr -s "," " ")
    recipients_comma="$recipients_list"
fi

if [ -f "$body" ]; then
    echo "[*] Reading body from file: $body"
    body_str=$(cat "$body")
else
    echo "[*] Reading body as str: $body"
    body_str="$body"
fi

echo "[*] Setting the username for root to: $sender_name in /etc/passwd"
tmp_file=$(mktemp -u)
cat /etc/passwd  | sed -r "s/root:[^:]+:[^:]+:[^:]+:[^:]+/root:x:0:0:$sender_name/g" > "$tmp_file"
mv "$tmp_file" /etc/passwd

echo "[*] Setting the SMTP configuration: $SMTP_CONFIG_FILE in smtp confguration file"
cat > /etc/ssmtp/ssmtp.conf <<EOF
root=$sender_name
mailhub=$smtp_server:$smtp_port
FromLineOverride=YES
AuthUser=$smtp_username
AuthPass=$smtp_password
UseTLS=YES
UseSTARTTLS=YES
EOF

echo "[*] Creating temp file for preparing message to send"
tmp_file=$(mktemp -u)

echo "[*] Writing to temporary file: $tmp_file"
cat > $tmp_file <<EOF
To: $recipients_comma
From: $sender
Subject: $subject

$body_str
EOF

echo "[*] Sending mail to recipients: $recipients_comma"
cat "$tmp_file" | ssmtp "$recipients"

echo "[*] Clearing $tmp_file" 
rm "$tmp_file"

