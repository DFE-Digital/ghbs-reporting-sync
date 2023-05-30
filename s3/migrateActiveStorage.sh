# load your chosen environment
export $(cat "$1.env"|xargs)

set -v

psql -h $PG_HOST -U $PG_USERNAME -d $PG_DATABASE -v ON_ERROR_STOP=1 -f update-storage-adapters.sql

