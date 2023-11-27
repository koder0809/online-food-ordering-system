
create database food_system;
use food_system;

CREATE TABLE IF NOT EXISTS customers (
  id INTEGER NOT NULL auto_increment ,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  cpassword VARCHAR(255) NOT NULL,
  confirmPassword VARCHAR(255) NOT NULL,
  createdAt DATETIME NOT NULL,
  updatedAt DATETIME NOT NULL,
  PRIMARY KEY (id)
);
select*from customers;
truncate table customers;
drop table customers;

drop table otps;
drop table resets;

CREATE TABLE IF NOT EXISTS Orders (
  id INTEGER NOT NULL auto_increment ,
  customerId INTEGER REFERENCES customers(id) ON DELETE SET NULL ON UPDATE CASCADE,
  userEmail VARCHAR(255) NOT NULL,
  orderData TEXT NOT NULL,
  orderDate DATETIME NOT NULL,
  createdAt DATETIME NOT NULL,
  updatedAt DATETIME NOT NULL,
  PRIMARY KEY (id)
) ;
select*from orders;

truncate table orders;
drop table orders;

create table FoodDetails (CategoryName varchar(30) REFERENCES FoodCategory(CategoryName),name varchar(30),img varchar(50),options varchar(80),description varchar(80));
select * from FoodDetails; 

create table FoodCategory (CategoryName varchar(30),PRIMARY KEY (CategoryName));
select * from FoodCategory;


-- Trigger
DELIMITER $$
CREATE TRIGGER check_password_length
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.cpassword) < 6 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password should be at least 6 characters long';
    END IF;
END$$;
DELIMITER ;
truncate table customers;
INSERT INTO customers (id,name, email, cpassword, confirmPassword, createdAt, updatedAt)
 VALUES (10,'Satyam', 'satyam@example.com', '123', '123', NOW(), NOW()); 

-- Stored Procedure
DELIMITER $$
CREATE PROCEDURE update_password_and_confirmation_password(
  IN customer_id INT,
  IN new_password VARCHAR(255),
  IN new_confirmation_password VARCHAR(255)
)
BEGIN
  UPDATE customers
  SET cpassword = new_password, confirmPassword = new_confirmation_password, updatedAt = NOW()
  WHERE id = customer_id;
END$$;
DELIMITER ;

CALL update_password_and_confirmation_password(2, 'satyam', 'satyam');


