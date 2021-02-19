-- Adds a new job executed by the SQLServerAgent service
-- called 'Daily SampleDB Backup'

-- register job in msdb
USE msdb;
GO

EXEC dbo.sp_add_job
  @job_name = N'Daily SampleDB Backup' ;
GO

-- Adds a step (operation) to the job
EXEC sp_add_jobstep
  @job_name  = N'Daily SampleDB Backup',
  @step_name = N'Backup database',
  @subsystem = N'TSQL',
  @command   = N'
    BACKUP DATABASE SampleDB 
    TO 
      DISK = N''/var/opt/mssql/data/SampleDB.bak'' 
    WITH 
      NOFORMAT, 
      NOINIT, 
      NAME = ''SampleDB-full'', 
      SKIP, 
      NOREWIND, 
      NOUNLOAD, 
      STATS = 10
  ',
  @retry_attempts = 5,
  @retry_interval = 5 ;
GO

-- Creates a schedule called 'Daily'
EXEC sp_add_schedule
  @schedule_name = N'Daily SampleDB',
  @freq_type     = 4,
  @freq_interval = 1,
  @active_start_time = 233000 ;
GO

-- Sets the 'Daily' schedule to the 'Daily SampleDB Backup' Job
EXEC sp_attach_schedule
   @job_name = N'Daily SampleDB Backup',
   @schedule_name = N'Daily SampleDB';
GO

/* 
  Use sp_add_jobserver to assign the job to a target server.
  In this example, the target is the local server.
  
  But if for example /etc/hosts have entries for:
  
    127.0.0.1 ubuntu
    127.0.0.1 ubuntu.michal.com
    192.168.1.10 locRemUbuntu
    192.168.1.10 locRemUbuntu.michal.com
   
  one could use:
  
    EXEC dbo.sp_add_jobserver
      @job_name = N'Daily SampleDB Backup',
      @server_name = N'(locRemUbuntu)';
    GO

  This would cause to execute tsql script 
  on different machine. This procedure is possible
  from master server for jobs, other servers
  would have to enlist as slave job servers.

  Script should be universal (e.g. backup master dbs 
  on echa server).
  
  Example:
  - https://www.sqlshack.com/multiserver-administration-master-target-sql-agent-jobs/
  - https://docs.microsoft.com/en-us/sql/ssms/agent/automated-administration-across-an-enterprise?redirectedfrom=MSDN&view=sql-server-ver15
  - https://dba.stackexchange.com/questions/25534/what-is-a-target-server-in-a-sql-server-agent-job
*/
EXEC dbo.sp_add_jobserver
   @job_name = N'Daily SampleDB Backup',
   @server_name = N'(LOCAL)';
GO

-- Lets Start the job
EXEC dbo.sp_start_job N'Daily SampleDB Backup' ;
GO