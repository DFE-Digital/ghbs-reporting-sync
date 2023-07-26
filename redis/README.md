# Redis migration

## Log into cloudfoundry

```
$ cf login -a api.london.cloud.service.gov.uk --sso-passcode -s YOUR_CF_SPACE_NAME
```

## Start a conduit for redis

```
$ cf conduit YOUR_REDIS_SERVICE_NAME

OK Connecting client
OK Targeting org dfe
OK Targeting space sct-staging
OK Deploying __conduit_XYZ__
OK Uploading __conduit_XYZ__ bits
OK Starting __conduit_XYZ__
OK Waiting for conduit app to become available
OK Fetching service infomation
OK Binding YOUR_REDIS_SERVICE_NAME
OK Fetching environment
OK Starting port forwarding
OK Waiting for port forwarding

The following services are ready for you to connect to:

* service: YOUR_REDIS_SERVICE_NAME (redis)
  host: 127.0.0.1
  name: XYZ1234
  password: APASSWORDHERE
  port: 7080
  tls_enabled: true
  uri: rediss://:APASSWORDHERE@127.0.0.1:7080
```

## Define your environment variables

```
$ cp example.env staging.env
```

Fill in `SOURCE_REDIS_URL` with the output redis URL from conduit (in the example above it is `rediss://:APASSWORDHERE@127.0.0.1:7080`).

Fill in `DESTINATION_REDIS_URL` with the redis URL from your application.

## Run the migration script

**NOTE:** Before running the migration you should ideally disable the worker process on both sets of infrastructure to avoid any unforseen consequences.

```
$ ./migrateRedis.sh staging
```

The first parameter is the name of the `.env` variables to load when running the script.
