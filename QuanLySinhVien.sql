use test2_csdl_2207;

create table Subjects(
SubjectID int(4) primary key,
SubjectName nvarchar(50)
);

create table Students(
StudentID int(4) primary key,
StudentName nvarchar(50),
Age int(4),
Email nvarchar(100)
);

create table Classes(
ClassID int(4) primary key,
ClassName nvarchar(50)
);

create table ClassStudent(
ClassStudentID int(4) primary key,
C_StudentID int(4),
C_ClassID int(4),
foreign key (C_StudentID) references Students(StudentID),
foreign key (C_ClassID) references Classes(ClassID)
);

create table Marks(
Mark int(4) primary key,
M_SubjectID int(4),
M_StudentID int(4),
foreign key (M_SubjectID) references Subjects(SubjectID),
foreign key (M_StudentID) references Students(StudentID)
);



/*1 Hien thi danh sach tat ca cac hoc vien */
select *
from Students;

/*2 Hien thi danh sach tat ca cac mon hoc*/
select *
from Subjects;

/*3 Tinh diem trung binh*/
select  avg(Mark)
from Marks
group by Mark;

/*4 Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat */
select StudentName,Mark
from Students
join Marks on Students.StudentID=Marks.M_StudentID
order by Mark desc
limit 1;

/*5 Danh so thu tu cua diem theo chieu giam*/
select row_number() OVER  (order by Mark) as 'so thu tu', Mark 
from Marks;

 
/*6 Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)*/
alter TABLE Subjects
change column `SubjectName` `SubjectName` NVARCHAR(4000);

/*7 Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects*/
update Subjects set SubjectName = ' Day la mon hoc SQL' where (SubjectID = '1');
update Subjects set SubjectName = ' Day la mon hoc Jave' where (SubjectID = '2');
update Subjects set SubjectName = ' Day la mon hoc C' where (SubjectID = '3');
update Subjects set SubjectName = ' Day la mon hoc Visual Basic' where (SubjectID = '4');


/*8 Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50*/
alter TABLE Students
add Check (Age >15 and Age<50);

/*Loai bo tat ca quan he giua cac bang*/
alter TABLE ClassStudent
drop foreign key ClassStudent_ibfk_2,
drop foreign key ClassStudent_ibfk_1;

alter TABLE Marks
drop foreign key Marks_ibfk_2,
drop foreign key Marks_ibfk_1;


/*10 Xoa hoc vien co StudentID la 1*/
delete StudentName
from Students
where StudentID='1';

/*11 Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1*/
alter TABLE Students
add column Status1 Bit default 1;

/*12 Cap nhap gia tri Status trong bang Student thanh 0*/
update Students set status = 0 where StudentID = 1;
update Students set status = 0 where StudentID = 2;
update Students set status = 0 where StudentID = 3;
update Students set status = 0 where StudentID = 4;
update Students set status = 0 where StudentID = 5;