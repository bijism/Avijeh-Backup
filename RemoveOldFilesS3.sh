#!/bin/bash

# Variables
S3_ACCOUNT_ENDPOINT="your_s3_account_endpoint"
S3_ACCOUNT_SECRET_KEY="your_s3_account_secret_key"
S3_ACCOUNT_ACCESS_KEY="your_s3_account_access_key"
S3_BUCKET_NAME="your_s3_bucket_name"

s3cmd --access_key=$S3_ACCOUNT_ACCESS_KEY --secret_key=$S3_ACCOUNT_SECRET_KEY --host=$S3_ACCOUNT_ENDPOINT ls s3://$S3_BUCKET_NAME | while read -r line;  do
    createDate=`echo $line|awk {'print $1" "$2'}`
    createDate=`date -d"$createDate" +%s`
    olderThan=`date --date "7 days ago" +%s`
    if [[ $createDate -lt $olderThan ]]
        then 
        fileName=`echo $line|awk {'print $4'}`
        if [[ $fileName != "" ]]
            then
            echo $fileName
            s3cmd del "$fileName"
        fi
    fi
done
