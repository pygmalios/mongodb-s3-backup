FROM ubuntu:14.04

ENV MONGODB_VERSION=3.4.19

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv BC711F9BA15703C6 \
    && echo 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse' > /etc/apt/sources.list.d/mongodb.list \
    && apt-get update \
    && apt-get install -y mongodb-org-tools=$MONGODB_VERSION s3cmd ca-certificates

WORKDIR /root/

ADD backup.sh /root/

RUN chmod +x backup.sh

CMD /root/backup.sh
