
-- delete job
USE msdb ;  
GO  
  
EXEC sp_delete_job  
    @job_name = N'Daily SampleDB Backup' ;  
GO

-- drop database

DROP DATABASE SampleDB ;
GO