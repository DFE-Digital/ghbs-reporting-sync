# GPaaS Postgres - Azure flexible server postgres migration

Note: this is a manual step by step version of the devops job, you can view `azure-pipelines.yml` to see the whole flow.

## Log into AZ cli

```
$ az login --scope https://graph.microsoft.com/.default
```

Note: the script itself will set the default azure subscription, no need to do it now.

## Define your environment variables

```
$ cp example.env staging.env
```

Fill out the example values with the correct ones for this environment.

## Install cloudfoundry conduit plugin

```
$ cf install-plugin -f conduit
```

## Run migration script

```
$ ./migrateDatabase.sh staging
```

The first parameter is the name of the `.env` variables to load when running the script.
