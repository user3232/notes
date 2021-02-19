

# Links

## Connection strings

https://www.connectionstrings.com/sql-server-2019/



# Dependencies

```sh
dotnet add package Dapper
dotnet add package Microsoft.Data.SqlClient
dotnet add package DbUp
```

# Connection

In file `appsettings.json` :

```json
{
  "ConnectionStrings" : {
    "DefaultConnection": "Server=localhost;Database=QandA;User Id=sa;Password=tex78MM!!.kk"
  },
}


Using sqlcmd:

```sh
sqlcmd=/opt/mssql-tools/bin/sqlcmd
$sqlcmd -S localhost -U SA -P 'tex78MM!!.kk' -d QandA -i daily_backup_job_setup.sql
```

```

# Dapper

Dapper is object - SQL mapper

# DbUp

DbUp is tool for managing database structure changes.

DbUp can:

- create the database if it doesn't exist
  - from connection string
- perform migration as transaction based on
  - embedded (sql files as EmbeddedResource) scripts in assembly
    - DbUp will run SQL Scripts in name order, so it's important to
      have a script naming convention that caters to this. In our
      example, we are prefixing the script name with a two-digit
      number.




