create table Teachers(
	TeacherID int primary key,
	Name nvarchar(50),
	Address nvarchar(200),
	Gender char(1)
)

create table Students(
	StudentID int primary key,
	Name nvarchar(50),
	Address nvarchar(200),
	Gender char(1)
)

create table Classes (
	ClassID int primary key,
	GroupID char(6),
	CourseID char(6),
	NoCredits int,
	Semester char(10),
	Year int,
	TeacherID int references Teachers(TeacherID)
)

create table Attend(
	StudentID int references Students(StudentID),
	ClassID int references Classes(ClassID),
	Attend bit,
	Date date,
	Slot int,
	primary key (StudentID, ClassID, Date, Slot)
)