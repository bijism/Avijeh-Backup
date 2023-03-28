#!/bin/bash

# Variables
S3_ACCOUNT_ENDPOINT="your_s3_account_endpoint"
S3_ACCOUNT_SECRET_KEY="your_s3_account_secret_key"
S3_ACCOUNT_ACCESS_KEY="your_s3_account_access_key"
S3_BUCKET_NAME="your_s3_bucket_name"

DB_HOST="your_db_host"
DB_NAME="your_db_name"
DB_USERNAME="your_db_username"
DB_PASSWORD="your_db_password"

WP_FOLDER="/path/to/wordpress/folder"

# Backup WordPress folder and database
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
DOMAIN=$(basename $WP_FOLDER)
BACKUP_DIR="/backup/$DOMAIN-$DATE"
mkdir -p $BACKUP_DIR
tar -czvf $BACKUP_DIR/$DOMAIN-$DATE.tar.gz $WP_FOLDER
mysqldump -h $DB_HOST -u $DB_USERNAME -p$DB_PASSWORD $DB_NAME > $BACKUP_DIR/$DOMAIN-$DATE.sql

# Move backups to S3 using s3cmd
s3cmd put $BACKUP_DIR/$DOMAIN-$DATE.tar.gz s3://$S3_BUCKET_NAME/$DOMAIN-$DATE/
s3cmd put $BACKUP_DIR/$DOMAIN-$DATE.sql s3://$S3_BUCKET_NAME/$DOMAIN-$DATE/

# Record whether processes 1 and 2 are done or not
if [ $? -eq 0 ]; then
    echo "Processes 1 and 2 completed successfully." >> backup.log
else
    echo "Processes 1 and 2 failed." >> backup.log
fi

# Delete backups older than 7 days
find /backup/* -type d -ctime +7 -exec rm -rf {} \;

echo "Finished Script"
