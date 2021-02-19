

# Azure data studio

https://docs.microsoft.com/en-us/sql/azure-data-studio/?view=sql-server-ver15

# MS SQL server performance best practice

https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-performance-best-practices?view=sql-server-ver15

# Local mssql on Ubuntu 18.04 (systemd)

[SQL server on Ubuntu 18.04](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver15)

tex78MM!!.kk

## Links

Usefull:

- [Managing systemd services](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)
- [Changing mssql access rights (groups)](https://www.sqlpac.com/referentiel/docs-en/ms-sql-2019-ubuntu-systemctl-service-management-mssql.html)

## Configuration of Microsoft repositories

https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-change-repo?view=sql-server-linux-ver15&pivots=ld2-ubuntu


## Install

Resources:

- https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup?view=sql-server-linux-ver15#platforms
- https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-linux-ver15
- https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-full-text-search?view=sql-server-linux-ver15#ubuntu
- https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-sql-agent?view=sql-server-linux-ver15

```sh
# **************************
# installing server package:
# **************************
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"
sudo apt-get update
sudo apt-get install -y mssql-server

# **************************
# Install version
# **************************

# attended install:
# sudo /opt/mssql/bin/mssql-conf setup

# unatended install oneliner
# proguct id (MSSQL_PID):
# - Evaluation
# - Developer
# - Express
# - Web
# - Standard
# - Enterprise
# - A product key
sudo MSSQL_PID=Developer ACCEPT_EULA=Y MSSQL_SA_PASSWORD='tex78MM!!.kk' /opt/mssql/bin/mssql-conf -n setup


# server should be starting now, check if it is running:
systemctl status mssql-server --no-pager


# **************************
# Install tools
# **************************
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update 
sudo apt-get install mssql-tools unixodbc-dev

# now sqlcmd connection can be tested (you will be asked for password)
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -Q 'select @@VERSION'
# now you won't
# /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'tex78MM!!.kk' -Q 'select @@VERSION'

# **************************
# Install full text search:
# **************************
sudo apt-get update 
sudo apt-get install -y mssql-server-fts


# **************************
# Install SQL Server 2019 - Server Agent
# **************************

# Doc sey to setup host name and fully qualified host name in /etc/hosts
# for example
# > "IP Address" "hostname"
# > "IP Address" "hostname.domain.com"
echo '127.0.0.1 ubuntu' | sudo tee -a /etc/hosts
echo '127.0.0.1 ubuntu.michal.com' | sudo tee -a /etc/hosts

# enable jobs in config file
sudo /opt/mssql/bin/mssql-conf set sqlagent.enabled true 

# check config file
sudo cat /var/opt/mssql/mssql.conf

# to apply changes server needs to restart
# sudo systemctl restart mssql-server



# **************************
# uninstall
# **************************

sudo apt-get remove mssql-server
# cliean mssql home directory:
sudo rm -rf /var/opt/mssql/

```


## Status?

What is status of mssql-server ?

```console
$ systemctl status mssql-server --no-pager
● mssql-server.service - Microsoft SQL Server Database Engine
   Loaded: loaded (/lib/systemd/system/mssql-server.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-07-14 00:42:48 CEST; 2h 26min ago
     Docs: https://docs.microsoft.com/en-us/sql/linux
 Main PID: 4657 (sqlservr)
    Tasks: 188
   CGroup: /system.slice/mssql-server.service
           ├─4657 /opt/mssql/bin/sqlservr
           └─4699 /opt/mssql/bin/sqlservr

lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [159B blob data]
lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [156B blob data]
lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [160B blob data]
lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [61B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [96B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [66B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [96B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [100B blob data]
lip 14 00:43:04 mk-Lenovo-G780 sqlservr[4657]: [71B blob data]
lip 14 00:43:04 mk-Lenovo-G780 sqlservr[4657]: [124B blob data]
$
```

If server running, check connection:

```sh
sqlcmd -S localhost -U SA -Q 'select @@VERSION'
```

## Logs

```sh
# Logs are here (UTF-16 encoded):
sudo cat /var/opt/mssql/log/errorlog
# The installer logs here  (UTF-16 encoded):
sudo cat /var/opt/mssql/setup-< time stamp representing time of install>
# to convert between UTF-16 and UTF-8
sudo iconv -f UTF-16LE -t UTF-8 <errorlog> -o <output errorlog file>
```

## Extended events

https://technet.microsoft.com/library/bb630282.aspx

## Crash dumps

```sh
# For Core dumps:
sudo ls /var/opt/mssql/log | grep .tar.gz2
# For SQL dumps (SQL minidumps (.mdmp extension))
sudo ls /var/opt/mssql/log | grep .mdmp
```

## Starting and stopping

Starting/stopping need sudo or service password:

```console
$ # as user there is choice:
$ systemctl stop mssql-server
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to stop 'mssql-server.service'.
Multiple identities can be used for authentication:
 1.  Ubuntu (ubuntu)
 2.  mssql
Choose identity to authenticate as (1-2):
$
$
$ # or as root
$ sudo systemctl stop mssql-server
[sudo] user:
$
```

## Start SQL Server in Minimal Configuration Mode

https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-troubleshooting-guide?view=sql-server-ver15#connection

This is useful if the setting of a configuration value (for example,
over-committing memory) has prevented the server from starting.

```sh
sudo -u mssql /opt/mssql/bin/sqlservr -f
```

## Start SQL Server in Single User Mode (default user is mssql)

Under certain circumstances, you may have to start an instance of SQL
Server in single-user mode by using the startup option -m. For
example, you may want to change server configuration options or
recover a damaged master database or other system database.

```console
$ # Database files are created with user mssql by default:
$ sudo ls -l /var/opt/mssql
razem 16
drwxr-xr-x 2 mssql mssql 4096 wrz  5 15:08 data
drwxr-xr-x 2 mssql mssql 4096 wrz  5 15:04 log
-rw-rw-r-- 1 mssql mssql   75 lip 14 00:41 mssql.conf
drwxr-xr-x 2 mssql mssql 4096 lip 14 00:42 secrets
$ # Start SQL Server in Single User Mode (with user mssql !!!)
$ sudo -u mssql /opt/mssql/bin/sqlservr -m
$ # Start SQL Server in Single User Mode with SQLCMD (with user mssql !!!)
$ sudo -u mssql /opt/mssql/bin/sqlservr -m SQLCMD
$ # If accidentally started SQL Server with another user
$ # change ownership back to mssql :
$ chown -R mssql:mssql /var/opt/mssql/
$ # informations about sqlservr service and CLI:
$ man sqlservr
$ # more usefull sqlservr CLI help:
$ sudo /opt/mssql/bin/sqlservr --help
usage: sqlservr [OPTIONS...]

Configuration options:
  -T<#>                     Enable a traceflag
  -y<#>                     Enable dump when server encounters specified error
  -k<#>                     Checkpoint speed (in MB/sec)

Administrative options:
  --accept-eula             Accept the SQL Server EULA
  --pid <pid>               Set server product key
  --reset-sa-password       Reset system administrator password. Password should
                            be specified in the MSSQL_SA_PASSWORD environment
                            variable.
  -f                        Minimal configuration mode
  -m                        Single user administration mode
  -K                        Force regeneration of Service Master Key
  --setup                   Set basic configuration settings and then shutdown.
  --force-setup             Same as --setup, but also reinitialize master and model databases.

General options:
  -v                        Show program version
  --help                    Display this help information
```

## Rebuild system databases

These steps will DELETE all SQL Server system data that you have
configured! This includes information about your user databases (but
not the user databases themselves). It will also delete other
information stored in the system databases, including the following:
master key information, any certs loaded in master, the SA Login
password, job-related information from msdb, DB Mail information from
msdb, and sp_configure options. Only use if you understand the
implications!

```sh
# Stop SQL Server:
sudo systemctl stop mssql-server
# Run sqlservr with the force-setup parameter:
sudo -u mssql /opt/mssql/bin/sqlservr --force-setup
# After you see the message "Recovery is complete", press CTRL+C. 
# This will shut down SQL Server
# Reconfigure the SA password:
sudo /opt/mssql/bin/mssql-conf set-sa-password
# Start SQL Server and reconfigure the server. 
# This includes restoring or re-attaching any user databases.
sudo systemctl start mssql-server
```


## Autostarting

```console
$ # To start a service at boot:
$ sudo systemctl enable mssql-server
Added /etc/systemd/system/multi-user.target.wants/mssql-server.service.
$ # To disable the service from starting automatically:
$ sudo systemctl disable mssql-server
Removed /etc/systemd/system/multi-user.target.wants/mssql-server.service.
```

## Forgotten the system administrator (SA) password

```sh
sudo systemctl stop mssql-server
sudo /opt/mssql/bin/mssql-conf setup
```

# SQL Server command-line tools

## Links

- [VS Code Plugin!!!](https://docs.microsoft.com/en-us/sql/tools/visual-studio-code/sql-server-develop-use-vscode?view=sql-server-ver15)
- [install mssql server command line tools on linux](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver15#ubuntu)
- [install mssql server on linux](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver15)
- [Run and connect with Docker](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15)
- [bulk copy program utility (bcp)](https://docs.microsoft.com/en-us/sql/tools/bcp-utility?view=sql-server-ver15)
- sqlcmd - The sqlcmd utility lets you enter Transact-SQL statements, system procedures, and script files through command line. [sqlcmd help](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15)
- [sqlcmd tutorial](https://docs.microsoft.com/en-us/sql/ssms/scripting/sqlcmd-start-the-utility?view=sql-server-ver15)
- [Install the Microsoft ODBC driver for SQL Server (Linux)](https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#17)


## Install


([Interesting discussion about what is (not)interactive (login) session](https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell))


```console
$ # run below script with:
$ sudo bash mssql-tools_instal.sh
$ source ~/.bashrc
```

`mssql-tools_instal.sh`:

```sh
#!/bin/bash

# this causes to stop on errors
set -e 

# Import the public repository GPG keys.
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# Register the Microsoft Ubuntu repository.
# Enter proper Ubuntu version!!!! (18.04 for bionic?)
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
# Update the sources list
sudo apt-get update 
# install odbc driver
sudo apt-get install unixodbc-dev
# finally install tools (sqlcmd and bcp): 
sudo apt-get install mssql-tools

####################################
# Adding tools directory to $PATH
# /opt/mssql-tools/bin
####################################

case :$PATH: in 
    *:/opt/mssql-tools/bin:*) 
        echo "mssql-tools in PATH"
        ;; 
    *) 
        echo "mssql-tools not in PATH!"

        ADD_THIS='case :$PATH: in *:/opt/mssql-tools/bin:*) ;; *) PATH="$PATH:/opt/mssql-tools/bin" ; export PATH ;; esac'
        TEST_THIS='case :$PATH: in *:/opt/mssql-tools/bin:*)'

        if grep -F $TEST_THIS ~/.bashrc ; then 
            echo '~/.bashrc have addition of mssql-tools to $PATH ' 
        else
            echo 'Adding /opt/mssql-tools/bin to $PATH in ~/.bashrc'
            # echo $ADD_THIS >> ~/.bashrc
            printf "%s" "$ADD_THIS" >> ~/.bashrc
        fi

        if grep -F $TEST_THIS ~/.bash_profile ; then 
            echo '~/.bash_profile have addition of mssql-tools to $PATH ' 
        else
            echo 'Adding /opt/mssql-tools/bin to $PATH in ~/.bash_profile'
            printf "%s" "$ADD_THIS" >> ~/.bash_profile
        fi

        if grep -F $TEST_THIS ~/.profile ; then 
            echo '~/.profile have addition of mssql-tools to $PATH ' 
        else
            echo 'Adding /opt/mssql-tools/bin to $PATH in ~/.profile'
            printf "%s" "$ADD_THIS" >> ~/.profile
        fi

        ;;
esac

echo "Done!"

```

# Connect locally


```sh
# lets connect:
# You can omit the password on the command 
# line to be prompted to enter it.
sqlcmd -S localhost -U SA -P 'tex78MM!!.kk'
# lets fire some T-SQL to create database:

```

Where:
- SQL Server name (-S), 
- the user name (-U), 
- and the password (-P)
  - (SA is System Administrator)

# Create and query data (at sqlcmd command prompt)

```sql
-- create database named QandA
CREATE DATABASE QandA
-- display all databases on server
SELECT Name from sys.Databases
-- one must execute GO to run above commands
-- GO may be executed after each of commands
GO
-- This exits session:
QUIT
```

For empty database it looks like:

```console
$ sqlcmd -S localhost -U SA -P 'tex78MM!!.kk'
1> create database QandA
2> select Name from sys.Databases
3> GO
Name
------------------------------------------------
master
tempdb
model
msdb
QandA

(5 rows affected)
1> quit
$
```


# mssql-cli

[Documentation!!!](https://github.com/dbcli/mssql-cli/tree/master/doc)

## install

`install_mssql-cli.sh`:

```sh
#!/bin/bash
set -e
# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# Register the Microsoft Ubuntu repository
sudo apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod
# Update the list of products
sudo apt-get update
# Install mssql-cli
sudo apt-get install mssql-cli
# Install missing dependencies
sudo apt-get install -f
# All done
echo "Done."
```

To install run:

```console
$ sudo bash install_mssql-cli.sh
```

# Tutorial with VSCode

https://docs.microsoft.com/en-us/sql/tools/visual-studio-code/sql-server-develop-use-vscode?view=sql-server-ver15

Connection settings are saved in VSCode `Settings.json`
(`~/.config/Code/User/settings.json`):

```json
"mssql.connections": [
        {
            "server": "localhost",
            "database": "",
            "authenticationType": "SqlLogin",
            "user": "SA",
            "password": "",
            "emptyPasswordInput": false,
            "savePassword": true,
            "profileName": "localhost"
        }
    ]
```

Example sql :

```sql
-- Create a new database called 'TutorialDB'
-- Connect to the 'master' database to run this snippet
USE master
GO


-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'TutorialDB'
)
CREATE DATABASE TutorialDB
GO


-- create table
-- Connect to the 'TutorialDB' database to run further commands
USE TutorialDB
GO


-- Create a new table called 'Employees' in schema 'dbo'
-- Drop the table if it already exists
-- OBJECT_ID doc: https://docs.microsoft.com/en-us/sql/t-sql/functions/object-id-transact-sql?view=sql-server-ver15
IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
DROP TABLE dbo.Employees
GO
-- Create the table in the specified schema
CREATE TABLE dbo.Employees
(
    EmployeesId INT NOT NULL PRIMARY KEY, -- primary key column
    Name [NVARCHAR](50)  NOT NULL,
    Location [NVARCHAR](50)  NOT NULL
    -- specify more columns here
);
GO


-- Insert rows into table 'Employees'
INSERT INTO Employees
   ([EmployeesId],[Name],[Location])
VALUES
   ( 1, N'Jared', N'Australia'),
   ( 2, N'Nikita', N'India'),
   ( 3, N'Tom', N'Germany'),
   ( 4, N'Jake', N'United States')
GO
-- Query the total count of employees
SELECT COUNT(*) as EmployeeCount FROM dbo.Employees;
-- Query all employee information
SELECT e.EmployeesId, e.Name, e.Location
FROM dbo.Employees as e
GO
```

# MSSQL security on linux

https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-security-overview?view=sql-server-ver15

SQL Server on Linux currently has the following limitations:

- A standard password policy is provided. MUST_CHANGE is the only
  option you may configure. CHECK_POLICY option is not supported.
- Extensible Key Management is not supported.
- Using keys stored in the Azure Key Vault is not supported.
- SQL Server generates its own self-signed certificate for encrypting
  connections. SQL Server can be configured to use a user provided
  certificate for TLS.


# Access control

https://docs.microsoft.com/en-us/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-linux-ver15

## Logins

Logins are individual user accounts for logging on to the SQL Server
Database Engine. SQL Server and SQL Database support logins based on:
- Windows authentication and
- SQL Server authentication.

- **Logins are granted access to a database by creating a database user**
  **in a database and mapping that database user to login.**
- Typically the database user name is the same as the login name,
  though it does not have to be the same.
- Each database user maps to a single login.
- A login can be mapped to only one user in a database, but can be
  mapped as a database user in several different databases.
- Database users can also be created that do not have a corresponding
  login. These are called **contained database users**.

## Contained Databases

A contained database is a database that:
- is isolated from other databases and 
- from the instance of SQL Server/ SQL Database (and the master
  database) that hosts the database.
- When using SQL Database, combine contained database users with
  database level firewall rules.


## Contained Database Users

- contained database users can authenticate SQL Server and SQL
  Database connections at the database level.
- In the contained database user model, the login in the master
  database is not present
- authentication process occurs at the user database
  - the database user in the user database does not have an associated
    login in the master database
- To connect as a contained database user, the connection string must
  always contain a parameter for the user database so that the
  Database Engine knows which database is responsible for managing the
  authentication process.
-  The activity of the contained database user is limited to the
   authenticating database, so when connecting as a contained database
   user: 
  - the database user account must be independently created in each
    database that the user will need. 
  - To change databases, SQL Database users must create a new
    connection. 
  - Contained database users in SQL Server can change databases if an
    identical user is present in another database.


## Traditional Login and User Model

- In traditional connection model, to connect users to databases one can
  provide both a name and password and connects by using SQL Server
  authentication.
- the master database must have a login that matches the connecting
  credentials
- After the Database Engine authenticates the SQL Server
  authentication credentials, the connection typically attempts to
  connect to a user database.
- To connect to a user database, the login must be able to be mapped
  to (that is, associated with) a database user in the user database.
- The connection string may also specify connecting to a specific
  database which is optional in SQL Server but required in SQL
  Database.

The important principal is that both the login (in the master
database) and the user (in the user database) must exist and be
related to each other. This means that:
- the connection to the user database has a dependency upon the login
  in the master database,
- and this limits the ability of the database to be moved to a
  different hosting SQL Server or Azure SQL Database server. 
  - this may reduce connection scalability.

## Working with Permissions

Every SQL Server securable has associated permissions that can be
granted to a principal. Permissions in the Database Engine are managed
at the server level assigned to logins and server roles, and at the
database level assigned to database users and database roles.

Permissions can be manipulated with the familiar Transact-SQL queries: 
- GRANT,
- DENY, and
- REVOKE. 

```sql
GRANT SELECT ON OBJECT::HumanResources.Employee TO Larry;
REVOKE SELECT ON OBJECT::HumanResources.Employee TO Larry;
```


Information about permissions is visible in:
- `sys.server_permissions` catalog view
- `sys.database_permissions` catalog view. 
- There is also support for querying permissions information by using
  built-in functions.

[Permissions_graph.pdf](images/Microsoft_SQL_Server_2017_and_Azure_SQL_Database_permissions_infographic.pdf)


For information about designing a permissions system, see 
[Getting Started with Database Engine Permissions](https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/getting-started-with-database-engine-permissions?view=sql-server-ver15)


https://docs.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine?view=sql-server-ver15

The **security context** includes the following principals:

- The login
- The user
- Role memberships
- Windows group memberships
- If module signing is being used, any login or user account for the
  certificate used to sign the module that the user is currently
  executing, and the associated role memberships of that principal.

**Permission space** is the securable entity and any securable classes
that contain the securable. For example, a table (a securable entity)
is contained by the schema securable class and by the database
securable class. Access can be affected by table-, schema-, database-,
and server-level permissions (permissions hierarchy).

**Required permission** is the kind of permission that is required.
For example, `INSERT, UPDATE, DELETE, SELECT, EXECUTE, ALTER, CONTROL`, 
and so on.


## Permissions Naming Conventions

General conventions that are followed for naming permissions:

- `CONTROL` - Confers ownership-like capabilities on the grantee. The
  grantee effectively has all defined permissions on the securable. A
  principal that has been granted CONTROL can also grant permissions
  on the securable. 
- `ALTER` - Confers the ability to change the properties, except
  ownership, of a particular securable. When granted on a scope, ALTER
  also bestows the ability to alter, create, or drop any securable
  that is contained within that scope. For example, ALTER permission
  on a schema includes the ability to create, alter, and drop objects
  from the schema.
- `ALTER ANY <Server Securable>`, where Server Securable can be any
  server securable. Confers the ability to create, alter, or drop
  individual instances of the Server Securable. For example, `ALTER
  ANY LOGIN`
- `ALTER ANY <Database Securable>`, where Database Securable can be
  any securable at the database level. Confers the ability to CREATE,
  ALTER, or DROP individual instances of the Database Securable. For
  example, `ALTER ANY SCHEMA`
- `TAKE OWNERSHIP` - Enables the grantee to take ownership of the
  securable on which it is granted.
- `IMPERSONATE <Login>` - Enables the grantee to impersonate the
  login.
- `IMPERSONATE <User>` - Enables the grantee to impersonate the user.
- `CREATE <Server Securable>|<Database Securable>|<Schema-contained
  Securable>` - Confers to the grantee the ability to create the
  Server Securable | Database Securable | Schema-contained Securable.
- `VIEW DEFINITION` - Enables the grantee to access metadata.
- `REFERENCES` - The REFERENCES permission on a table is needed to
  create a FOREIGN KEY constraint that references that table. The
  REFERENCES permission is needed on an object to create a FUNCTION or
  VIEW with the WITH SCHEMABINDING clause that references that object.

Examples:

```sql
-- Returning the complete list of grantable permissions
SELECT * FROM fn_builtin_permissions(default);  
-- Returning the permissions on a particular class of objects
SELECT * FROM fn_builtin_permissions('assembly');  
-- Returning the permissions granted to the executing principal on an object
SELECT * FROM fn_my_permissions('Orders55', 'object');  
-- Returning the permissions applicable to a specified object
SELECT * FROM sys.database_permissions   
    WHERE major_id = OBJECT_ID('Yttrium');
GO
```


## Securable

https://docs.microsoft.com/en-us/sql/relational-databases/security/securables?view=sql-server-ver15

**Server securable**:

- Availability group
- Endpoint
- Login
- Server role
- Database

**Database securable**:

- Application role
- Assembly
- Asymmetric key
- Certificate
- Contract
- Fulltext catalog
- Fulltext stoplist
- Message type
- Remote Service Binding
- (Database) Role
- Route
- Schema
- Search property list
- Service
- Symmetric key
- User

**Schema securable**:

- Type
- XML schema collection
- Object - The object class has the following members:
  - Aggregate
  - Function
  - Procedure
  - Queue
  - Synonym
  - Table
  - View
  - External Table


## Principals

https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/principals-database-engine?view=sql-server-ver15

SQL Server-level principals:

- SQL Server authentication Login
- Windows authentication login for a Windows user
- Windows authentication login for a Windows group
- Azure Active Directory authentication login for a AD user
- Azure Active Directory authentication login for a AD group
- Server Role


Database-level principals:

- Database User (There are 12 types of users. For more information,
  see CREATE USER.)
- Database Role
- Application Role


**sa login** of the SQL Server is a server-level principal: 

- By default, it is created when an instance is installed.
- The default database of sa is master. 
- The sa login is a member of the sysadmin fixed server-level role.
- The sa login has all permissions on the server and cannot be
  limited.
- The sa login cannot be dropped, but it can be disabled so that no
  one can use it.


**The dbo user** is a special user principal in each database. 

- All SQL Server administrators are the dbo user, 
- members of the sysadmin fixed server role are the dbo user, 
- sa login is the dbo user,
- owners of the database  are the dbo user.
- The dbo user has all permissions in the database and cannot be
  limited or dropped.
- The dbo user owns the dbo schema.
- The dbo schema is the default schema for all users, unless some
  other schema is specified. 
- The dbo schema cannot be dropped.
- dbo stands for database owner, but the dbouser account is not the
  same as the db_owner fixed database role, and the db_owner fixed
  database role is not the same as the user account that is recorded
  as the owner of the database.

(default) public Server Role and Database Role:

- Every login belongs to the public fixed server role
- every database user belongs to the public database role
- When a login or user has not been granted or denied specific
  permissions on a securable, the login or user inherits the
  permissions granted to public on that securable.
- The public fixed server role and the public fixed database role
  cannot be dropped. 
- (but) permissions can be revoked from the public roles
  - Be careful when revoking permissions from the public login or
    user, as it will affect all logins/users
  - Generally you should not deny permissions to public, because the
    deny statement overrides any grant statements you might make to
    individuals

## Server level roles

https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/server-level-roles?view=sql-server-ver15


- Server-level roles are server-wide in their permissions scope.
  (Roles are like groups in the Windows operating system.)
- Fixed server roles are provided for convenience and backward
  compatibility.
- One can create user-defined server roles and add server-level
  permissions to the user-defined server roles.
- One can add server-level principals ( SQL Server logins, Windows
  accounts, and Windows groups) into server-level roles.
- Each member of a fixed server role can add other logins to that same
  role.
- Members of user-defined server roles cannot add other server
  principals to the role.

**Fixed server-level roles and their capabilities**:

- **sysadmin** - Members of the sysadmin fixed server role can perform
  any activity in the server.
- **serveradmin** - Members of the serveradmin fixed server role can
  change server-wide configuration options and shut down the server.
- **securityadmin** - Members of the securityadmin fixed server role
  manage logins and their properties. They can GRANT, DENY, and REVOKE
  server-level permissions. They can also GRANT, DENY, and REVOKE
  database-level permissions if they have access to a database.
  Additionally, they can reset passwords for SQL Server logins.
- processadmin - Members of the processadmin fixed server role can end
  processes that are running in an instance of SQL Server.
- setupadmin - Members of the setupadmin fixed server role can add and
  remove linked servers by using Transact-SQL statements.
- bulkadmin - Members of the bulkadmin fixed server role can run the
  BULK INSERT statement.
- diskadmin - The diskadmin fixed server role is used for managing
  disk files.
- **dbcreator** - Members of the dbcreator fixed server role can
  create, alter, drop, and restore any database.
- **public** - Every SQL Server login belongs to the public server
  role. When a server principal has not been granted or denied
  specific permissions on a securable object, the user inherits the
  permissions granted to public on that object. Only assign public
  permissions on any object when you want the object to be available
  to all users. You cannot change membership in public.
  - Note: public is implemented differently than other roles, and
    permissions can be granted, denied, or revoked from the public
    fixed server roles.

```sql
-- list the server-level permissions
SELECT * FROM sys.fn_builtin_permissions('SERVER') ORDER BY permission_name;
```


## Database level roles

- https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver15


Database roles:

- Fixed-database roles are defined at the database level and exist in
  each database. 
- Members of the **db_owner** database role can manage fixed-database
  role membership.
- user-defined database roles can be created
- The permissions of user-defined database roles can be customized by
  using the GRANT, DENY, and REVOKE statements.
- Server-level permissions cannot be granted to database roles. 
- Logins and other server-level principals (such as server roles)
  cannot be added to database roles. 
- For server-level security in SQL Server, use server roles instead. 
- Server-level permissions cannot be granted through roles in SQL
  Database and Azure Synapse.


**Fixed-Database Roles**:

- **(public database role)** - Every database user belongs to the public
  database role. When a user has not been granted or denied specific
  permissions on a securable object, the user inherits the permissions
  granted to public on that object. Database users cannot be removed
  from the public role.
- **db_owner** - Members of the db_owner fixed database role can perform
  all configuration and maintenance activities on the database, and
  can also drop the database in SQL Server. (In SQL Database and Azure
  Synapse, some maintenance activities require server-level
  permissions and cannot be performed by db_owners.)
- db_securityadmin - Members of the db_securityadmin fixed database
  role can modify role membership for custom roles only and manage
  permissions. Members of this role can potentially elevate their
  privileges and their actions should be monitored.
- **db_accessadmin** - Members of the db_accessadmin fixed database role
  can add or remove access to the database for Windows logins, Windows
  groups, and SQL Server logins.
- db_backupoperator - Members of the db_backupoperator fixed database
  role can back up the database.
- db_ddladmin - Members of the db_ddladmin fixed database role can run
  any Data Definition Language (DDL) command in a database.
- **db_datawriter** - Members of the db_datawriter fixed database role can
  add, delete, or change data in all user tables.
- **db_datareader** - Members of the db_datareader fixed database role can
  read all data from all user tables.
- **db_denydatawriter** - Members of the db_denydatawriter fixed database
  role cannot add, modify, or delete any data in the user tables
  within a database.
- **db_denydatareader** - Members of the db_denydatareader fixed database
  role cannot read any data in the user tables within a database.

**Special Roles for SQL Database and Azure Synapse**:

- **dbmanager** - Can create and delete databases. A member of the
  dbmanager role that creates a database, becomes the owner of that
  database which allows that user to connect to that database as the
  dbo user. The dbo user has all database permissions in the database.
  Members of the dbmanager role do not necessarily have permission to
  access databases that they do not own.
- **loginmanager** - Can create and delete logins in the virtual
  master database.

**Getting info by Transact-SQL**:

- `sp_helpdbfixedrole` - Returns a list of the fixed database roles.
- `sp_dbfixedrolepermission` - Displays the permissions of a fixed
  database role.
- `sp_helprole` - Returns information about the roles in the current
  database.
- `sp_helprolemember` - Returns information about the members of a
  role in the current database.
- `sys.database_role_members` - Returns one row for each member of
  each database role.
- `IS_MEMBER` - Indicates whether the current user is a member of the
  specified Microsoft Windows group or Microsoft SQL Server database
  role.


## Row level security

https://docs.microsoft.com/en-us/sql/relational-databases/security/row-level-security?view=sql-server-ver15

RLS supports two types of security predicates.

- Filter predicates silently filter the rows available to read
  operations (SELECT, UPDATE, and DELETE).
- Block predicates explicitly block write operations (AFTER INSERT,
  AFTER UPDATE, BEFORE UPDATE, BEFORE DELETE) that violate the
  predicate.

Examples at: 
https://docs.microsoft.com/en-us/sql/relational-databases/security/row-level-security?view=sql-server-ver15

## Dynamic data masking

Dynamic data masking (DDM) limits sensitive data exposure by masking
it to non-privileged users. It can be used to greatly simplify the
design and coding of security in your application.

A masking rule may be defined on a column in a table, in order to
obfuscate the data in that column. Four types of masks are available.

- Default 
  - Full masking according to the data types of the designated fields
  - Example column definition syntax: 
    `Phone# varchar(12) MASKED WITH (FUNCTION = 'default()') NULL`
- Email
  - Masking method that exposes the first letter of an email address
    and the constant suffix ".com", in the form of an email address.
    `aXXX@XXXX.com`.
  - Example definition syntax: 
    `Email varchar(100) MASKED WITH (FUNCTION = 'email()') NULL`
- Random
  - A random masking function for use on any numeric type to mask the
    original value with a random value within a specified range.
  - Example of alter syntax: 
    `ALTER COLUMN [Month] ADD MASKED WITH (FUNCTION = 'random(1, 12)')`
- Custom String 
  - Masking method that exposes the first and last letters and adds a
    custom padding string in the middle. `prefix,[padding],suffix`
  - `ALTER COLUMN [Social Security Number] ADD MASKED WITH (FUNCTION = 'partial(0,"XXX-XX-",4)')`


## Certificate-based SQL Server Logins







# Firewalls

https://docs.microsoft.com/en-us/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access?view=sql-server-ver15&viewFallbackFrom=sql-server-linux-ver15

https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-firewall/windows-firewall-with-advanced-security-design-guide

Overwiew:

- The default instance of the Database Engine uses port 1433, 
  - but that can be changed. 
- The port used by the Database Engine is listed in the
SQL Server error log. 
- Dynamic ports are used by:
  - Instances of SQL Server Express, 
  - SQL Server Compact, 
  - named instances of the Database Engine.

The list of allowed traffic is populated in one of the following ways:

- Automatically: When a computer with a firewall enabled initiated
  communication, the firewall creates an entry in the list so that the
  response is allowed. This response is considered solicited traffic,
  and there is nothing that needs to be configured.

- Manually: An administrator configures exceptions to the firewall.
  This allows either access to specified programs or ports on your
  computer. In this case, the computer accepts unsolicited incoming
  traffic when acting as a server, a listener, or a peer. This is the
  type of configuration that must be completed to connect to SQL
  Server.


Typical ports:

- By default, the typical ports used by SQL Server and associated
  database engine services are: **TCP 1433, 4022, 135, 1434, UDP 1434**.
- By default, the typical ports used by SQL Server Analysis Services and
  associated services are: **TCP 2382, 2383, 80, 443**. 
- By default, the typical ports used by SQL Server Reporting SErvices
  and associated services are: **TCP 80, 443**.
- Ports that are used by the Integration Services service: **TCP port 135** 
  (Microsoft remote procedure calls (MS RPC). Used by the
  Integration Services runtime.)




Some of screnarios are described below:

- Default instance running over TCP 
  - TCP port 1433 
  - This is the most common port allowed through the firewall. It
    applies to routine connections to the default installation of the
    Database Engine, or a named instance that is the only instance
    running on the computer.
- Named instances with default port 
  - The TCP port is a dynamic port determined at the time the Database
    Engine starts. 
  - UDP port 1434 might be required for the SQL Server Browser Service
    when you are using named instances.
- Named instances with fixed port 
  - The port number configured by the administrator.
- Dedicated Admin Connection
  - TCP port 1434 for the default instance. Other ports are used for
    named instances. Check the error log for the port number. 
  - By default, remote connections to the Dedicated Administrator
    Connection (DAC) are not enabled. To enable remote DAC, use the
    Surface Area Configuration facet.
- SQL Server Browser service 
  - UDP port 1434 
  - The SQL Server Browser service listens for incoming connections to
    a named instance and provides the client the TCP port number that
    corresponds to that named instance. Normally the SQL Server
    Browser service is started whenever named instances of the
    Database Engine are used. The SQL Server Browser service does not
    have to be started if the client is configured to connect to the
    specific port of the named instance.
- Instance with HTTP endpoint. 
  - Can be specified when an HTTP endpoint is created. The default is
    TCP port 80 for CLEAR_PORT traffic and 443 for SSL_PORT traffic. 
  - Used for an HTTP connection through a URL.
- Default instance with HTTPS endpoint 
  - TCP port 443 
  - Used for an HTTPS connection through a URL. HTTPS is an HTTP
    connection that uses Transport Layer Security (TLS)
- Service Broker 
  - TCP port 4022. To verify the port used, execute the following
    query:
    ```sql
    SELECT name, protocol_desc, port, state_desc 
    FROM sys.tcp_endpoints
    WHERE type_desc = 'SERVICE_BROKER'
    ```
  - There is no default port for SQL ServerService Broker, but this is
    the conventional configuration used in Books Online examples.
- Transact-SQL debugger 
  - TCP port 135. The IPsec exception might also be required. 
  - If using Visual Studio, on the Visual Studio host computer, you
    must also add Devenv.exe to the Exceptions list and open TCP port
    135. If using Management Studio, on the Management Studio host
    computer, you must also add ssms.exe to the Exceptions list and
    open TCP port 135.

By default, named instances (including SQL Server Express) use dynamic
ports. That means that every time that the Database Engine starts, it
identifies an available port and uses that port number. If the named
instance is the only instance of the Database Engine installed, it
will probably use TCP port 1433. If other instances of the Database
Engine are installed, it will probably use a different TCP port.
Because the port selected might change every time that the Database
Engine is started, it is difficult to configure the firewall to enable
access to the correct port number. Therefore, if a firewall is used,
we recommend reconfiguring the Database Engine to use the same port
number every time.

An alternative to configuring a named instance to listen on a fixed
port is to create an exception in the firewall for a SQL Server
program such as sqlservr.exe (for the Database Engine). This can be
convenient, but the port number will not appear in the Local Port
column of the Inbound Rules page when you are using the Windows
Firewall with Advanced Security MMC snap-in. This can make it more
difficult to audit which ports are open.


## Overview of windows ports requirements

https://support.microsoft.com/en-us/help/832017/service-overview-and-network-port-requirements-for-windows


## Ports requirements for SQL Server

Firewall rules applys to all connections and have the same effects on
logins (traditional model connections) and contained database users.

## Ports requirements for SQL Database

SQL Database allows separate firewall rules for:
- server level connections (logins) and
- for database level connections (contained database users).

When connecting to a user database,:
- first database firewall rules are checked. 
- If there is no rule that allows access to the database, the server
  level firewall rules are checked, 
  - which requires access to the SQL Database server master database. 

Database level firewall rules combined with contained database users
can eliminate necessity to access master database.




# Azure

https://docs.microsoft.com/pl-pl/azure/azure-sql/database/firewall-configure





