#!/bin/bash
HOST=db.example.com

# give data basename
DBNAME= mydatabase       

# S3 bucket name
BUCKET=s3-bucket-name

# user account
USER=ubuntu

# Current time
TIME=`/bin/date +%d-%m-%Y-%T`

# Backup directory
DEST= ~/$USER/tmp

# Tar file of backup directory
TAR=$DEST/../$TIME.tar

# Create backup dir (-p to avoid warning if already exists)
/bin/mkdir -p $DEST

# Log
echo "Backing up $HOST/$DBNAME to s3://$BUCKET/ on $TIME";

# Dump from mongodb host into backup directory
/usr/bin/mongodump -h $HOST -d $DBNAME -o $DEST

# Create tar of backup directory
/bin/tar cvf $TAR -C $DEST .

# Upload tar to s3
/usr/bin/aws s3 cp $TAR s3://$BUCKET/

# Remove tar file locally
/bin/rm -f $TAR

# Remove backup directory
/bin/rm -rf $DEST

