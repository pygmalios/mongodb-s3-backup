# MongoDB 3.2 S3 docker backup

Docker image to backup MongoDB 3.2 to S3 using mongodump.

## Backup
Launch `mongodbs3backup` container with the following flags:

```
$ docker run --rm \
--env-file env.txt \
--name mongodbs3backup pygmalios/mongodb-s3-backup:3.0
```

The contents of `env.txt` being:

```
MONGO_HOST=mongodb:27017
MONGO_DATABASE=<database_name_here>
MONGO_USER=<username_here>
MONGO_PASSWORD=<password_here>
AWS_ACCESS_KEY_ID=<key_here>
AWS_SECRET_ACCESS_KEY=<secret_here>
AWS_DEFAULT_REGION=us-east-1
BACKUP_NAME=mongo
S3_BUCKET_NAME=mongo-backups.example.com
```

`mongodbs3backup` will dump mongo database using mongodump and provided credentials. Resulting backup will be tarballed, gzipped, time-stamped, prefixed with `BACKUP_NAME` and uploaded to the existing S3 bucket.

## Periodic backup in Docker Cloud

You can use [tutum-cron](https://github.com/maphubs/tutum-cron) ([Docker image](https://quay.io/repository/maphubs/dockercloud-cron)) to run container on schedule.
