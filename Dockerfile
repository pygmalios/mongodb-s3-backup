FROM ubuntu:14.04

ENV MONGODB_VERSION=3.2.20

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv D68FA50FEA312927 \
    && echo 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse' > /etc/apt/sources.list.d/mongodb.list \
    && apt-get update \
    && apt-get install -y mongodb-org-tools=$MONGODB_VERSION s3cmd ca-certificates

WORKDIR /root/

ADD backup.sh /root/

RUN chmod +x backup.sh

CMD /root/backup.sh
