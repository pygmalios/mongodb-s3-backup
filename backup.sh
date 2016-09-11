#!/bin/bash

TIMESTAMP=`date -u +"%Y-%m-%dT%H-%M-%SZ"`
BACKUP_FILENAME=$BACKUP_NAME.$TIMESTAMP.tgz

mkdir -p bak

echo "Backing up $MONGO_DATABASE"
mongodump -h $MONGO_HOST -d $MONGO_DATABASE -u $MONGO_USER -p $MONGO_PASSWORD -o bak/mongodb_backup

echo "Compressing backup"
tar czf bak/$BACKUP_FILENAME bak/mongodb_backup/

echo "Uploading backup to S3"
echo "[default]" > .s3cfg
echo "access_key = $AWS_ACCESS_KEY_ID" >> .s3cfg
echo "secret_key = $AWS_SECRET_ACCESS_KEY" >> .s3cfg
echo "bucket_location = $AWS_DEFAULT_REGION" >> .s3cfg
echo "use_https = True" >> .s3cfg
s3cmd put bak/$BACKUP_FILENAME s3://$S3_BUCKET_NAME/$BACKUP_FILENAME
rm .s3cfg

echo "Removing local backup"
rm -rf bak/mongodb_backup

