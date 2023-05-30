# S3 - AZ blob migration

## Log into AZ cli

```
$ az login --scope https://graph.microsoft.com/.default
$ az account set --subscription YOUR_SUBSCRIPTION_ID
$ az config set extension.use_dynamic_install=yes_without_prompt
```

## Log into cloudfoundry

```
$ cf login -a api.london.cloud.service.gov.uk --sso-passcode -s YOUR_CF_SPACE_NAME
```

## Install azcopy

```
$ brew install azcopy
```

## Define your environment variables

```
$ cp example.env staging.env
```

### Generate a s3 service key to get AWS_x values

```
$ cf create-service-key CF_S3_INSTANCE_NAME CF_S3_INSTANCE_NAME-data-migration-service-key -c '{"allow_external_access": true, "permissions": "read-write"}'

$ cf service-key CF_S3_INSTANCE_NAME CF_S3_INSTANCE_NAME-data-migration-service-key
{
  "aws_access_key_id" "AWS_ACCESS_KEY_ID value"
  "aws_region" "AWS_REGION value"
  "aws_secret_access_key" "AWS_SECRET_ACCESS_KEY value"
  "bucket_name" "BUCKET_NAME value"
}
```

Enter these values into your `*.env` file.

### Generate a SAS token for blob access

```
$ sas_expiry=$(date -u -d "1 day" '+%Y-%m-%dT%H:%MZ')
$ az storage account generate-sas \
      --account-name "AZURE_STORAGE_ACCOUNT" \
      --account-key "AZURE_STORAGE_KEY" \
      --expiry "$sas_expiry" \
      --https-only \
      --services b \
      --resource-types co \
      --permissions acdfilprtuwxy \
      --output tsv
```

Set the output value into your `*.env` file as part of the `STORAGE_URL_AND_SAS` variable

## Run the copy script

This will use `azcopy` to migrate s3 objects into azure storage blobs.

```
$ ./migrateBlobs.sh staging
```

The first parameter is the name of the `.env` variables to load when running the script.

## Migrate ActiveStorageBlobs adapters from amazon to azure

```
$ ./migrateActiveStorage.sh staging
```
