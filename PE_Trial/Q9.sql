--Create a trigger InsertSubCategory which will be activated 
--by an insert statement into the  SUbCategory table. 
--The trigger will display the SubCategoryName 
--and the CategoryName of the sub-categories 
--which have just been inserted by the insert statement. 
/*For example, when we run: 
insert into SubCategory(SubCategoryName,CategoryID)
values('Beds',2)*/

create trigger trg_InsertSubCategory on SubCategory
after insert
as
begin
	select S.SubCategoryName,C.CategoryName from inserted S
	join Category C on S.CategoryID=C.CategoryID
end