create database sup;
use sup;

CREATE TABLE Supplier (
    sid INT PRIMARY KEY,
    sname VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE Parts (
    pid INT PRIMARY KEY,
    pname VARCHAR(30),
    color VARCHAR(20)
);

CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost INT,
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Supplier(sid),
    FOREIGN KEY (pid) REFERENCES Parts(pid)
);

INSERT INTO Supplier VALUES
(1, 'Acme Widget Suppliers', 'Delhi'),
(2, 'Best Parts Co', 'Mumbai'),
(3, 'Universal Traders', 'Chennai');
select * from Supplier;

INSERT INTO Parts VALUES
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Green'),
(103, 'Screw', 'Red'),
(104, 'Washer', 'Blue');
select * from Parts;

INSERT INTO Catalog VALUES
(1, 101, 50),
(1, 102, 60),
(2, 101, 55),
(2, 103, 70),
(3, 101, 45),
(3, 104, 80);
insert into Catalog values
(1,103,15.00),
(1,104,17.00);
select * from Catalog;


/*pname of parts for which there is some supplier*/
SELECT DISTINCT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid;

/*sname of supplier who supply every part*/
SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM Parts p
    WHERE p.pid NOT IN (
        SELECT c.pid
        FROM Catalog c
        WHERE c.sid = s.sid
    )
);

/*SNAME OF SUPPLIER WHO SUPPLY EVERY RED PART*/
SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM Parts p
    WHERE p.color = 'Red'
      AND p.pid NOT IN (
          SELECT c.pid
          FROM Catalog c
          WHERE c.sid = s.sid
      )
);

/*pnames of parts supplied by acme widget supplier and by no one else*/
SELECT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
JOIN Supplier s ON c.sid = s.sid
WHERE s.sname = 'Acme Widget Suppliers'
  AND p.pid NOT IN (
      SELECT c2.pid
      FROM Catalog c2
      JOIN Supplier s2 ON c2.sid = s2.sid
      WHERE s2.sname <> 'Acme Widget Suppliers'
  );

/*find the sid of suppliers who charge more for some parts than average cost of that part*/
SELECT DISTINCT c.sid
FROM Catalog c
WHERE c.cost > (
    SELECT AVG(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = c.pid
);

/*for each part find the sname of supplier who charges the most for that part*/
SELECT p.pname, s.sname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
JOIN Supplier s ON s.sid = c.sid
WHERE c.cost = (
    SELECT MAX(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = p.pid
);


