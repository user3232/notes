#!/bin/sh

# stop on errors:
set -e

# make this file executable
# chmod +x script.sh

# SQL Server configuration tool:
# https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-linux-ver15
mssqlconf=/opt/mssql/bin/mssql-conf
sudo $mssqlconf -h
# Locale pl_PL not supported. Using en_US.
# usage: mssql-conf [-h] [-n]  ...
# 
# positional arguments:
# 
#     setup             Initialize and setup Microsoft SQL Server
#     set               Set the value of a setting
#     unset             Unset the value of a setting
#     list              List the supported settings
#     get               Gets the value of all settings in a section or of an
#                       individual setting
#     traceflag         Enable/disable one or more traceflags
#     set-sa-password   Set the system administrator (SA) password
#     set-collation     Set the collation of system databases
#     validate          Validate the configuration file
#     set-edition       Set the edition of the SQL Server instance
#     validate-ad-config
#                       Validate configuration for Active Directory
#                       Authentication
#     setup-ad-keytab   Create a keytab for SQL Server to use to authenticate AD
#                       users
# 
# optional arguments:
#   -h, --help          show this help message and exit
#   -n, --noprompt      Does not prompt the user and uses environment variables
#                       or defaults.


# SQL Server CLI query tool
# https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-linux-ver15
# https://docs.microsoft.com/en-us/sql/ssms/scripting/sqlcmd-use-the-utility?view=sql-server-linux-ver15
# Typical usage:
# - execute script:
#   sqlcmd -U MyLogin -S <ComputerName>\<InstanceName> -i <MyScript.sql> -o <MyOutput.rpt>
# - inlien qeuery and exit:
#   sqlcmd -U MyLogin -S <ComputerName>\<InstanceName> -Q 'SELECT * FROM blbbla'
sqlcmd=/opt/mssql-tools/bin/sqlcmd
$sqlcmd -?
# Microsoft (R) SQL Server Command Line Tool
# Version 17.6.0001.1 Linux
# Copyright (C) 2017 Microsoft Corporation. All rights reserved.
# 
# usage: sqlcmd            [-U login id]          [-P password]
#   [-S server or Dsn if -D is provided] 
#   [-H hostname]          [-E trusted connection]
#   [-N Encrypt Connection][-C Trust Server Certificate]
#   [-d use database name] [-l login timeout]     [-t query timeout]
#   [-h headers]           [-s colseparator]      [-w screen width]
#   [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
#   [-c cmdend]
#   [-q "cmdline query"]   [-Q "cmdline query" and exit]
#   [-m errorlevel]        [-V severitylevel]     [-W remove trailing spaces]
#   [-u unicode output]    [-r[0|1] msgs to stderr]
#   [-i inputfile]         [-o outputfile]
#   [-k[1|2] remove[replace] control characters]
#   [-y variable length type display width]
#   [-Y fixed length type display width]
#   [-p[1] print statistics[colon format]]
#   [-R use client regional setting]
#   [-K application intent]
#   [-M multisubnet failover]
#   [-b On error batch abort]
#   [-D Dsn flag, indicate -S is Dsn] 
#   [-X[1] disable commands, startup script, environment variables [and exit]]
#   [-x disable variable substitution]
#   [-g enable column encryption]
#   [-G use Azure Active Directory for authentication]
#   [-? show syntax summary]


# To enable SQL Server Agent:
sudo $mssqlconf set sqlagent.enabled true

# check config file:
echo SQL Server config file:
sudo cat /var/opt/mssql/mssql.conf

# restart SQL server
sudo systemctl restart mssql-server

# connect as server administrator (SA user)
# set connection password in env var:
# https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables?view=sql-server-linux-ver15
# does not work for sqlcmd :-(
MSSQL_SA_PASSWORD='tex78MM!!.kk'

$sqlcmd -S localhost -U SA -P 'tex78MM!!.kk' -Q  'CREATE DATABASE SampleDB'
$sqlcmd -S localhost -U SA -P 'tex78MM!!.kk' -Q 'SELECT Name FROM sys.Databases'


# Database is created, lets now register and start 'Daily SampleDB Backup' job using script:
$sqlcmd -S localhost -U SA -P 'tex78MM!!.kk' -i daily_backup_job_setup.sql


# to delete job:
delete_Daily_SampleDB_Backup_job="
USE msdb ;  
GO  
  
EXEC sp_delete_job  
    @job_name = N'Daily SampleDB Backup' ;  
GO
"

$sqlcmd -S localhost -U SA -P 'tex78MM!!.kk' -Q $delete_Daily_SampleDB_Backup_job

