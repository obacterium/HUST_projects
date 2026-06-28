-- 电影表
CREATE TABLE movie (
movie_ID INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100) NOT NULL,
type VARCHAR(50),
runtime INT,
release_date DATE,
director VARCHAR(50),
starring VARCHAR(100)
) ENGINE=InnoDB;
-- 顾客表
CREATE TABLE customer (
c_ID INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
phone VARCHAR(20)
) ENGINE=InnoDB;
-- 放映厅表
CREATE TABLE hall (
hall_ID INT AUTO_INCREMENT PRIMARY KEY,
mode VARCHAR(50),
capacity INT,
location VARCHAR(100)
) ENGINE=InnoDB;
-- 排场表
CREATE TABLE schedule (
schedule_ID INT AUTO_INCREMENT PRIMARY KEY,
date DATE NOT NULL,
time TIME NOT NULL,
price DECIMAL(10,2),
number INT,
movie_ID INT,
hall_ID INT,
FOREIGN KEY (movie_ID) REFERENCES movie(movie_ID),
FOREIGN KEY (hall_ID) REFERENCES hall(hall_ID)
) ENGINE=InnoDB;
-- 电影票表
CREATE TABLE ticket (
ticket_ID INT AUTO_INCREMENT PRIMARY KEY,
seat_num VARCHAR(10),
schedule_ID INT,
customer_ID INT,
FOREIGN KEY (schedule_ID) REFERENCES schedule(schedule_ID),
FOREIGN KEY (customer_ID) REFERENCES customer(c_ID)
) ENGINE=InnoDB;