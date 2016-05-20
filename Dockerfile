FROM ubuntu:16.04

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 \
    && echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list \
    && apt-get update \
    && apt-get install -y mongodb-org-tools=2.6.11 s3cmd ca-certificates

WORKDIR /root/

ADD backup.sh /root/

CMD /root/backup.sh 

