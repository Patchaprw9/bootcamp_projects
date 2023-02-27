-- Restaurant Owners
-- 5 Tables
-- 1x Fact, 4x Dimension
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/ with

-- sqlite command
.mode markdown
.header on 

CREATE TABLE menu (
  menuId INT PRIMARY KEY,
  name TEXT,
  price REAL);

INSERT INTO menu VALUES
  (1, 'Papaya salad', 60),
  (2, 'Charcoal-boiled pork neck', 120),
  (3, 'Grilled chicken', 100),
  (4, 'Ground pork salad', 80),
  (5, 'Spicy Salad with Oyster', 200);
  
CREATE TABLE dim_payment_type (
  payment_type INT Primary KEY,
  payment_method TEXT
);
INSERT INTO dim_payment_type VALUES
  (1, 'Cash'),
  (2, 'Promtpay'),
   (3, 'Credit');
   
CREATE TABLE employee (
  employeeId INT UNIQUE,
  name TEXT,
  position TEXT,
  PRIMARY KEY (employeeId));
INSERT INTO employee VALUES 
  (1, 'Joy', 'Chef'),
  (2, 'Man', 'Staff'),
  (3, 'Pee', 'Staff'),
  (4, 'Toy', 'Chef');
  
  CREATE TABLE customer (
  customerId INT UNIQUE,
  name TEXT,
  customer_gender TEXT,
  PRIMARY KEY (customerId)
);

INSERT INTO customer VALUES 
  (1, 'Nack',  'M'),
  (2, 'Whan',  'F'),
  (3, 'Bow',  'F');
  
  CREATE TABLE orders (
  ordersId INT UNIQUE,
  customerId INT,
  employeeId INT,
  ordersDate DATE,
  ordersPrice REAL,
  payment_type INT,
  PRIMARY KEY (ordersId),
  FOREIGN KEY (customerId) references customer(customerId),
  FOREIGN KEY (employeeId) references employee(employeeId),
  FOREIGN KEY (payment_type) references dim_payment_type(payment_type)
);

INSERT INTO orders VALUES 
  (1, 1, 2, '2022-02-09', 2500,1),
  (2, 2, 2, '2022-02-28', 3560,2),
  (3, 3, 4, '2022-02-09', 6540,1),
  (4, 3, 4, '2022-02-07', 1750,1),
  (5, 2, 1, '2022-03-18', 3650,1),
  (6, 2, 2, '2022-03-28', 3560,2),
  (7, 3, 4, '2022-03-10', 6540,3),
  (8, 3, 4, '2022-03-15', 1750,2),
  (9, 1, 2, '2022-03-04', 2500,2),
  (10, 2, 2, '2022-03-29', 3560,2);

SELECT * FROM menu;
SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM dim_payment_type;
SELECT * FROM orders;


WITH totalSalesByCustomer AS (
  SELECT
  customer_gender,
  orders.customerId,
  ordersPrice
FROM customer
JOIN orders ON customer.customerId = orders.customerId
)
SELECT
  customerId,
  customer_gender,
  SUM(ordersPrice) AS TotalSales
FROM totalSalesByCustomer
WHERE  customer_gender LIKE 'M'
GROUP BY customerId
ORDER BY totalSales DESC;

SELECT
  Month,
  COUNT(*) AS Sum_orders_M
FROM (
  SELECT 
  ordersDate,
  CASE 
  WHEN STRFTIME('%m',ordersDate) LIKE '02' THEN 'FEB'
  ELSE 'MAR'
  END AS 'Month'
FROM orders
) AS sub
GROUP BY month
ORDER BY Sum_orders_M DESC;
