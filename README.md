# bhsendmail
Send email via mail utility in alpine

## Setup
```
docker build -t bhsendemail:latest .
```

## Usage
Send an email from `test@gmail.com` with a specific `<app-password>`
```
docker run --rm bhsendmail:latest test@gmail.com <app-password> test@gmail.com "Test" receiver@gmail.com "Subject" "Email body"
```
