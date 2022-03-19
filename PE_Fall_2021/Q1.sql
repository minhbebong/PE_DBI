
create table Roles (
	RoleID int primary key,
	name  nvarchar(100),
)
create table Users(
	Username nvarchar (30) primary key,
	Email nvarchar(200),
	Password nvarchar(20),
	RoleID int references Roles(RoleID)
)


create table Permissions(
	permissionID int primary key,
	name nvarchar(50),
)

create table hasPermission(
	RoleID int references Roles(RoleID),
	PermissionID int references Permissions(PermissionID),
	primary key (RoleID,PermissionID)
)

--Đe khac 
-- question 1
create table categories(
catID int PRIMARY KEY,
name nvarchar(255)
)
create table items(
itemID int PRIMARY KEY,
name nvarchar(255),
price float
)
create table itemVariants(
itemID int,
variantID int,
detail nvarchar(200),
color nvarchar(50),
size nvarchar(30)
constraint fk_itemVariants_items foreign key(itemID)
references items(itemID)
)
create table belongTo(
itemID int,
catID int,
constraint fk_belongTo_items foreign key(itemID)
references items(itemID),
constraint fk_belongTo_categories foreign key(catID)
references categories(catID),
primary key(itemID,catID)
)