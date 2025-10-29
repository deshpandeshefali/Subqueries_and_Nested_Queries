-- Task 6 – Subqueries and Nested Queries
-- Demonstrates scalar, correlated, and derived-table subqueries

CREATE DATABASE IF NOT EXISTS sql_task6;
USE sql_task6;

-- Drop tables for repeat runs
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;

-- ========== 1 . Schema Setup ==========
CREATE TABLE Customers(
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(100),
  City VARCHAR(50)
);

CREATE TABLE Products(
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(100),
  Price DECIMAL(10,2)
);

CREATE TABLE Orders(
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductID INT,
  Quantity INT,
  OrderDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ========== 2 . Insert Sample Data ==========
INSERT INTO Customers VALUES
(1,'Asha Patel','Mumbai'),
(2,'Rahul Sharma','Delhi'),
(3,'Meera Singh','Pune'),
(4,'Karan Joshi','Bengaluru');

INSERT INTO Products VALUES
(101,'Notebook',150.00),
(102,'Bracelet',250.00),
(103,'Greeting Card',50.00),
(104,'Photo Frame',400.00);

INSERT INTO Orders VALUES
(1001,1,101,2,'2025-09-01'),
(1002,2,102,1,'2025-09-03'),
(1003,3,103,5,'2025-09-04'),
(1004,1,104,1,'2025-09-05'),
(1005,2,103,10,'2025-09-06'),
(1006,3,104,1,'2025-09-10'),
(1007,4,101,3,'2025-09-12');

-- ========== 3 . Queries with Subqueries ==========

-- 1️ Scalar subquery in SELECT → show each product with avg price for comparison
SELECT ProductName,
       Price,
       (SELECT AVG(Price) FROM Products) AS AveragePrice,
       CASE WHEN Price > (SELECT AVG(Price) FROM Products)
            THEN 'Above Average' ELSE 'Below Average' END AS PriceLevel
FROM Products;

-- 2️ Subquery in WHERE → customers who bought a product costlier than avg price
SELECT DISTINCT c.CustomerName
FROM Customers c
WHERE c.CustomerID IN (
    SELECT o.CustomerID
    FROM Orders o JOIN Products p ON o.ProductID = p.ProductID
    WHERE p.Price > (SELECT AVG(Price) FROM Products)
);

-- 3️ Correlated subquery → each customer’s total spent
SELECT c.CustomerName,
       (SELECT SUM(o.Quantity * p.Price)
        FROM Orders o JOIN Products p ON o.ProductID = p.ProductID
        WHERE o.CustomerID = c.CustomerID) AS TotalSpent
FROM Customers c;

-- 4️ EXISTS subquery → customers who have placed at least one order
SELECT CustomerName
FROM Customers c
WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID);

-- 5 IN vs EXISTS comparison → same result two ways
SELECT CustomerName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders);

SELECT CustomerName
FROM Customers c
WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID);

-- 6 Nested subquery → find product(s) with highest total sales value
SELECT ProductName
FROM Products
WHERE ProductID IN (
  SELECT ProductID
  FROM Orders
  GROUP BY ProductID
  HAVING SUM(Quantity * (SELECT Price FROM Products p2 WHERE p2.ProductID = Orders.ProductID))
  = (SELECT MAX(TotalSales)
    FROM (SELECT SUM(Quantity * (SELECT Price FROM Products p3 WHERE p3.ProductID = Orders.ProductID)) AS TotalSales
        FROM Orders GROUP BY ProductID) AS x)
);

