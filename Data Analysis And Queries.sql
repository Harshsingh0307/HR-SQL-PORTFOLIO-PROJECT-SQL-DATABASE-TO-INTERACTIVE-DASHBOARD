

-- 1. What is the gender breakdown of employees in the company?

Select gender, count(*)as 'Count of Employees' from human_resource.`human resource`
where age>= 18 and termdate = '0000-00-00'
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT 
    race, COUNT(*) AS 'Count of Employees'
FROM
    human_resource.`human resource`
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY COUNT(*) DESC;

-- 3. What is the age distribution of employees in the company?

Select 
min(age) as youngest,
max(age) as oldest 
from human_resource.`human resource`
 where age>= 18 and termdate = '0000-00-00' ;	
 
 Select 
 case 
 when age>=18 and age<=24 then '18-24'
 when age>=25 and age<=34 then '25-34'
 when age>=35 and age<=44 then '35-44'
 when age>=45 and age<=54 then '45-54'
 when age>=55 and age<=64 then '55-64'
 else '65+'
 End as Age_group,Gender,
 count(*) as count
 from human_resource.`human resource`
 WHERE
    age >= 18 AND termdate = '0000-00-00'
    group by Age_group, gender
    order by age_group,gender;
    
    -- 4. How many employees work at headquarters versus remote locations?
Select location,count(*) as Count
from human_resource.`human resource`
WHERE age >= 18 AND termdate = '0000-00-00'
group by location;


-- 5. What is the average length of employment for employees who have been terminated?

SELECT 
    ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365,
            0) AS Avg_length_Employement
FROM
    human_resource.`human resource`
WHERE
    termdate <= CURDATE() AND age >= 18
        AND termdate != '0000-00-00';
    
    -- 6. How does the gender distribution vary across departments and job titles?
    Select department, gender , count(*) as count
    from human_resource.`human resource`
    WHERE
    age >= 18 AND termdate = '0000-00-00'
    group by department,gender
    order by department;
    
    
    -- 7. What is the distribution of job titles across the company?
    Select jobtitle,count(*) as count from human_resource.`human resource`
     WHERE
    age >= 18 AND termdate = '0000-00-00'
    group by jobtitle
    order by jobtitle
    desc;
    
    -- 8. Which department has the highest turnover rate?
    SELECT 
    Department,
    total_count,
    terminated_count,
    terminated_count / total_count AS termination_rate
FROM
    (SELECT 
        department,
            COUNT(*) AS total_count,
            SUM(CASE
                WHEN
                    termdate != '0000-00-00'
                        AND termdate <= CURDATE()
                THEN
                    1
                ELSE 0
            END) AS terminated_count
    FROM
        human_resource.`human resource`
    WHERE
        age >= 18
    GROUP BY department) AS Subquery
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?
      Select location_city,location_state,count(*) as count
      from human_resource.`human resource`
      WHERE
    age >= 18 AND termdate = '0000-00-00'
    group by location_city,location_state
    order by location_city,location_state, count ;
     
	-- 10. How has the company's employee count changed over time based on hire and term dates?
        
        Select
        year,
        hires,
        terminations,
        hires - terminations as Net_change,
        Round((hires-terminations)/hires*100,2) as Net_change_percent
        from 
        (Select year (hire_date) as year,
        count(*) as hires,
	 sum( case when termdate !='0000-00-00' and termdate<= curdate() then 1 else 0 end) as terminations
  from human_resource.`human resource`
     where age >=18	
     group by year (hire_date)
     ) as subquery
     order by year
     asc;
		
	set Sql_safe_updates=0;
    
        
   -- 11. What is the tenure distribution for each department?
   
   Select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
   from human_resource.`human resource`
   where termdate <= curdate() and termdate != '0000-00-00' and age >=18
    Group by department ;        
    
    
    