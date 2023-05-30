# load your chosen environment
export $(cat "$1.env"|xargs)

set -v

# do the copy
azcopy copy "https://s3.$AWS_REGION.amazonaws.com/$BUCKET_NAME/" "$STORAGE_URL_AND_SAS" --recursive
