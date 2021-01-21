FROM alpine:latest
LABEL maintainer=manasmbellani

RUN apk add --update \
    bash \
    curl \
    ssmtp \
    man-pages \
    mandoc \
    less \
    less-doc \
    mailx \
    vim \
    sed

COPY . /app
WORKDIR /app

ENTRYPOINT [ "/bin/bash", "send_email.sh" ]
