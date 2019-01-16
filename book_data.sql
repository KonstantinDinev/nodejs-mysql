-- CREATE TABLE books 
--     (
--         book_id INT NOT NULL AUTO_INCREMENT,
--         title VARCHAR(100),
--         author_fname VARCHAR(100),
--         author_lname VARCHAR(100),
--         released_year INT,
--         stock_quantity INT,
--         pages INT,
--         PRIMARY KEY(book_id)
--     );
 
-- INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)S
-- VALUES
-- ('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
-- ('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
-- ('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
-- ('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
-- ('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
-- ('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
-- ('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
-- ('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
-- ('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
-- ('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
-- ('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
-- ("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
-- ('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
-- ('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
-- ('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
-- ('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT
    SUBSTRING(REPLACE(title, 'e', '3'), 1, 10)
FROM books;


INSERT INTO people (name, birthdate, birthtime, birthdt) 
VALUES('Method', CURDATE(), CURTIME(), NOW());

SELECT name, birthdate, DAYNAME(birthdate) FROM people;
-- mysql-ctl cli;


SELECT * FROM customers WHERE last_name='George';
SELECT * FROM orders WHERE customer_id = 1;


SELECT * FROM orders WHERE customer_id =
    (
        SELECT id FROM customers
        WHERE last_name='George'
    );
    

-- Cross Joins
SELECT first_name, last_name, order_date, amount FROM customers, orders WHERE customers.id = orders.customer_id; 

-- Implicit Inner Join
SELECT first_name, last_name, order_date, amount
FROM customers, orders
    WHERE customers.id = orders.customer_id;

-- Explicit inner join
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders
    ON customers.id = orders.customer_id;
    
-- Arbitrary Join -- bad thing

SELECT * FROM customers
JOIN orders ON customers.id = orders.id;

-- LEFT Join
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
ORDER BY order_date;

SELECT 
    first_name, 
    last_name, 
    order_date, 
    SUM(amount) AS total_spent
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- Implied LEFT JOIN
SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;
    
    
SELECT 
    first_name, 
    last_name, 
    order_date, 
    IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;


-- RIGHT JOIN
SELECT * FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;
    
-- If there are orders without customer
SELECT 
    IFNULL(first_name, 'MISSING') AS First, 
    IFNULL(last_name, 'USER') AS Last, 
    order_date, 
    SUM(amount)
FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customer_id;

-- ON DELETE CASCADE
-- DROP TABLES customers, orders;
-- INSERT from schema.sql file

-- DELETE FROM customers WHERE email = 'george@gmail.com';
SELECT 
    IFNULL(first_name,'MISSING') AS first, 
    IFNULL(last_name,'USER') as last, 
    order_date, 
    amount, 
    SUM(amount)
FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY first_name, last_name;