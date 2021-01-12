declare -a StringArray=("wake-book-dev-User" "wake-book-prod-User")

profile="swt-simon-verhoeven"
bucket_name="wake-book-db-backup"
backup_path="backup"

export AWS_PROFILE=$profile

for table_name in ${StringArray[@]}; do
  ./bin/dynamo-backup-to-s3 -i $table_name --read-percentage 0.5 --bucket $bucket_name --aws-region "ap-southeast-1" --backup-path $backup_path
done
