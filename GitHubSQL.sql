
-- Here I am creating my first set of tables.

CREATE TABLE account(

	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
		)
	 
	CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
job_name VARCHAR(250) UNIQUE NOT NULL
	)

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP) 


-- Here I am addding in my values.

INSERT INTO account (username,password,email,created_on)
VALUES
('Luis','password','Luis@gmail.com',CURRENT_TIMESTAMP)

INSERT INTO job(job_name)
VALUES ('Chef','Military')
 
INSERT INTO account_job(user_id,job_id,hire_date)
VALUES
	(1,1,CURRENT_TIMESTAMP)


-- Here I am showing UPDATES on the tables. Which allows you to correspond columns
-- with another table to share values. This also features the RETURNING syntax,
--which acts similar to a SELECT statement.

UPDATE account
SET last_login = created_on


UPDATE JOIN
UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id

UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email,last_login, created_on

INSERT INTO job(job_name)
VALUES 
('Bank Teller')


-- Using DELETE to simply delete a row.
DELETE FROM job
WHERE job_name = 'Bank Teller'
RETURNING job_id,job_name

CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR (500) NOT NULL,
	person VARCHAR (50) NOT NULL UNIQUE
)

-- The ALTER function is used to change data type or rename a table or coloun.
ALTER TABLE information
RENAME to new_info

ALTER TABLE new_info
RENAME COLUMN person TO people


ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL 


INSERT INTO new_info(title)
VALUES
('some new title')
 
CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	birthdate DATE CHECK (birthdate > '1900-01-01'),
	hire_date DATE CHECK (hire_date > birthdate),
	salary INTEGER CHECK (salary > 0)
)

INSERT INTO employees(
first_name,
	last_name,
	birthdate,
	hire_date,
	salary
)
VALUES
('luis',
'ballesteros',
'1997-07-22',
'2010-01-01',
100) 



-- Here I am selecting data from another dataset using the WHEN and ELSE syntax.
-- These two function as a filter that then creates a coloumn. Aliases are often found 
-- at the end of the function.

SELECT customer_id,
CASE 
	WHEN (customer_id <= 100) THEN 'premium'
	WHEN (customer_id BETWEEN 100 AND 200) THEN 'plus'
	ELSE 'normal'
END AS customer_class
FROM customer

SELECT customer_id,
CASE customer_id 
	WHEN 2 THEN 'winner'
	WHEN 5 THEN 'sec place'
	ELSE 'normal'
END AS raffle_results
FROM customer


--Here I am using aggregate functions, which work to those similar to excel formulas.
--CASE is used to IF and THEN statements, that stop once the first condition is met.
SELECT  
SUM(CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END	) AS bargain,
SUM(CASE rental_rate
 WHEN 2.99 THEN 1
  ELSE 0
END) AS regular,
SUM(CASE rental_rate
  WHEN 4.99 THEN 1
  ELSE 0
END) AS premium
FROM film


SELECT
SUM(CASE rating
	WHEN 'R' THEN 1
	ELSE 0
END) AS r,
SUM(CASE rating
   WHEN 'PG' THEN 1 
   ELSE 0
END) AS pg,
SUM(CASE rating
   WHEN 'PG-13' THEN 1 
   ELSE 0
END) AS pg13

FROM film

SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR))
FROM rental


INSERT INTO  depts(
first_name,  
department  
)
VALUES
('Luis', 'A'),
('Alexxus', 'A'),
('Micah','B')

SELECT (
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END)/
NULLIF(SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END),0)

) AS deptratio
FROM depts

--Here I am using the VIEW function that creates temporary tables, so you dont
--have to keep querying the same data, or wrangle the data base itself. 
-- Also using an INNER JOIN which joins common data from another table.

CREATE VIEW customer_info AS
SELECT first_name, last_name, address 
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

-- THIS code using multiple data types depending on the input.
CREATE TABLE students(
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR (50), 
	lastname VARCHAR (50),
	homeroom INTEGER NOT NULL,
	phone VARCHAR(10) UNIQUE,
	email VARCHAR(25) UNIQUE		  
 			
CREATE TABLE teachers(
teacher_id SERIAL PRIMARY KEY,
first_name VARCHAR (50),
last_name VARCHAR (50),
homeroom INTEGER UNIQUE,
department VARCHAR(20),
email VARCHAR (25) UNIQUE,
phone VARCHAR (25) UNIQUE
)


INSERT INTO teachers(first_name,last_name,homeroom, 
department,email,phone
)
VALUES
('Jonas','Stark','5','biology','jsalk@school.org','777-555-4321')

INSERT INTO students(first_name,lastname,homeroom,phone)
VALUES ('Mark','Watney','5','777-555-1234' )



