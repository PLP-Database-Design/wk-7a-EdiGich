--1. 
-- Write an SQL query to transform the table into 1NF, ensuring that each row represents a single product for an order

--Creating a table ProductDetail_1NF that has three columns, i.e OrderId, CustomerName and Product
CREATE TABLE ProductDetail(
    OrderID INT,
    CustomerName VARCHAR(100,
    Product VARCHAR(100)
);

-- Inserting data into the ProductDetail_1NF table with each product in a separate row
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

--Question 2.
--In the table above, the CustomerName column depends on OrderID (a partial dependency), which violates 2NF.
-- Write an SQL query to transform this table into 2NF by removing partial dependencies. Ensure that each non-key column fully depends on the entire primary key.

--2nf can be achieved by removing partial dependencies from the OrderDetails table.
--Split the table into two tables, Orders table and OrderItems table.
-- Orders table has got two fields, OrderID and CustomerName.
-- OrderItems table has got 3 fields, OrderId, Product and Quantity field.

-- Creating the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

--Insert OrderID and CustomerName into the Orders table.
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

--The Product table
CREATE TABLE Product (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) -- Establish relationship with the Orders Table
);

--Insert data into OrderItems
INSERT INTO Product (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

--View the individual Orders and OrderItems tables.
SELECT * FROM Orders;
SELECT * FROM OrderItems;

-- Joining Orders and OrderItems tables based on the OrderID.  Each product appears with the correct customer.
SELECT 
    o.OrderID,
    o.CustomerName,
    oi.Product,
    oi.Quantity
FROM 
    Orders AS o
INNER JOIN 
    OrderItems AS oi ON o.OrderID = oi.OrderID
ORDER BY 
    o.OrderID;
