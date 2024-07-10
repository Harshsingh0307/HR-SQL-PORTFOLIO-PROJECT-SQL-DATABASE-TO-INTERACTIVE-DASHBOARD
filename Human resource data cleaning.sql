SELECT * FROM human_resource.`human resource`;


-- DATA CLEANING _---

-- 1 Changing the column name .

Alter table human_resource.`human resource`
change column 
ï»¿id emp_id varchar(20)  null;

-- 2 Check the datatype for the table
Describe human_resource.`human resource`;

select birthdate from human_resource.`human resource`;

Set Sql_safe_updates = 0;

-- 3 Change the birthdate format to date .
UPDATE human_resource.`human resource`
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- 4 modifying the column of birthdate to date format .

alter table human_resource.`human resource`
Modify column birthdate date;


-- 5 Change the hire_date format to date format .

UPDATE human_resource.`human resource`
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

alter table human_resource.`human resource`
Modify column hire_date date ;

-- 6 Change the termdate format to date format .

UPDATE human_resource.`human resource`
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SET sql_mode = 'ALLOW_INVALID_DATES';	

Select termdate from human_resource.`human resource` ; 

alter table human_resource.`human resource`
Modify column termdate date;

-- 7 adding a new column age 

 alter table human_resource.`human resource` add column age INT;

-- 8 updating the column age .

   update human_resource.`human resource`
   set age = timestampdiff(Year,Birthdate , Curdate());
   
   Select birthdate,age from human_resource.`human resource`;
   
   -- 9 checking the min and max age from the column
   Select 
   min(age) as youngest,
   max(age) as oldest
   from human_resource.`human resource`;
   
   Select count(*) from human_resource.`human resource`	
   where age<18;