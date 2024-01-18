/*созд табл users - id, name, surname, isMale, age, tel, email
NOT NULL - name, surname, email
2 tasks id name description cate created date ddl, salary  +  userID
*/

CREATE TABLE Users (
    id serial UNIQUE PRIMARY KEY,
    name varchar(100) NOT NULL,
    surname varchar(100) NOT NULL,
    isMale boolean,
    age integer check(age>0),
    tel char(15),
    email varchar(100) UNIQUE NOT NULL check(email LIKE '_@_')
);

ALTER TABLE Users DROP CONSTRAINT users_email_check;
ALTER TABLE Users ADD CONSTRAINT users_email_check CHECK (email LIKE '%@%');

CREATE TABLE Tasks (
    id serial UNIQUE PRIMARY KEY,
    name varchar(100) NOT NULL,
    description text,
    created date DEFAULT CURRENT_Date,
    deadline date NOT NULL check (deadline>created),
    salary money NOT NULL check(salary>money(0)),
    userID integer REFERENCES Users(id)
);

ALTER table tasks ALTER COLUMN created SET DEFAULT now();

INSERT INTO Users (name, surname, isMale, age, email) VALUES 
('Name2', 'Surname2', true, 25, 'vs1@com'),
('Name3', 'Surname3', false, 28, 'vs2@com'),
('Name4', 'Surname4', false, 26, 'vs3@com'),
('Name5', 'Surname5', true, 32, 'vs4@com'),
('Name6', 'Surname6', true, 44, 'vs5@com'),
('Name7', 'Surname7', false, 35, 'vs6@com'),
('Name8', 'Surname8', true, 22, 'vs7@com');

SELECT * FROM Users;

INSERT INTO Tasks (name, deadline, salary, userID) VALUES 
('TS1', '2024-06-03', 1000, 11),
('TS2', '2024-06-13', 1200, 9),
('TS3', '2024-06-11', 1400, 4), 
('TS4', '2024-06-23', 1600, 7),
('TS5', '2024-07-03', 1100, 10),
('TS6', '2024-08-12', 1900, 7),
('TS7', '2024-07-23', 2000, 5),
('TS8', '2024-07-16', 2100, 10),
('TS9', '2024-07-01', 1600, 7),
('TS10', '2024-07-30', 1500, 11);

SELECT * FROM tasks;

SELECT name, surname FROM Users LIMIT 5;

SELECT * 
FROM Tasks 
ORDER BY deadline;

SELECT Tasks.name, Tasks.deadline, Users.name, Users.Surname
FROM Users, Tasks
WHERE Tasks.name = 'TS1' AND Users.id = tasks.userID;

SELECT concat(users.name, ' ', users.surname) as fullname, tasks.name as task, tasks.deadline
FROM Users, Tasks
WHERE tasks.userID = users.id and users.name= 'Name4';

SELECT *
FROM Users
WHERE Users.age > 25;

SELECT *
FROM Users
WHERE Users.isMale = TRUE;

SELECT Users.name, Users.surname, Users.email, Tasks.name, Tasks.deadline
FROM Users, Tasks
WHERE Users.isMale = FALSE AND Tasks.userID = Users.id;

UPDATE Users 
SET email = 'tyu@com'
WHERE Users.id=4;

delete from users
where users.id = 5;

SELECT Tasks.name, Tasks.deadline, Users.email
FROM Tasks, Users
WHERE (Tasks.deadline BETWEEN '2024-06-23' AND '2024-07-15') AND Tasks.userID = Users.id;


UPDATE Tasks
SET deadline = deadline + 7
WHERE Tasks.deadline BETWEEN '2024-07-23' AND '2024-08-15';

SELECT *
FROM Tasks;

UPDATE Tasks
SET salary = salary * 1.2
WHERE name = 'TS5';

SELECT *
FROM Tasks
WHERE name='TS5';


CREATE TABLE groups (
    id serial PRIMARY KEY,
    name varchar(50) UNIQUE NOT NULL
);

CREATE TABLE roles (
    id serial PRIMARY KEY,
    name varchar (50) NOT NULL,
    description varchar (150),
    idGroup integer REFERENCES groups(id) on delete set null on update cascade
);

CREATE TABLE users1 (
    id serial PRIMARY KEY,
    email varchar(60) UNIQUE NOT NULL,
    login varchar(60) UNIQUE NOT NULL,
    passwordHash text NOT NULL,
    fullName varchar (150) NOT NULL,
    idRole integer NOT NULL REFERENCES roles(id) on delete set null on update cascade
);

INSERT INTO groups (name) VALUES 
('users_dev'), ('users_home'), ('users_main'), ('moderator'), ('super');

INSERT INTO roles (name, idGroup) VALUES
('starter', 1), ('begginer', 1), ('middle', 1), ('senior', 1), ('unknown', 1),
('guest', 1), ('moderator_db', 2), ('moderator_net', 2), ('moderator_pro', 2),
('admin_db', 3), ('admin_pro', 3);

INSERT INTO users1 (email, login, passwordHash, fullName, idRole) VALUES 
('u1@com', 'u1', 'pas1', 'user1', 10 ),
('u2@com', 'u2', 'pas2', 'user2', 3),
('u3@com', 'u3', 'pas3', 'user3', 2 ),
('u4@com', 'u4', 'pas4', 'user4', 7 ),
('u5@com', 'u5', 'pas5', 'user5', 5 ),
('u6@com', 'u6', 'pas6', 'user6', 4 ),
('u7@com', 'u7', 'pas7', 'user7', 2 ),
('u8@com', 'u8', 'pas8', 'user8', 8 ),
('u9@com', 'u9', 'pas9', 'user9', 3 ),
('u10@com', 'u10', 'pas10', 'user10', 6 ),
('u11@com', 'u11', 'pas11', 'user11', 11 ),
('u12@com', 'u12', 'pas12', 'user12', 7 );

SELECT * FROM users1;

SELECT groups.name AS "Group", roles.name AS "ROLE"
FROM roles, groups 
WHERE groups.name = 'users_dev' AND roles.idGroup =  groups.id;

SELECT users1.fullName, roles.name
FROM users1, roles
WHERE roles.name = 'begginer' AND users1.idRole = roles.id;

SELECT users1.fullName, roles.name as "Role", groups.name as "Group"
FROM users1, groups, roles
WHERE users1.idRole = roles.id and groups.id = roles.idGroup and groups.name = 'users_dev';

SELECT users1.fullName, groups.name
FROM users1, groups, roles
WHERE groups.id = roles.idGroup and roles.id = users1.idRole 
ORDER BY groups.name LIMIT 15;

CREATE DATABASE practice2;