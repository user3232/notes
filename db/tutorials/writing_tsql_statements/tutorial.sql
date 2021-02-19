-- Tutorial based on:
-- https://docs.microsoft.com/en-us/sql/t-sql/tutorial-writing-transact-sql-statements?view=sql-server-ver15

-- **************************
-- Lets create database
-- **************************

CREATE DATABASE TestData ;
GO

-- and switch to TestData namespace
USE TestData ;
GO

-- **************************
-- Lets create table
-- **************************

CREATE TABLE dbo.Products  
   (ProductID int PRIMARY KEY NOT NULL,  
   ProductName varchar(25) NOT NULL,  
   Price money NULL,  
   ProductDescription varchar(max) NULL)  
GO

-- **************************
-- Lets insert some data
-- **************************

Insert into dbo.Products 
  (ProductID, ProductName, Price, ProductDescription)
VALUES
  (1, 'clamp', 12.48, 'Workbench clamp'),
  (50, 'Screwdriver', 3.17, 'Flat head'),
  (75, 'Tire Bar', null, 'Tool for changing tires.'),
  (3000, '3 mm Bracket', 0.52, null)
GO


-- **************************
-- Lets update some rows
-- **************************

-- Update rows in table 'dbo.Products'
UPDATE dbo.Products
SET
  ProductName = 'Flat Head Screwdriver'
  -- , [Colum2] = Colum2_Value
WHERE 	ProductID = 50
GO


-- **************************
-- Lets read data
-- **************************

select ProductID, ProductName, Price, ProductDescription
from dbo.Products
go

-- Returns all columns in the table  
-- Does not use the optional schema, dbo  
SELECT * FROM Products  
GO

-- Returns only two of the columns from the table  
SELECT ProductName, Price  
    FROM dbo.Products  
GO

-- Returns only two of the records in the table  
SELECT ProductID, ProductName, Price, ProductDescription  
    FROM dbo.Products  
    WHERE ProductID < 60  
GO

-- Returns ProductName and the Price including a 7% tax  
-- Provides the name CustomerPays for the calculated column  
SELECT ProductName, Price * 1.07 AS CustomerPays  
    FROM dbo.Products  
GO



-- **************************
-- Lets create some view
-- **************************

CREATE VIEW vw_Names  
   AS  
   SELECT ProductName, Price FROM Products;  
GO

-- and query this view
SELECT * FROM vw_Names;  
GO

-- **************************
-- Lets create some stored procedure
-- **************************

CREATE PROCEDURE pr_Names
  @VarPrice money -- (money is data type)
AS
BEGIN
  -- log some text to users using print
  PRINT 'Products less than ' + CAST(@VarPrice AS varchar(10));
  -- next statement returns rows
  SELECT ProductName, Price 
  FROM vw_Names
  WHERE Price < @VarPrice ;
END
GO

-- lets use above procedure
EXEC pr_Names @VarPrice = 10.00 ;
GO

-- **************************
-- Lets create login
-- **************************

CREATE LOGIN Mary 
WITH
  PASSWORD = 'maryPass!1' ;
GO


-- **************************
-- Lets create user
-- **************************

/*
Mary now has access to this instance of SQL Server, 
but does not have permission to access the databases. 
She does not even have access to her default database TestData 
until you authorize her as a database user.

To grant Mary access, switch to the TestData database, 
and then use the CREATE USER statement to map her login 
to a user named Mary.

https://docs.microsoft.com/en-us/sql/t-sql/statements/create-login-transact-sql?view=sql-server-ver15#examples

https://docs.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver15
*/

-- switch to database context
USE [TestData];
GO

CREATE USER [Mary] FOR LOGIN [Mary];
GO


-- **************************
-- Lets grant permissions to users
-- **************************

-- allow execute on stored procedure
GRANT EXECUTE ON pr_Names TO Mary;
GO

-- allow select on view
GRANT SELECT ON vw_Names TO Mary ;
GO


/*
Mary may now connect, using sqlcmd it would be:

$ /opt/mssql-tools/bin/sqlcmd \
  -S localhost \
  -U Mary \
  -P 'maryPass!1' \
  -Q 'SELECT * FROM vw_Products'
*/



-- **************************
-- Now eventually undo all of above
-- **************************

/*

USE TestData;  
GO

-- Revoke stored procedure permissions
REVOKE EXECUTE ON pr_Names FROM Mary;  
GO
-- Revoke view selection permissions
REVOKE SELECT ON vw_Names FROM Mary;  
GO

-- remove permission for Mary to access the TestData database:
DROP USER Mary;  
GO

-- remove permission for Mary to access this instance of SQL Server
DROP LOGIN [Mary];  
GO

-- remove the store procedure pr_Names:
DROP PROC pr_Names;  
GO

-- remove the view vw_Names
DROP VIEW vw_Names;  
GO

-- remove all rows from the Products table:
DELETE FROM Products;  
GO

-- remove the Products table:
DROP TABLE Products;  
GO

-- you cannot remove the TestData database while you are in the database
-- so change db to master
USE MASTER;  
GO  

-- remove database
DROP DATABASE TestData;  
GO

*/