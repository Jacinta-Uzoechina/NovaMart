-- Create the Database for NovaMart 
CREATE DATABASE novamart_analytics;

-- Create the Schemas
CREATE SCHEMA core;

CREATE SCHEMA sales;

-- Create the Tables

CREATE TABLE core.customers(
	customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email_address VARCHAR (100) UNIQUE NOT NULL,
	phone_number VARCHAR (15) UNIQUE,
	address VARCHAR (250),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE core.stores(
	store_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	store_name VARCHAR (100) NOT NULL UNIQUE,
	store_manager VARCHAR (100),
	store_location VARCHAR (250) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE core.products(
	product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	product_name VARCHAR (250) NOT NULL UNIQUE,
	product_category VARCHAR(50) NOT NULL,
	product_cost NUMERIC (10,2) NOT NULL,
    product_price NUMERIC(10,2) NOT NULL CHECK (product_price > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.orders(
	order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	customer_id INT NOT NULL,
	store_id INT NOT NULL,
	discount NUMERIC(5,2) NOT NULL DEFAULT 0 CHECK (discount BETWEEN 0 AND 100),
    total_amount NUMERIC(12,2) NOT NULL CHECK (total_amount > 0),
	order_date DATE DEFAULT CURRENT_DATE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

-- Set these constaints to link to the table with the primary keys
	CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES core.customers(customer_id),

    CONSTRAINT fk_store
        FOREIGN KEY (store_id)
        REFERENCES core.stores(store_id)
);

CREATE TABLE sales.order_details(
	order_detail_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	price NUMERIC(10,2) NOT NULL CHECK (price > 0),
	product_quantity INT NOT NULL CHECK (product_quantity > 0),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

-- Set these constaints to link to the table with the primary keys
	CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES sales.orders(order_id),

	CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES core.products(product_id)
);

-- Insert Values into the Tables
INSERT INTO core.customers(first_name, last_name, email_address, phone_number, address)
	VALUES ('Ade', 'Sama', 'adesama@gmail.com', '07011111111', '2, Adelabu Street, Lagos'),
           ('Janet', 'Coker', 'janetcoker@gmail.com', '07011111112', '2, Lekki Street, Lagos'),
           ('John', 'Ade', 'johnade@gmail.com', '07011111113', '2, Micheal Street, Oyo'),
           ('Carol', 'Eze', 'caroleze@gmail.com', '07011111114', '2, Ewetu Street, Delta'),
           ('Amina', 'Mustapha', 'aminamustapha@gmail.com', '07011111115', '2, Gari Street, Kano');

INSERT INTO core.stores(store_name, store_manager, store_location)
	VALUES ('NovaMart Ibadan', 'Tolu Seyi', '2, Lekki street, Lagos'),
           ('NovaMart Lekki', 'Segun Loke', '2, Ibadan street, Oyo'),
           ('NovaMart Kano', 'Musa Mohamed', '2, Singa street, Kano');	

INSERT INTO core.products(product_name, product_category, product_cost, product_price)
	VALUES ('Fruit Juice', 'Drinks', 2000.00, 3500.00),
	 	   ('Granola', 'Food', 5000.00, 10000.00),
           ('Rice', 'Food', 5000.00, 8000.00),
           ('Air Freshner', 'Household', 400.00, 1000.00),
           ('Laptop Charger', 'Hardware', 20000.00, 45000.00),
	   	   ('Pasta', 'Food', 380.00, 1000.00),
       	   ('Cookies', 'Snack', 370.00, 1000.00),
     	   ('Standing Fan', 'Household', 35000.00, 95000.00);

INSERT INTO sales.orders (customer_id, store_id, discount, total_amount)
	VALUES (2, 1, 0, 45000.00),
		   (3, 2, 5, 10000.00),
		   (4, 2, 10, 21500.00),
		   (5, 3, 5, 6000.00),
		   (1, 3, 20, 95000.00),
		   (2, 2, 10, 16000.00),
		   (3, 1, 10, 13500.00),
		   (4, 3, 10, 8000.00),
		   (5, 1, 10, 7000.00);

INSERT INTO sales.order_details (order_id, product_id, price, product_quantity)	
	VALUES (1, 4, 45000.00, 1),
		   (2, 2, 10000.00, 1),
		   (3, 2, 10000.00, 1),
		   (3, 1, 3500.00, 1),
		   (3, 3, 8000.00, 1),
		   (4, 6, 1000.00, 3),
		   (4, 7, 1000.00, 3),
		   (5, 8, 95000.00, 1),
		   (6, 8, 8000.00, 2),
		   (7, 3, 3500.00, 1),
		   (7, 3, 10000.00, 1),
		   (8, 1, 8000.00, 1),
		   (9, 2, 3500.00, 2);
