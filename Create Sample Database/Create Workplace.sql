/********************************************************
* This script creates the database MyWorkplace 
*********************************************************/
USE master;
GO --Execute now, do not wait for other commands

--Remove db if it already exists and recreate it (create fresh db)
IF  DB_ID('MyWorkplace') IS NOT NULL
DROP DATABASE MyWorkplace;
GO --Execute now, do not wait for other commands
CREATE DATABASE MyWorkplace;
GO --Execute now, do not wait for other commands

--Point to the db we just created
USE MyWorkplace

--We must create the department table first because it is referenced later
CREATE TABLE Department 
(
    Dept_Num	INT		PRIMARY KEY,
	Dept_name	VARCHAR(255)
)

CREATE TABLE Employee
(
    Emp_Fname	VARCHAR(MAX),
	Emp_Lname	VARCHAR(MAX),
	Emp_Addr	VARCHAR(MAX),
	Emp_City	VARCHAR(MAX),
	Emp_State	VARCHAR(255),
	Emp_Zip		VARCHAR(255),
	Emp_Salary	DECIMAL(10,2),

	--Here we reference our department table
	Dept_Num	INT				REFERENCES Department (Dept_Num),
)