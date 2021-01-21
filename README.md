# bhsendmail
Send email via mail utility in alpine

## Setup
```
docker build -t bhsendemail:latest .
```

## Usage
Send an email from `sender@gmail.com` with a specific `<app-password>`
```
docker run --rm bhsendmail:latest sender@gmail.com <app-password> sender@gmail.com "Sender" receiver@gmail.com "Subject" "Email body"
```
