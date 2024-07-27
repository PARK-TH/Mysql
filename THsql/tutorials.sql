use practice;

GRANT ALL PRIVILEGES ON database_name.* TO username@localhost;
FLUSH PRIVILEGES;

CREATE DATABASE PRACTICE;

use practice;

CREATE TABLE table1 (
	id int primary key not null,
	name varchar(20) not null,
    number int not null
);

show tables;

desc table1;
select*from table1;

INSERT INTO table1 (id, name, number) VALUES
(1, 'Alice', 12345),
(2, '  Bob  ', 67890),
(3, 'CHARLIE', 13579),
(4, 'david', 24680),
(5, ' Eve ', 11223);

select*from table1;

UPDATE table1 SET name = 'John' WHERE id = 1;

select*from table1;

CREATE TABLE table2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    table1_id INT,
    description TEXT,
    CONSTRAINT fk_table1
        FOREIGN KEY (table1_id) 
        REFERENCES table1(id)
        ON DELETE CASCADE
);

INSERT INTO table2 (table1_id, description) VALUES
(1, 'Description 1'),
(2, 'Description 2'),
(3, 'Description 3'),
(4, 'Description 4'),
(5, 'Description 5');


