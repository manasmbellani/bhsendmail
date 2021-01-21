# bhsendmail
Send email via mail utility in alpine Docker through Google's SMTP servers.

## Pre-requisite
Requires an App password to be setup for Google Account with 2FA enabled.

## Setup
```
docker build -t bhsendemail:latest .
```

## Usage
Send an email from `sender@gmail.com` with a specific `<app-password>`
```
docker run --rm bhsendmail:latest sender@gmail.com <app-password> sender@gmail.com "Sender" receiver@gmail.com "Subject" "Email body"
```
