# ghbs-reporting-sync

|Environment|Status|
|-|-|
|Development|[![Build Status](https://dfe-ssp.visualstudio.com/S174-Get%20Help%20Buying%20for%20Schools/_apis/build/status/Development%20-%20Sync%20reporting%20database?branchName=main)](https://dfe-ssp.visualstudio.com/S174-Get%20Help%20Buying%20for%20Schools/_build/latest?definitionId=1665&branchName=main)|
|Production|[![Build Status](https://dfe-ssp.visualstudio.com/S174-Get%20Help%20Buying%20for%20Schools/_apis/build/status/Production%20-%20Sync%20reporting%20database?branchName=main)](https://dfe-ssp.visualstudio.com/S174-Get%20Help%20Buying%20for%20Schools/_build/latest?definitionId=1677&branchName=main)|

---

## Initial database setup

*NOTE: You only need to do this once after provisioning the database within Azure*

### Create database

From within the reporting database:

```sql
CREATE DATABASE '<DATABASE NAME>';
```

Where `<DATABASE NAME>` is the name of the database you wish to create

### Create reporting (read-only) users

```sql
CREATE USER <USERNAME> WITH PASSWORD 'examplePassword';
GRANT CONNECT ON DATABASE <DATABASE NAME> TO <USERNAME>;
GRANT USAGE ON SCHEMA public TO <USERNAME>;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO <USERNAME>;
```

Give this username and password to the person wishing to access the data for reporting purposes.
