# load your chosen environment
export $(cat "$1.env"|xargs)

set -v

backup_file="$1.backup.sql"

f login -u $CF_USER -p $CF_PASSWORD -a https://api.london.cloud.service.gov.uk -s $CF_SPACE

# Dump database from GPaaS - this won't work on GlobalProtect VPN
cf conduit $CF_POSTGRES_SERVICE -- pg_dump -E utf8 --clean --if-exists --disable-triggers --no-owner --no-privileges --no-comments > $backup_file

# Remove cloudfoundry triggers from database
cat remove-triggers.sql >> $backup_file

# Convert active storage objects from s3 to azure blobs (only relevant if you have migrated s3 already)
cat ../s3/update-storage-adapters.sql >> $backup_file

# Import database into Azure
psql -h $PG_HOST -U $PG_USERNAME -d $PG_DATABASE -v ON_ERROR_STOP=1 -f $backup_file
