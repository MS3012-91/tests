CREATE TYPE product_type AS ENUM ('pizza', 'additive');

CREATE TABLE Products (
    id serial PRIMARY KEY,
    type product_type NOT NULL,
    name varchar(60) NOT NULL,
    descripton text
);


CREATE TABLE Manufacturers (
    id serial PRIMARY KEY,
    name varchar(60) UNIQUE NOT NULL,
    gain numeric (2,2) NOT NULL CHECK (gain>0 AND gain<100)
);

ALTER TABLE Manufacturers ALTER COLUMN gain TYPE numeric (5,2);

CREATE TABLE Clients (
    id serial PRIMARY KEY,
    name varchar (50) NOT NULL,
    tel char(16) NOT NULL,
    email varchar (60),
    discount integer CHECK (discount < 5 and discount > 0)
);

CREATE TABLE Orders (
    id serial PRIMARY KEY,
    id_manufacturer integer REFERENCES Manufacturers(id) ON DELETE SET NULL ON UPDATE CASCADE,
    id_client integer REFERENCES Clients(id) ON DELETE SET NULL ON UPDATE CASCADE,
    total_sum money CHECK (total_sum>=money(0)) DEFAULT 0,
    date date DEFAULT CURRENT_DATE
);


CREATE TABLE Products_to_order (
    id serial PRIMARY KEY,
    id_order integer NOT NULL REFERENCES Orders(id) ON DELETE SET NULL ON UPDATE CASCADE,
    id_product integer NOT NULL REFERENCES Products(id) ON DELETE SET NULL ON UPDATE CASCADE,
    count integer NOT NULL DEFAULT 1
);

CREATE TABLE Products_to_manufacturers (
    id serial PRIMARY KEY,
    id_manufacturer integer NOT NULL REFERENCES Manufacturers(id) ON DELETE SET NULL ON UPDATE CASCADE,
    id_products integer NOT NULL REFERENCES Products(id) ON DELETE SET NULL ON UPDATE CASCADE,
    weight integer NOT NULL CHECK (weight>0),
    price money NOT NULL
);


INSERT INTO Products(type, name, descripton) VALUES
('pizza', 'pizza name#1', 'pizza description'),
('pizza', 'pizza name#2', 'pizza description'),
('pizza', 'pizza name#3', 'pizza description'),
('pizza', 'pizza name#4', 'pizza description'),
('pizza', 'pizza name#5', 'pizza description'),
('pizza', 'pizza name#6', 'pizza description'),
('additive', 'additive name#1', 'additive description'),
('additive', 'additive name#2', 'additive description'),
('additive', 'additive name#3', 'additive description'),
('additive', 'additive name#4', 'additive description');

INSERT INTO Manufacturers(name, gain) VALUES
('Pizzeria #1', 5.5),
('Pizzeria #2', 7),
('Pizzeria #3', 2.5),
('Pizzeria #4', 6.5);

INSERT INTO Clients(name, tel) VALUES
('client1 surname', '0991234567'),
('client2 surname', '0951230067'),
('client3 surname', '0991937465'),
('client4 surname', '0951230000'),
('client5 surname', '0990000001');

INSERT INTO Orders (id_manufacturer,id_client) VALUES
((SELECT M.id FROM Manufacturers AS M WHERE M.name = 'Pizzeria #1'), 
(SELECT C.id FROM Clients AS C WHERE C.tel = '0991937465')),
((SELECT M.id FROM Manufacturers AS M WHERE M.name = 'Pizzeria #2'), 
(SELECT C.id FROM Clients AS C WHERE C.tel = '0990000001')),
((SELECT M.id FROM Manufacturers AS M WHERE M.name = 'Pizzeria #3'), 
(SELECT C.id FROM Clients AS C WHERE C.tel = '0951230067')),
((SELECT M.id FROM Manufacturers AS M WHERE M.name = 'Pizzeria #1'), 
(SELECT C.id FROM Clients AS C WHERE C.tel = '0991937465')),
((SELECT M.id FROM Manufacturers AS M WHERE M.name = 'Pizzeria #4'), 
(SELECT C.id FROM Clients AS C WHERE C.tel = '0951230000')),
((SELECT M.id FROM Manufacturers AS M WHERE M.name = 'Pizzeria #1'), 
(SELECT C.id FROM Clients AS C WHERE C.tel = '0990000001')),
((SELECT M.id FROM Manufacturers AS M WHERE M.name = 'Pizzeria #2'), 
(SELECT C.id FROM Clients AS C WHERE C.tel = '0951230067'));

SELECT * FROM Products;

INSERT INTO Products_to_order (id_order, id_product, count) VALUES
(1, 14, 6), (1, 13, 2 ), (1, 14,2 ), (1, 15, 1 ),
(2, 11, 2),
(3, 14, 3 ), (3, 12, 4 ), (3, 14, 8 ),
(4, 13, 6), (4, 19, 2 ),
(6, 12, 3),
(7, 20, 3);

INSERT INTO Products_to_manufacturers(id_products, id_manufacturer, weight, price) VALUES
--pizza1
(11,1, 800, 300),
(11,2, 750, 250),
(11,3, 1000, 400),
(11,4, 900, 360),
--pizza2
(12,1, 500, 200),
(12,2, 550, 250),
(12,3, 600, 300),
(12,4, 700, 400),
--pizza3
(13,1, 800, 300),
(13,2, 750, 250),
(13,3, 1000, 400),
(13,4, 900, 360),
----pizza4
(14,1, 800, 300),
(14,2, 750, 250),
(14,3, 1000, 400),
(14,4, 900, 360),
--pizza5
(15,1, 800, 300),
(15,2, 750, 250),
(15,3, 1000, 400),
(15,4, 900, 360),
--pizza6
(16,1, 800, 300),
(16,2, 750, 250),
(16,3, 1000, 400),
(16,4, 900, 360),

--additive1
(17,1, 100, 60),
(17,2, 150, 85),
(17,3, 80, 50),
(17,4, 120, 75),
--additive2
(18,1, 100, 60),
(18,2, 150, 85),
(18,3, 80, 50),
(18,4, 120, 75),
--additive3
(19,1, 100, 60),
(19,2, 150, 85),
(19,3, 80, 50),
(19,4, 120, 75),
--additive4
(20,1, 100, 60),
(20,2, 150, 85),
(20,3, 80, 50),
(20,4, 120, 75);

SELECT P.name
FROM Products_to_order AS PO 
JOIN Orders AS O ON PO.id_order = O.id
JOIN Products AS P ON PO.id_product = P.id
WHERE O.id_client = 2;

SELECT C.name, P.name
FROM Orders AS O
JOIN Products_to_order AS PO ON PO.id_order = O.id
JOIN Clients AS C ON C.id= O.id_client
JOIN Products AS P ON PO.id_product = P.id
WHERE (O.id_client = 2);

--список заказов пицерии №3 за неделю
SELECT O.id
FROM Orders as O
WHERE O.date BETWEEN CURRENT_DATE - 7 AND CURRENT_DATE
AND O.id_manufacturer = 1;

SELECT * from Orders; 

ALTER TABLE Orders ADD COLUMN Hello varchar(30);

ALTER Table ORDERs ALTER COLUMN Hello SET DEFAULT 'Hello';

UPDATE Orders
SET Hello = 'default_value'
WHERE Hello IS NULL;

ALTER TABLE ORders ALTER Hello SET NOT NULL;