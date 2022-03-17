create database Test1
 
use Test1
--Create table tblSubject
	Create table tblSubject(
		subjectCode nvarchar(10) primary key not null,
		subjectName nvarchar(30) not null, 
		slot int not null
	)
--Create table tblStudent
	Create table tblStudent (
		studentCode nvarchar(10) primary key not null, 
		studentName nvarchar(30) not null, 
		gender bit not null, 
		dob smalldatetime not null, 
		subjectCode nvarchar(10) not null
		foreign key references tblSubject(subjectCode)
	)

--INSERT INTO TABLE tblSubject

	Insert into tblSubject(subjectCode, subjectName, slot) values ('DBI202', 'Database 202', 2)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('DBI203', 'Database 203', 3)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('CSI204', 'Computer 204', 1)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('CSD201', 'Computer 201', 2)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('MAE206', 'Mathstic 206', 3)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('MKT202', 'Marketing 202',4)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('NWC203', 'Network 203c', 5)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('WED301', 'WebDesign 301',6)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('IOT202', 'Internet 202', 7)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('MAD202', 'Mathstic 202', 2)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('MAD203', 'Mathstic 203', 1)
	Insert into tblSubject(subjectCode, subjectName, slot) values ('MAD204', 'Mathstic 203', 1)

--INSERT INTO TABLE tblStudent

	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS01', N'Cao Văn Tài', 0, '2001/02/26' ,'DBI202')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS02', N'Vũ Kim Anh', 1, '2002/10/30', 'DBI203')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS03', N'Thạch Đức Bình', 0, '2001/04/04','CSI204')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS04', N'Nguyễn Đăng Giang', 0, '2001/06/07','CSD201')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS05', N'Bùi Đức Tuấn', 0, '2001/10/30','MAE206')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS06', N'Châu Khải Phong', 0, '2000/06/07','MKT202')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS07', N'Vương Hà Trang', 1, '2000/01/12','NWC203')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS08', N'Trần Hồng Ngọc', 1, '2000/07/30','WED301')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS09', N'Nguyễn Trọng Tuấn', 0, '2001/09/01','IOT202')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS10', N'Bùi Ánh Hồng', 1, '2000-03-03','MAD202')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS11', N'Bùi Ánh Hồng', 1, '2000-03-03','MAD203')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS12', N'Bùi Le', 1, '2000-03-03','MAD204')
--Xử lí dữ liệu

	SELECT * FROM tblSubject
	SELECT * FROM tblStudent

	DELETE tblSubject
	DELETE tblSubject
--Question 4: 
--A: Display information of female students before August 2000.

	Select * from tblStudent
	where gender = 1 and dob < '2000/08/01'

--B: Display the subject information that has the most students study.
	WITH A as
   (SELECT su.subjectCode,su.slot, su.subjectName, COUNT(su.subjectCode) as count1 
	FROM tblStudent st right join tblSubject su on st.subjectCode = su.subjectCode
	GROUP BY su.subjectCode, su.slot, su.subjectName )
	Select * from A
	where count1 = (select top 1 count1 from A order by count1 DESC)

--C: Show students that study the subject with the lowest slot.
    SELECT *
	FROM tblStudent st left join tblSubject su on st.subjectCode = su.subjectCode
	where su.slot = (select top 1 slot from  tblSubject order by slot )

--D: Display of student name and subject name of Student that firstname is “Le”.
	SELECT st.studentName, su.subjectName
	FROM tblStudent st left join tblSubject su on st.subjectCode = su.subjectCode
	where studentName Like '%le%'

--E: Sort the student list by subject to increasing, if overlapping then descending 
--	 by date of birth.
	
	 SELECT *
	 FROM tblStudent st left join tblSubject su on st.subjectCode = su.subjectCode
	 Order by su.subjectName asc, st.dob desc

--F: Display teacher information that most students learn.