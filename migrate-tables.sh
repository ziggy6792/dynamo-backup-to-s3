declare -a table_names=("wake-book-dev-User" "wake-book-dev-Booking" "wake-book-prod-User" "wake-book-prod-Booking")

source_profile="swt-simon-verhoeven"
source_bucket_name="wake-book-db-backup"

dest_profile="waketools-root"
dest_bucket_name="wake-book-db-restore"

backup_path="backup"

export AWS_PROFILE=$source_profile

for table_name in ${table_names[@]}; do
  ./bin/dynamo-backup-to-s3 -i $table_name --read-percentage 0.5 --bucket $source_bucket_name --aws-region "ap-southeast-1" --backup-path $backup_path
done

export AWS_PROFILE=$dest_profile

aws s3 sync s3://wake-book-db-backup s3://wake-book-db-restore --source-region ap-southeast-1 --region ap-southeast-1

for table_name in ${table_names[@]}; do
  source="s3://"$dest_bucket_name"/"$backup_path"/"$table_name".json"
  ./bin/dynamo-restore-from-s3 -s $source -t $table_name --aws-region "ap-southeast-1" --overwrite true -c 20 -sf true
done
