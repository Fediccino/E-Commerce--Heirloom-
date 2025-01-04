DROP DATABASE IF EXISTS data_is_sexy;
CREATE DATABASE data_is_sexy;
USE data_is_sexy;


-- Create Address Table 
CREATE TABLE Address (
	AddressID CHAR(36) NOT NULL,
    Street_Address VARCHAR(100) NULL,
    City VARCHAR(100) NULL,
    State CHAR(2) NULL,
    Zip VARCHAR(100) NULL,
    Country VARCHAR(100) NULL,
    PRIMARY KEY (AddressID)
);

-- Create Office Table
CREATE TABLE Office (
	OfficeID CHAR(36) NOT NULL,
    Office_Name VARCHAR(100) NULL,
    AddressID CHAR(36) NOT NULL,
    PRIMARY KEY (OfficeID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Employees Table 
CREATE TABLE Employees (
	EmployeeID CHAR(36) NOT NULL,
    OfficeID CHAR(36) NOT NULL,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(250) NULL,
    ManagerID CHAR(36) NULL,
    Hire_Date DATETIME NOT NULL,
    Department VARCHAR(100) NOT NULL,
    AddressID CHAR(36) NOT NULL,
    Salary VARCHAR(100) NOT NULL,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (OfficeID) REFERENCES Office(OfficeID)
);

-- Stores Table 
CREATE TABLE Stores (
	StoreID CHAR(36) NOT NULL,
    OfficeID CHAR(36) NOT NULL,
    Store_Name VARCHAR(100) NULL,
    PRIMARY KEY (StoreID),
    FOREIGN KEY (OfficeID) REFERENCES Office(OfficeID)
);

-- Customers Table 
CREATE TABLE Customers (
	CustomerID CHAR(36) NOT NULL,
    StoreID CHAR(36) NULL,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NULL,
    Phone VARCHAR(100) NULL,
    Registration_Date DATETIME NOT NULL,
    AddressID CHAR(36),
	PRIMARY KEY (CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Payment Status Table 
CREATE TABLE Payment_Status (
	Payment_Status_ID CHAR(36) NOT NULL,
    Description VARCHAR(100) NOT NULL,
    PRIMARY KEY (Payment_Status_ID)
);

-- Payment Method Table 
CREATE TABLE Payment_Method (
	MethodID CHAR(36) NOT NULL,
    Description VARCHAR(100) NOT NULL,
    PRIMARY KEY (MethodID)
);


-- Needs to be completed still
-- Payment Table 
CREATE TABLE Payment (
	PaymentID CHAR(36) NOT NULL,
    CustomerID CHAR(36) NOT NULL,
    Amount DECIMAL(8,2) NOT NULL,
    Card_Number CHAR(16) NOT NULL,
    Payment_Date DATETIME NOT NULL,
	Payment_Status CHAR(36) NOT NULL,
    Payment_Method CHAR(36) NOT NULL,
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (Payment_Status) REFERENCES Payment_Status(Payment_Status_ID),
    FOREIGN KEY (Payment_Method) REFERENCES Payment_Method(MethodID)
);

-- Shipping Status Table 
CREATE TABLE Shipping_Status (
	Shipping_Status_ID CHAR(36) NOT NULL,
    Description VARCHAR(100) NOT NULL,
    PRIMARY KEY (Shipping_Status_ID)
);

-- Needs to be completed still
-- Shipping Table 
CREATE TABLE Shipping (
	ShippingID CHAR(36) NOT NULL,
    OrderID CHAR(36) NOT NULL,
    Shipping_Status CHAR(36) NULL,
    AddressID CHAR(36) NOT NULL,
    PRIMARY KEY (ShippingID),
    -- FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), THIS COMMAND NEEDS TO COME AFTER WE HAVE CREATED THE ORDERS TABLE THEREFORE WE WILL NEED TO CREATE A COMMAND LATER TO ALTER TABLE ADD FOREIGN KEY
    -- Created at line 176
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (Shipping_Status) REFERENCES Shipping_Status(Shipping_Status_ID)
);

-- Order Status Table 
CREATE TABLE Order_Status (
	Order_StatusID CHAR(36) NOT NULL,
    Description VARCHAR(100) NOT NULL,
    PRIMARY KEY (Order_StatusID)
);

-- Orders Table 
CREATE TABLE Orders (
	OrderID CHAR(36) NOT NULL,
    CustomerID CHAR(36) NOT NULL,
    ShippingID CHAR(36) NOT NULL,
    PaymentID CHAR(36) NOT NULL,
    Order_Date DATETIME NOT NULL,
    Order_Status CHAR(36) NOT NULL,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ShippingID) REFERENCES Shipping(ShippingID),
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
    FOREIGN KEY (Order_Status) REFERENCES Order_Status(Order_StatusID)
);

-- Category Table 
CREATE TABLE Category (
	CategoryID CHAR(36),
    Description VARCHAR(100),
    PRIMARY KEY (CategoryID)
);

-- Products Table 
CREATE TABLE Products (
	ProductID CHAR(36) NOT NULL,
    ManufacturerID CHAR(36) NOT NULL,
    Gender VARCHAR(25) NULL,
    Size CHAR(2) NULL,
    Color VARCHAR(100) NULL,
    Type VARCHAR(100),
    CategoryID CHAR(36),
    PRIMARY KEY (ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Needs to be completed still
-- OrderProducts Table 
CREATE TABLE OrderProducts (
	OrderProductID CHAR(36) NOT NULL,
    ProductID CHAR(36) NOT NULL,
    Quantity DECIMAL(8,2) NOT NULL,
    Price DECIMAL(8,2) NOT NULL,
    -- Discount STRING FUNCTION OR DECIMAL? 
    PRIMARY KEY (OrderProductID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Manufacturer Table 
CREATE TABLE Manufacturer (
	ManufacturerID CHAR(36),
    Description VARCHAR(100),
    AddressID CHAR(36),
    PRIMARY KEY (ManufacturerID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Additional foreign key for 
ALTER TABLE Shipping ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

-- Inserting Statuses and Methods
INSERT INTO Shipping_Status VALUES (1, 'Order Confirmed');
INSERT INTO Shipping_Status VALUES (2, 'Label Created');
INSERT INTO Shipping_Status VALUES (3, 'Shipped');
INSERT INTO Shipping_Status VALUES (4, 'Delivered');
INSERT INTO Payment_Status VALUES (1, 'In Progress');
INSERT INTO Payment_Status VALUES (2, 'Payment Accepted');
INSERT INTO Payment_Status VALUES (3, 'Payment Declined');
INSERT INTO Payment_Method VALUES (1, 'Credit/Debit Card');
INSERT INTO Order_Status VALUES (1, 'Confirmed');
INSERT INTO Order_Status VALUES (2, 'Being Processed');
INSERT INTO Order_Status VALUES (3, 'Processed');
INSERT INTO Order_Status VALUES (4, 'Order Shipped');

-- Insert Address Records
INSERT INTO Address (AddressID, Street_Address, City, State, Zip, Country)
VALUES 
('005a3810-f371-42af-8d24-4275d928cbfd', '48524 Rigney Street', 'Los Angeles', 'CA', '90065', 'USA'),
('cdc25830-2d86-4b0f-9431-9d14b12eb13d', '456 Elm St', 'Springfield', 'IL', '62702', 'USA'),
('dc4a0381-926d-4197-8a30-869e088e6c0e', '2 Eastlawn Lane', 'Cincinnati', 'OH', '45243', 'USA'),
('0339dc55-d85c-4540-816f-b54c11c749fe', '4993 Hanson Circle', 'Miami' ,'FL', '33158', 'USA'),
('a4d23af8-964c-4546-b2ff-d7c203d860cc', '90 Southridge Trail', 'Oklahoma City', 'OK', '73124', 'USA'),
('ba96ee6a-30c5-485e-8036-fe657c77d1d5', '66987 SChurz Park', 'Erie', 'PA', '16505' , 'USA'),
('ba28b75b-0a4e-4e6a-a18c-c9a59004d934', '9446 West Park', 'Portland', 'ME', '41009', 'USA'),
('18bd0c76-1492-43d7-9563-3cb326045923', '4 3rd Center', 'Portland', 'OR', '97216', 'USA'),
('5715d2fd-6095-4870-8790-5b25eb3c3d3f', '13306 South Center', 'Reston', 'VA', '22096', 'USA'),
('68005f7a-33a0-4c2c-b110-8abdec20eaf3', '8 Trailsway Way', 'San Francisco', 'CA', '94137', 'USA'),
('2621752d-12c7-4b97-9d90-ccc2380b1d18', '89 Sunpoint', 'Amarillo', 'TX', '79171', 'USA');

-- Insert Office Records
INSERT INTO Office (OfficeID, Office_Name, AddressID)
VALUES 
('cdc25830-2d86-4b0f-9032-9d14b12eb13f', 'Heirloom', 'cdc25830-2d86-4b0f-9431-9d14b12eb13d');


-- Insert Employee Records
/* 				Mock Template
INSERT INTO Employees 
VALUES 
('', -- EmployeeID
 '', -- OfficeID
 '', -- First_Name
 '', -- Last_Name
 '', -- Email
 '', -- ManagerID
 '', -- Hire_Date
 '', -- Department
 '', -- AddressID
 35365.28 -- Salary
);				*/
INSERT INTO Employees 
VALUES 
('015a3810-f371-42af-8d24-4275d937cbzp', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Griselda', -- First_Name
 'Grigoire', -- Last_Name
 'ggrigoire4n@cloudflare.com', -- Email
 'c8be0545-f49f-4d13-8167-c313bb0a9bd6', -- ManagerID
 '2024-01-01 13:04:20', -- Hire_Date
 'Finance', -- Department
 '005a3810-f371-42af-8d24-4275d928cbfd', -- AddressID
 105365.28 -- Salary
);

INSERT INTO Employees 
VALUES 
('04f97f6f-6c7d-4eac-adf5-d6704ba9d94d', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Valina', -- First_Name
 'Thomerson', -- Last_Name
 'vthomerson6s@dell.com', -- Email
 '005a3810-f371-42af-8d24-4275d928cbfd', -- ManagerID
 '2024-09-13 13:04:20', -- Hire_Date
 'Finance', -- Department
 'dc4a0381-926d-4197-8a30-869e088e6c0e', -- AddressID
 60365.28 -- Salary
);

INSERT INTO Employees 
VALUES 
('0a6cadc8-973a-4233-9550-82ff0dd5df7e', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Wakefield', -- First_Name
 'Ambrogio', -- Last_Name
 'wambrogio7r@creativecommons.org', -- Email
 '005a3810-f371-42af-8d24-4275d928cbfd', -- ManagerID
 '2024-11-11 1:01:01', -- Hire_Date
 'Finance', -- Department
 '0339dc55-d85c-4540-816f-b54c11c749fe', -- AddressID
67652.35 -- Salary
);

INSERT INTO Employees 
VALUES 
('87f97f6f-6c7d-4eac-adf5-d6784ba9d69d', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Valentine', -- First_Name
 'Thomerson', -- Last_Name
 'vthomerson6s@dell.com', -- Email
 '005a3810-f371-42af-8d24-4275d928cbfd', -- ManagerID
 '2024-05-30 13:28:34', -- Hire_Date
 'Finance', -- Department
 'a4d23af8-964c-4546-b2ff-d7c203d860cc', -- AddressID
 65890.44 -- Salary
);

INSERT INTO Employees 
VALUES 
('760d8158-bc3e-463a-9777-c3bfa97761c3', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Basile', -- First_Name
 'Geistman', -- Last_Name
 'bgeistmann27@acquirethisname.com', -- Email
 '09d8bb95-97a2-4d69-be58-a5dccbac7dcf', -- ManagerID
 '2024-01-06 23:39:19', -- Hire_Date
 'HR', -- Department
 'ba96ee6a-30c5-485e-8036-fe657c77d1d5', -- AddressID
 35365.28 -- Salary
);

INSERT INTO Employees 
VALUES 
('8c5f5468-7107-45af-8a7a-4b661efe312e', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Donal', -- First_Name
 'Malley', -- Last_Name
 'dmalley5d@ycombinator.com', -- Email
 '09d8bb95-97a2-4d69-be58-a5dccbac7dcf', -- ManagerID
 '2024-02-12 22:16:46', -- Hire_Date
 'HR', -- Department
 '18bd0c76-1492-43d7-9563-3cb326045923', -- AddressID
 55365.28 -- Salary
);

INSERT INTO Employees 
VALUES 
('f8153238-b1fa-441b-a2c6-e2629f5c39ef', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Kevin', -- First_Name
 'Chabau', -- Last_Name
 'dmalley345d@ycombinator.com', -- Email
 '09d8bb95-97a2-4d69-be58-a5dccbac7dcf', -- ManagerID
 '2024-02-12 22:16:46', -- Hire_Date
 'HR', -- Department
 '18bd0c76-1492-43d7-9563-3cb326045923', -- AddressID
 55365.28 -- Salary
);


INSERT INTO Employees 
VALUES 
('d96aed0c-aa4f-4230-9bf2-3ef8ba26cd47', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Kendall', -- First_Name
 'Heppenspall', -- Last_Name
 'kheppenspall57@kickstarter.com', -- Email
 'c8be0545-f49f-4d13-8167-c313bb0a9bd6', -- ManagerID
 '2024-11-06 11:55:39', -- Hire_Date
 'IT', -- Department
 '18bd0c76-1492-43d7-9563-3cb326045923', -- AddressID
 85365.28 -- Salary
);

INSERT INTO Employees 
VALUES 
('dd12cc5b-6278-4aed-b534-cd3321111ee7', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Tina', -- First_Name
 'Jeannequin', -- Last_Name
 'tjeannequin17@slate.com', -- Email
 'c8be0545-f49f-4d13-8167-c313bb0a9bd6', -- ManagerID
 '2024-02-27 9:56:47', -- Hire_Date
 'Marketing', -- Department
 '5715d2fd-6095-4870-8790-5b25eb3c3d3f', -- AddressID
 85365.28 -- Salary
);

INSERT INTO Employees 
VALUES 
('b5ac9d30-a08a-4278-b6db-d48f49c2429d', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Quill', -- First_Name
 'Sword', -- Last_Name
 'qsword78@cdc.gov', -- Email
 'dd12cc5b-6278-4aed-b534-cd3321111ee7', -- ManagerID
 '2024-07-31 9:22:20', -- Hire_Date
 'Marketing', -- Department
 '68005f7a-33a0-4c2c-b110-8abdec20eaf3', -- AddressID
 35365.28 -- Salary
);

INSERT INTO Employees 
VALUES 
('436d1965-bfb1-4a7d-9336-3cbdbdb7d244', -- EmployeeID
 'cdc25830-2d86-4b0f-9032-9d14b12eb13f', -- OfficeID
 'Cass', -- First_Name
 'Bruton', -- Last_Name
 'cbrunton3g@wufoo.com', -- Email
 'c8be0545-f49f-4d13-8167-c313bb0a9bd6', -- ManagerID
 '2024-02-09 22:27:11', -- Hire_Date
 'Sales', -- Department
 '2621752d-12c7-4b97-9d90-ccc2380b1d18', -- AddressID
 35365.28 -- Salary
);