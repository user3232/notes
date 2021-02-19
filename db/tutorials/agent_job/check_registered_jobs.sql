USE msdb;
GO

EXEC sp_help_jobactivity ;
GO

EXEC sp_help_job ;
GO

EXEC dbo.sp_help_jobstep  
    @job_name = N'Daily SampleDB Backup' ;  
GO  