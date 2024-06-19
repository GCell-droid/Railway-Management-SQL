create database railway_system;

use railway_system;
CREATE TABLE passenger (
  passenger_ID int 	PRIMARY KEY NOT NULL,
  first_name varchar(100) NOT NULL,
  middle_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  pincode int NOT NULL,
  city varchar(100) NOT NULL,
  state varchar(100) NOT NULL,
  dob date NOT NULL,
  gender varchar(10) NOT NULL,
  age int NOT NULL
);
INSERT INTO passenger (passenger_ID, first_name, middle_name, last_name, pincode, city, state, dob, gender, age) VALUES
(1222, 'Raj', 'Siddharth', 'Nimbalkar', 890097, 'Mumbai', 'Maharashtra', '2001-08-11', 'Male', 23),
(1234, 'Nitesh', 'Adam', 'Parihar', 365250, 'Indore', 'MP', '2000-04-14', 'Male', 21);
select * from passenger;

CREATE TABLE train (
  train_no int	PRIMARY KEY NOT NULL,
  train_name varchar(50) DEFAULT NULL,
  train_source varchar(50) DEFAULT NULL,
  train_destination varchar(50) DEFAULT NULL,
  arrival_time datetime DEFAULT NULL,
  departure_time datetime DEFAULT NULL,
  seats_available int DEFAULT NULL,
  reference_date date DEFAULT NULL
);
INSERT INTO train (train_no, train_name, train_source, train_destination, arrival_time, departure_time, seats_available, reference_date) VALUES
(1122, 'Shatabdi-Express', 'Jaipur', 'Delhi', '2022-04-21 23:15:48', '2022-04-22 07:15:48', 250, NULL);
CREATE TABLE ticket (
  pnr_no int PRIMARY KEY NOT NULL,
  train_no int DEFAULT NULL,
  passenger_ID int DEFAULT NULL,
  FOREIGN KEY(train_no)references train(train_no),
  FOREIGN KEY(passenger_ID)references passenger(passenger_ID)
);
INSERT INTO ticket (pnr_no, train_no, passenger_ID) VALUES
 (1457, 1122, 1234);

CREATE TABLE payment (
  transaction_ID int PRIMARY KEY NOT NULL,
  passenger_ID int DEFAULT NULL,
  pnr_no int DEFAULT NULL,
  amount int DEFAULT NULL,
  FOREIGN KEY(passenger_id)references passenger(passenger_ID),
  FOREIGN KEY(pnr_no)references ticket(pnr_no)
);

CREATE TABLE traveller (
  passenger_ID int DEFAULT NULL,
  train_source varchar(50) DEFAULT NULL,
  train_destination varchar(50) DEFAULT NULL,
  passenger_bookingDate date DEFAULT NULL,
  train_no int DEFAULT NULL,
  FOREIGN KEY(passenger_ID)references passenger(passenger_ID),
  FOREIGN KEY(train_no)references train(train_no)
);
INSERT INTO traveller (passenger_ID, train_source, train_destination, passenger_bookingDate, train_no) VALUES
(1222, 'Jaipur', 'Delhi', '2022-04-22', NULL);
create table user_tables(
	username varchar(50) NOT NULL,
    password varchar(50) NOT NULL
);
INSERT INTO user_tables(username, password) VALUES ('sid','sid'),
('nitesh','nitesh');
DELIMITER /
CREATE TRIGGER update_seats_available
AFTER INSERT ON ticket
FOR EACH ROW
BEGIN
    UPDATE train
    SET seats_available = seats_available - 1
    WHERE train_no = NEW.train_no;
END /
DELIMITER ;
DELIMITER /
CREATE TRIGGER update_seats_cancelled
AFTER DELETE ON ticket
FOR EACH ROW
BEGIN
    UPDATE train
    SET seats_available = seats_available + 1
    WHERE train_no = OLD.train_no;
END /
DELIMITER ;

START TRANSACTION;
INSERT INTO ticket (pnr_no, train_no, passenger_ID) VALUES
(pnr_no, train_no, passenger_ID);
INSERT INTO payment (transaction_ID, passenger_ID, pnr_no, amount) VALUES
(transaction_ID, passenger_ID, pnr_no, amount);
COMMIT;

CREATE VIEW booked_tickets_view AS
SELECT 
    t.pnr_no,
    p.passenger_ID,
    p.first_name,
    p.middle_name,
    p.last_name,
    p.gender,
    p.age,
    tr.train_no,
    tr.train_name,
    tr.train_source,
    tr.train_destination,
    tr.arrival_time,
    tr.departure_time
FROM 
    ticket t
JOIN 
    passenger p ON t.passenger_ID = p.passenger_ID
JOIN 
    train tr ON t.train_no = tr.train_no;


CREATE TABLE train_schedule_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    train_no INT,
    old_arrival_time DATETIME,
    new_arrival_time DATETIME,
    old_departure_time DATETIME,
    new_departure_time DATETIME,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




INSERT INTO passenger (passenger_ID, first_name, middle_name, last_name, pincode, city, state, dob, gender, age) VALUES
(5111, 'Sid', 'Siddharth', 'Nimbalkar', 890097, 'Mumbai', 'Maharashtra', '2001-08-12', 'Male', 23),
(1333, 'Nitesh', 'Adam', 'Parihar', 365250, 'Indore', 'MP', '2000-04-14', 'Male', 21);

INSERT INTO train (train_no, train_name, train_source, train_destination, arrival_time, departure_time, seats_available, reference_date) VALUES
(1112, ' Rajdhani-Express', 'MUMBAI', 'Delhi', '2022-04-21 23:15:48', '2022-04-22 07:15:48', 250, NULL);


select * from payment;
select * from train;
select * from ticket;


-- Create the railwayadmin role
CREATE ROLE 'railwayadmin';

-- Show privileges (to verify the available privileges)
SHOW PRIVILEGES;

-- Grant all privileges on the railway_system database to the railwayadmin role
GRANT ALL PRIVILEGES ON railway_system.* TO 'railwayadmin';

-- Create a user 'admin' with password 'admin123.' and assign the default role 'railwayadmin'
CREATE USER 'admin' IDENTIFIED BY 'admin123.' DEFAULT ROLE 'railwayadmin';

-- Show grants for the user 'niteshhh'@'%'
SHOW GRANTS FOR 'admin'@'%';
