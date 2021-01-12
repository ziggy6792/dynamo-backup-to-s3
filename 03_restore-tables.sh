declare -a StringArray=("wake-book-dev-User" "wake-book-prod-User")

profile="waketools-root"
bucket_name="wake-book-db-restore"
backup_path="backup"

export AWS_PROFILE=$profile

for table_name in ${StringArray[@]}; do
  source="s3://"$bucket_name"/"$backup_path"/"$table_name".json"
  ./bin/dynamo-restore-from-s3 -s $source -t $table_name --aws-region "ap-southeast-1" --overwrite true -c 20 -sf true
done
