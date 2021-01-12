profile="waketools-root"

export AWS_PROFILE=$profile

aws s3 sync s3://wake-book-db-backup s3://wake-book-db-restore --source-region ap-southeast-1 --region ap-southeast-1
