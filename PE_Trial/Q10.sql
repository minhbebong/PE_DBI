-- Cau 10
-- Insert category named 'Sports' into Category table
-- Insert subcategories 'Tennis' and 'Football' into Subcategory table, ca 2 deu
-- thuoc category 'Sports'
insert into Category(CategoryName)
values ('Sports')

insert into SubCategory(SubCategoryName, CategoryID)
values ('Tennis',(select ID from Category where CategoryName = 'Sports')),
('Football',(select ID from Category where CategoryName = 'Sports'))

 
/* select * from Category

select * from SubCategory */ --> test xong thi xoa di