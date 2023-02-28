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
  PRIMARY KEY (customerId));
INSERT INTO customer VALUES 
  (1, 'Nack', 		'M'),
  (2, 'Whan', 	   'F'),
  (3, 'Bow', 		 'F'),
  (4, 'Nun', 		 'F'),
  (5, 'Boss', 			'M'),
  (6, 'Fin', 		'M'),
  (7, 'Dav',		'M'),
  (8, 'Ekk', 		'M'),
  (9, 'Burira',		'F'),
  (10,'Kitty', 		'F'),
  (11,'Emma',	'F'),
  (12,'Will',		'F'),
  (13,'Venus',  	'F'),
  (14,'Phing',		'F'),
  (15,'Tor', 		'M'),
  (16,'Kik ',		'F');
  
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
  (1,  1, 2, '2022-02-09', 250,1),
  (2,  2, 2, '2022-02-28', 350,2),
  (3,  3, 4, '2022-02-09', 640,1),
  (4,  3, 4, '2022-02-07', 1750,1),
  (5,  2, 1, '2022-03-18', 350,1),
  (6,  2, 2, '2022-02-08', 260,2),
  (7, 16 ,4,'2022-03-10', 640,3),
  (8, 15, 4, '2022-03-15', 150,2),
  (9, 14, 2,'2022-03-04', 2500,2),
  (10, 12, 2, '2022-03-29', 360,2),
  (11,13  ,2,'022-02-09', 1200,1),
  (12, 2  , 2, '2022-02-08', 560,2),
  (13, 3 , 4, '2022-02-09', 640,1),
  (14, 6  ,4,'2022-03-04', 70,1),
  (15, 8, 1, '2022-02-15', 350,1),
  (16, 9, 2, '2022-02-15',3560,2),
  (17,10, 4, '2022-02-15',640,3),
  (18,4, 4, '2022-02-15',750,2),
  (19,5, 2, '2022-03-04',2500,2),
  (20, 6, 2, '2022-03-29',3560,2),
  (21,7, 2, '2022-03-07',500,1),
  (22,8, 2, '2022-03-08', 1360,2),
  (23,9, 4, '2022-02-09', 640,1),
  (24, 10,2,  '2022-03-07',1750,1),
  (25,11, 1, '2022-03-18', 350,1),
  (26, 12,1, '2022-03-18', 3550,1),
  (27, 15,4,'2022-03-10', 540,3),
  (28 ,13,4, '2022-03-15', 1750,2),
  (29 ,12,2,'2022-02-04', 2500,2),
  (30 , 8,2, '2022-02-29', 360,2),
  (31 , 6,2, '2022-02-29', 380,2)
  ;
  
 SELECT * FROM menu;
SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM dim_payment_type;
SELECT * FROM orders;

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

WITH totalSalesByCustomer AS (
  SELECT
  customer_gender,
  orders.customerId,
  name,
  ordersPrice
FROM customer
JOIN orders ON customer.customerId = orders.customerId
)
SELECT
  customerId,
  name,
  customer_gender,
  SUM(ordersPrice) AS TotalSales_Men
FROM totalSalesByCustomer
WHERE  customer_gender LIKE 'M'
GROUP BY customerId
ORDER BY TotalSales_Men DESC;


