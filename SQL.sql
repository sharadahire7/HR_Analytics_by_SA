use hr_analytics;

Select * from hr_1;

Select * from hr_2;

-- KPI-1 : Average Attrition Rate for all Departments

Select Department, Round((Avg(Case When Attrition = 'Yes' Then 1 else 0 End) * 100), 2) as Average_Attrition_Rate
from hr_1
Group By Department;

-- KPI-2 : Average Hourly Rate for Male Research Scientist

Select JobRole, Gender, Avg(HourlyRate) as Average_Hourly_Rate
from hr_1
Where Gender = 'Male' and JobRole = 'Research Scientist';

-- KPI-3 : Attrition Rate Vs Montly Income Stats

Select
	Case
		when MonthlyIncome >=1000 and MonthlyIncome <11000 then '1-10K'
        when MonthlyIncome >=11000 and MonthlyIncome <21000 then '11-20K'
        when MonthlyIncome >=21000 and MonthlyIncome <31000 then '21-30K'
        when MonthlyIncome >=31000 and MonthlyIncome <41000 then '31-40K'
        else 'Above 40K'
        end as Salary_Range,
        Round((Avg(Case When Attrition = 'Yes' Then 1 else 0 End) * 100), 2) as Average_Attrition_Rate
        from hr_1 join hr_2 on hr_1.EmployeeNumber = hr_2.EmployeeID
        Group By Salary_Range;
        
-- KPI-3 Alternative

Select Department, Round(Avg(MonthlyIncome), 0) as Average_Monthly_Income, 
Round((Avg(Case When Attrition = 'Yes' Then 1 else 0 End) * 100), 2) as Average_Attrition_Rate
from hr_1 join hr_2 on hr_1.EmployeeNumber = hr_2.EmployeeID
Group By Department;

-- KPI-4 : Average working year for each department

Select Department, Round(Avg(TotalWorkingYears),2) as Average_Working_Years
from hr_1 join hr_2 on hr_1.EmployeeNumber = hr_2.EmployeeID
Group By Department;

-- KPi-5 : Job role Vs Work life balance

Select JobRole,
				Case
					when WorkLifeBalance = 1 then 'Poor'
                    when WorkLifeBalance = 2 then 'Average'
                    when WorkLifeBalance = 3 then 'Good'
                    when WorkLifeBalance = 4 then 'Excellent'
                    else 'Not Defined'
                    end as Work_Life_Balance, Count(WorkLifeBalance) as Number_of_Employee
from hr_1 join hr_2 on hr_1.EmployeeNumber = hr_2.EmployeeID
Group By JobRole
Order by WorkLifeBalance desc;


-- KPI-6 : Attrition Rate Vs Year Since Last Promotion relation

Select 
		Case
			when YearsSinceLastPromotion >=1 and YearsSinceLastPromotion <6 then '1-5 yrs'
            when YearsSinceLastPromotion >=6 and YearsSinceLastPromotion <11 then '6-10 yrs'
            when YearsSinceLastPromotion >=11 and YearsSinceLastPromotion <16 then '11-15 yrs'
            when YearsSinceLastPromotion >=16 and YearsSinceLastPromotion <21 then '16-20 yrs'
            when YearsSinceLastPromotion >=21 and YearsSinceLastPromotion <26 then '21-25 yrs'
            when YearsSinceLastPromotion >=26 and YearsSinceLastPromotion <31 then '26-30 yrs'
            when YearsSinceLastPromotion >=31 and YearsSinceLastPromotion <36 then '31-35 yrs'
            when YearsSinceLastPromotion >=36 and YearsSinceLastPromotion <41 then '36-40 yrs'
            else 'Above 40 yrs'
            end as Years_Since_Last_Promotion,
Round((Avg(Case When Attrition = 'Yes' Then 1 else 0 End) * 100), 2) as Average_Attrition_Rate
from hr_1 join hr_2 on hr_1.EmployeeNumber = hr_2.EmployeeID
Group By Years_Since_Last_Promotion;


                    
