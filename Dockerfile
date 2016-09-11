FROM ubuntu:14.04

ENV MONGODB_VERSION=3.0.12

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 \
    && echo 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse' > /etc/apt/sources.list.d/mongodb.list \
    && apt-get update \
    && apt-get install -y mongodb-org-tools=$MONGODB_VERSION s3cmd ca-certificates

WORKDIR /root/

ADD backup.sh /root/

CMD /root/backup.sh 

