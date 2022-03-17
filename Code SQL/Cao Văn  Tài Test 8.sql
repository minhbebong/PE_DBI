-- Question 1:
create database Test8
 
use Test8
--Question 2: 
--Create table tblSubject
	Create table tblSubject(
		subjectCode nvarchar(10) primary key not null,
		subjectName nvarchar(30) not null, 
		slot int not null
	)
--Create table tblTeacher
	Create table tblTeacher (
		teacherCode nvarchar(10) primary key not null, 
		teacherName nvarchar(30) not null, 
		gender bit not null, 
		address nvarchar(50) not null,
		subjectCode nvarchar(10) not null
		foreign key references tblSubject(subjectCode)
	)
--Question 3: 
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

	--INSERT INTO TABLE tblTeacher

	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS01', N'Cao Văn Tài', 0, 'NgheAn' ,'DBI202')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS02', N'Vũ Kim Anh', 1, 'Hanoi', 'DBI203')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS03', N'Thạch Đức Bình', 0, 'Haiphong','CSI204')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS04', N'Nguyễn Đăng Giang', 0, 'Hanoi','CSD201')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS05', N'Bùi Đức Tuấn', 0, 'QuangNinh','MAE206')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS06', N'Châu Khải Phong', 0, 'QuangBinh','MKT202')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS07', N'Vương Hà Trang', 1, 'DaNang','NWC203')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS08', N'Trần Hồng Ngọc', 1, 'QuyNhon','WED301')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS09', N'Nguyễn Trọng Tuấn', 0, 'CaMau','IOT202')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS10', N'Bùi Ánh Hồng', 1, 'HaNoi','MAD202')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS11', N'Bùi Ánh Hồng', 1, 'HaNoi','MAD203')
	Insert into tblTeacher(teacherCode, teacherName, gender, address, subjectCode) values ('HS12', N'Bùi Le', 1, 'HoaBinh','MAD204')

--Thao tac bảng:

	select * from tblSubject
	select * from tblTeacher

--Question 4: 
--A: Display information about male teachers living in Hanoi
	
	Select * from tblTeacher 
	where gender = 0 and address like 'HaNoi'

--B: Display teacher that teaches the subject with the lowest slot number.

