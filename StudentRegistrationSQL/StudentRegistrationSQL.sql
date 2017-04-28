BEGIN TRANSACTION 
--Create tables
CREATE TABLE Students
(ID uniqueidentifier Primary Key,
FirstName VARCHAR(50),
MiddleInitial VARCHAR(1),
LastName VARCHAR(50),
DateOfBirth DATE,
MajorID uniqueidentifier,
GenderID uniqueidentifier)

CREATE TABLE Majors
(MajorID uniqueidentifier Primary Key,
MajorName VARCHAR(100),
MajorDescription VARCHAR(200))

CREATE TABLE Gender
(GenderID uniqueidentifier Primary Key,
GenderName VARCHAR(15))

CREATE TABLE Classes
(ClassID uniqueidentifier Primary Key,
ClassName VARCHAR(8))

CREATE TABLE StudentClasses
(StudentClassesID uniqueidentifier PRIMARY KEY,
StudentID uniqueidentifier,
ClassID uniqueidentifier)

--Create logging table
CREATE TABLE Logs
(Process VARCHAR(50),
TheDate DATETIME)


--Declaration of variables
DECLARE @StudentID uniqueidentifier;
DECLARE @GenderID uniqueidentifier;
DECLARE @MajorID uniqueidentifier;
SET @StudentID = NEWID();
SET @GenderId = NEWID();
SET @MajorID = NEWID();

--Insert data for now
INSERT INTO Gender VALUES (@GenderID, 'Male');
INSERT INTO Majors (MajorID, MajorName, MajorDescription) 
VALUES (@MajorID, 'App Dev', 'Dev Applications')
INSERT INTO Students (ID, FirstName, MiddleInitial, LastName, DateOfBirth
,MajorID, GenderID) VALUES(@StudentID,'Jim', 'G', 'Foe', '04/06/1968', @MajorID, @GenderID)
GO

--Trigger creation
CREATE OR ALTER TRIGGER trgLog
ON Students FOR INSERT AS 
	INSERT INTO Logs (Process, TheDate)
	VALUES ('CREATE', GETDATE())
GO

CREATE OR ALTER TRIGGER trgLog
ON Students FOR UPDATE AS 
	INSERT INTO Logs (Process, TheDate)
	VALUES ('UPDATE', GETDATE())
GO

CREATE OR ALTER PROCEDURE sp_GetStudents
AS
SELECT * FROM Students
GO

--Execute the sproc, this will pull back the data inserted from above
EXEC sp_GetStudents


--If needed uncomment and run these to 
--DROP TABLE Students;
--DROP TABLE Majors;
--DROP TABLE Gender;
--DROP TABLE Classes;
--DROP TABLE StudentClasses;
--DROP TABLE Logs;
--DROP PROCEDURE sp_GetStudents;

--Commit to accept all data we have pushed through
COMMIT

--Roll back in case needed, commented out right now.
--ROLLBACK TRANSACTION

