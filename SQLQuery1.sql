CREATE DATABASE P220Store

USE P220Store

CREATE TABLE Brands
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(35) NOT NULL
)

CREATE TABLE Notebooks
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(150) NOT NULL,
	Price DECIMAL(18,2) CHECK(Price>=0),
	BrandId INT NOT NULL CONSTRAINT FK_Notebooks_Brands FOREIGN KEY REFERENCES Brands(Id)
)

INSERT INTO Brands
VALUES
('Apple'),
('Asus'),
('Acer'),
('Samsung')

SELECT * FROM Brands

INSERT INTO Notebooks
VALUES
('Macbook PRO 15', 5000, 1),
('Macbook PRO 13', 3500, 1),
('Macbook Air 15', 3800, 1),
('Predator', 4200, 3),
('Rog', 800, 2),
('Thinkpad X1', 5500, 2),
('E55', 1200, 3),
('E15', 2200, 3)

SELECT Notebooks.Name, Brands.Name AS 'BrandName',Price FROM Notebooks
JOIN Brands
ON Notebooks.BrandId=Brands.Id

SELECT * FROM Notebooks
JOIN Brands
ON Notebooks.BrandId=Brands.Id
WHERE Brands.Name LIKE '%s%'

SELECT * FROM Notebooks
WHERE (Price>=2000 AND Price<=5000) OR Price>5000

CREATE TABLE Phones
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100) NOT NULL,
	BrandId INT NOT NULL CONSTRAINT FK_Phones_Brands FOREIGN KEY REFERENCES Brands(Id)
)

ALTER TABLE Phones
ADD Price DECIMAL(18,2)

INSERT INTO Phones
VALUES
('E55',3,850),
('E15',2,1800),
('Iphone 12 PRO',1,3500),
('Iphone 11 PRO',1,2500),
('S10',4,1500),
('S20',4,2500)

SELECT Name,BrandId FROM Phones
UNION
SELECT Name,BrandId FROM Notebooks

SELECT Id,Name,Price,BrandId FROM Phones
UNION ALL
SELECT Id,Name,Price,BrandId FROM Notebooks

SELECT * FROM 
(
SELECT Phones.Id,Phones.Name,Price,Brands.Name as 'BrandName' FROM Phones
JOIN Brands
ON Phones.BrandId = Brands.Id
UNION ALL
SELECT Notebooks.Id,Notebooks.Name,Price,Brands.Name as 'BrandName' FROM Notebooks
JOIN Brands
ON Notebooks.BrandId = Brands.Id
) as tbl
WHERE Price>1000

SELECT Price,Brands.Name as 'BrandName' FROM Phones
JOIN Brands
ON Phones.BrandId = Brands.Id

SELECT Brands.Name as 'BrandName', SUM(Price) as 'TotalPrice', COUNT(Phones.Id) as 'ProductsCount' FROM Phones
JOIN Brands
ON Phones.BrandId = Brands.Id
GROUP BY Brands.Name


CREATE TABLE Departments
(Id INT PRIMARY KEY IDENTITY, 
 Name NVARCHAR(100),
 DepartmentId INT
 )

 SELECT SubDep.Id,SubDep.Name, MainDep.Name as 'MainDepartment' FROM Departments as SubDep
 LEFT JOIN Departments as MainDep
 ON SubDep.DepartmentId=MainDep.Id

 
CREATE TABLE SubDepartments
(Id INT PRIMARY KEY IDENTITY, 
 Name NVARCHAR(100),
 DepartmentId INT
 )


 -- VIEW Creation

 CREATE VIEW vw_allproducts
 AS
 SELECT Phones.Id,Phones.Name,Price,Brands.Name as 'BrandName' FROM Phones
JOIN Brands
ON Phones.BrandId = Brands.Id
UNION ALL
SELECT Notebooks.Id,Notebooks.Name,Price,Brands.Name as 'BrandName' FROM Notebooks
JOIN Brands
ON Notebooks.BrandId = Brands.Id



SELECT * FROM vw_allproducts
WHERE BrandName LIKE '%s%'

CREATE VIEW vw_allproductfrom2000
AS
SELECT * FROM vw_allproducts
WHERE Price>2000

SELECT * FROM vw_allproductfrom2000

CREATE VIEW vw_allproductsfrom2500anda
AS
SELECT * FROM vw_allproducts
WHERE Price>2500 AND BrandName LIKE '%s%'

SELECT * FROM vw_allproductsfrom2500anda

CREATE PROCEDURE usp_selectallproducts
@Price decimal(18,2)
AS
SELECT * FROM vw_allproducts WHERE Price>@Price

ALTER PROCEDURE usp_selectallproducts
@Price decimal(18,2),
@BrandName nvarchar(100)
AS
SELECT * FROM vw_allproducts WHERE Price>@Price AND BrandName LIKE '%'+@BrandName+'%'

exec usp_selectallproducts 3700,'ap'

CREATE PROCEDURE usp_deleteallproducts 
@MinPrice DECIMAL(18,2),
@MaxPrice DECIMAL(18,2),
@Search NVARCHAR(100)
AS
DELETE FROM Notebooks 
WHERE (Price BETWEEN @MinPrice AND @MaxPrice) AND (Name LIKE '%'+@Search+'%')

exec usp_deleteallproducts 4000,5000,'pro'

CREATE PROCEDURE usp_addnotebook
@BrandId INT,
@Name NVARCHAR(100),
@Price DECIMAL(18,2)
AS
INSERT INTO Notebooks (BrandId,Name,Price)
VALUES
(@BrandId,@Name,@Price)

exec usp_addnotebook 1,'Macbook PRO 15',5001

CREATE PROCEDURE usp_updatenotebookprice
@Id INT,
@NewPrice DECIMAL(18,2)
AS
UPDATE Notebooks
SET Price = @NewPrice
WHERE Id=@Id

exec usp_updatenotebookprice 9,5005

SELECT * FROM Notebooks
ORDER BY BrandId

SELECT * FROM Notebooks
ORDER BY Price DESC

SELECT DISTINCT Price FROM Notebooks

SELECT COUNT(Id) FROM Notebooks WHERE BrandId=1

SELECT 
Id,
Name,
(
	(SELECT COUNT(Id) FROM Notebooks WHERE BrandId=Brands.Id)
	+(SELECT COUNT(Id) FROM Phones WHERE BrandId=Brands.Id)
) as 'ProductsCount'  
FROM Brands

















