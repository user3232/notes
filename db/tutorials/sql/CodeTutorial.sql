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