FROM ubuntu:bionic

ENV MONGODB_VERSION=4.2.3

RUN apt-get update \
    && apt-get install -y curl gnupg \
    && curl https://www.mongodb.org/static/pgp/server-4.2.asc -o - | apt-key add - \
    && echo 'deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse' > /etc/apt/sources.list.d/mongodb.list \
    && apt-get update \
    && apt-get install -y mongodb-org-tools=$MONGODB_VERSION s3cmd ca-certificates

WORKDIR /root/

ADD backup.sh /root/

RUN chmod +x backup.sh

CMD /root/backup.sh
