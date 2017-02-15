FROM alexadhy/rpi-alpine:3.3

MAINTAINER Alexander Adhyatma <alexadhyatma@mail.ru>

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache bash coreutils postgresql=9.4.11-r0 curl && \
    curl -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-armhf" && \
    chmod +x /usr/local/bin/gosu && \
    apk del curl

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV LANG en_US.utf8

RUN mkdir /docker-entrypoint-initdb.d

ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
