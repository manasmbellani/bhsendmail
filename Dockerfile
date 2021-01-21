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
    vim

ENTRYPOINT [ "/bin/bash" ]
