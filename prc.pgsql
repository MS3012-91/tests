CREATE TABLE cources (
    id serial PRIMARY KEY,
    title varchar (50) NOT NULL UNIQUE,
    description text,
    hours numeric(1) NOT NULL
);

ALTER table cources alter COLUMN hours type integer;

CREATE TABLE students (
    id serial PRIMARY KEY,
    name varchar (50) NOT NULL,
    surname varchar(50) NOT NULL
);

CREATE TABLE exams (
    id_stud integer REFERENCES students(id) ON DELETE SET NULL ON UPDATE CASCADE,
    id_cource integer REFERENCES cources(id) ON DELETE SET NULL ON UPDATE CASCADE,
    mark integer NOT NULL CHECK (mark>0)
);

INSERT INTO cources (title, hours) VALUES
('cource1',40),
('cource2',20),
('cource3',60),
('cource4',65);


INSERT INTO students (name, surname) VALUES
('name1', 'surname1'),
('name2', 'surname2'),
('name3', 'surname3'),
('name4', 'surname4'),
('name5', 'surname5'),
('name6', 'surname6'),
('name7', 'surname7'),
('name8', 'surname8'),
('name9', 'surname9');

INSERT INTO exams VALUES 
(1, 2, 5), (1, 1, 4), (1, 3, 3), (1, 2, 4), 
(2, 2, 2), (1, 1, 5), (1, 3, 5), (1, 2, 3), 
(3, 2, 4), (1, 1, 3), (1, 3, 4), (1, 2, 3), 
(4, 2, 4), (1, 1, 2), (1, 3, 5), (1, 2, 5), 
(5, 2, 4), (1, 1, 3), (1, 3, 4), (1, 2, 3), 
(6, 2, 3), (1, 1, 3), (1, 3, 4), (1, 2, 4), 
(7, 2, 4), (1, 1, 4), (1, 3, 3), (1, 2, 4), 
(8, 2, 5), (1, 1, 4), (1, 3, 5), (1, 2, 3), 
(9, 2, 4), (1, 1, 5), (1, 3, 4), (1, 2, 5);

SELECT * FROM STUDENTS;

SELECT * FROM COURCES;

SELECT S.name, S.surname, C.title 
FROM STUDENTS as S
JOIN exams as E ON S.id =  e.id_stud
JOIN cources as C ON C.id = e.id_cource
WHERE e.id_cource = 1;

SELECT C.title, count(S.id) as "Students count"
FROM STUDENTS as S
JOIN exams as E ON S.id =  e.id_stud
JOIN cources as C ON C.id = e.id_cource
GROUP BY C.title;

SELECT S.name, S.surname, C.title
FROM STUDENTS as S
LEFT JOIN exams as E ON S.id =  e.id_stud
Right JOIN cources as C ON C.id = e.id_cource
WHERE S.id = 1
GROUP BY S.name, S.surname, C.title;

SELECT C.title, C.hours
FROM Cources as C
WHERE C.hours>40;

SELECT S.name, S.surname, avg(e.mark)::integer as "Average mark"
FROM Students as S 
JOIN exams as E on S.id = E.id_stud
WHERE s.id= 4
GROUP BY S.name, S.surname;

SELECT S.name, S.surname, C.title, max(E.mark) as "Max mark"
FROM students as S 
JOIN Exams as E on S.id = E.id_stud
JOIN Cources AS C on c.id = E.id_cource
GROUP BY S.name, S.surname, C.title;

SELECT S.name, S.surname, C.title, min(E.mark) as "Min mark"
FROM students as S 
JOIN Exams as E on S.id = E.id_stud
JOIN Cources AS C on c.id = E.id_cource
GROUP BY S.name, S.surname, C.title;

SELECT C.title, round(avg(e.mark), 2) 
FROM cources as C 
JOIN exams AS E ON C.id = E.id_cource
GROUP BY C.title;

SELECT concat(S.name, ' ' , S.surname) AS "Fullname", C.title, max(E.mark) as "Max mark"
FROM cources as C
JOIN Exams as E ON E.id_cource = C.id
LEFT OUTER JOIN students as S ON E.id_stud = max(E.mark)
Where E.id_stud = S.id
GROUP BY C.title, "Fullname";

create DATABASE prct;