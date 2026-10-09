create database library;
use library;



create table books(c int primary key,
bookName varchar(30) not null,
authorname varchar(30));


create table members(rollno int primary key,
name varchar(30),
departent varchar(30));


create table issue(IssueID int primary key,
 bookID int,
 MemberID int,
 IssueDate date ,ReturnDate date,
 foreign key(bookID) references books(bookId),
 foreign key(MemberID) references members(rollno));
 
--  inserting into books
insert into books values(1,"DBMS","Korth")
insert into members values(1,"Rahul","CSE");
insert into issue values(1,1,1,"2026-10-01",NULL);
-- If you already ran your 3 single inserts, clear them first:
-- delete from issue; delete from members; delete from books;

insert into books values
(2,'Java Complete','Herbert Schildt'),
(3,'Python Basics','Mark Lutz'),
(4,'Operating Systems','Galvin'),
(5,'Computer Networks','Tanenbaum'),
(6,'Data Structures','Tenenbaum'),
(7,'C Programming','Kernighan'),
(8,'Algorithms','Cormen'),
(9,'Software Engineering','Pressman'),
(10,'Artificial Intelligence','Russell');

insert into members values
(2,'Anjali','ECE'),
(3,'Sneha','IT'),
(4,'Kiran','CSE'),
(5,'Priya','ECE'),
(6,'Arjun','IT'),
(7,'Meena','CSE'),
(8,'Vikram','MECH'),
(9,'Divya','IT'),
(10,'Suresh','CIVIL');

insert into issue values
(2,2,2,'2026-08-10','2026-08-20'),
(3,1,3,'2026-08-15',NULL),
(4,3,1,'2026-09-01',NULL),
(5,1,4,'2026-09-05','2026-09-15'),
(6,4,5,'2026-09-10',NULL),
(7,2,1,'2026-09-12','2026-09-22'),
(8,5,6,'2026-09-28',NULL),
(9,1,7,'2026-09-30','2026-10-05'),
(10,3,1,'2026-10-03',NULL);

-- ● Find overdue books. 
select Date_sub(now(),interval 7 day);
 select b.* from issue i join books b 
 on i.bookId=b.bookId where 
 ReturnDate is NULL and 
 IssueDate< Date_sub(now(),interval 7 day) ;
 -- Find books never issued. 
 select b.* from issue i right join books b 
 on i.bookId=b.bookId where IssueId is NULL ;
 select * from books where bookId 
 not in (select bookId from issue);
 -- Find member who borrowed maximum books
 select * from members where rollno=(select MemberID   
 from issue group by MemberId  having count(*)=( select max(cnt) from (select MemberID ,count(*) as 
 cnt  from issue group by MemberId) t));
-- Find most popular book. 
select * from issue;
select * from books where bookId=(select bookID  
 from issue group by bookId  having count(*)=( select max(cnt)
 from (select bookID ,count(*) as 
 cnt  from issue group by bookID) t));
 -- Count available books. 
 select count(*) from (select bookId from issue where ReturnDate is not null
 union
 select bookId from books where bookId not in (select bookId from issue)) t;
 