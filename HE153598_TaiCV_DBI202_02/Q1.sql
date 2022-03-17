
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
