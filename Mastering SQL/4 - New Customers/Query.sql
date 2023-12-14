-- Input the data
drop table if exists January;
create table January(
	"ID" numeric,
	"JoiningDay" numeric,
	"Demographic" "varchar",
	"Value" text
);
CREATE TABLE February (LIKE January INCLUDING ALL);
CREATE TABLE March (LIKE January INCLUDING ALL);
CREATE TABLE April (LIKE January INCLUDING ALL);
CREATE TABLE May (LIKE January INCLUDING ALL);
CREATE TABLE June (LIKE January INCLUDING ALL);
CREATE TABLE July (LIKE January INCLUDING ALL);
CREATE TABLE August (LIKE January INCLUDING ALL);
CREATE TABLE September (LIKE January INCLUDING ALL);
CREATE TABLE October (LIKE January INCLUDING ALL);
CREATE TABLE November (LIKE January INCLUDING ALL);
CREATE TABLE December (LIKE January INCLUDING ALL);
-- split xlxs sheets into seperate csv files using VBA then with PSQL
---- \copy December FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\4 - New Customers\raw data\split\December.csv' DELIMITER ',' CSV HEADER

-- We want to stack the tables on top of one another, since they have the same fields in each sheet. We can do this one of 2 ways (help):
-- 		Drag each table into the canvas and use a union step to stack them on top of one another
-- 		Use a wildcard union in the input step of one of the tables

-- Some of the fields aren't matching up as we'd expect, due to differences in spelling. Merge these fields together
-- Make a Joining Date field based on the Joining Day, Table Names and the year 2023
-- Now we want to reshape our data so we have a field for each demographic, for each new customer (help)
-- Make sure all the data types are correct for each field
-- Remove duplicates (help)
-- 		If a customer appears multiple times take their earliest joining date
-- Output the data
with CTE as(
select *, 'january' as TableName from january
union all
select *, 'February' as TableName from February	
union all
select *, 'March'as TableName from March
union all
select * ,'april'as TableName from april
union all
select *, 'may'as TableName from may
union all
select *, 'june'as TableName from june
union all
select *, 'july'as TableName from july
union all
select * , 'august'as TableName from august
union all
select *, 'september' as TableName from september
union all
select *, 'october'as TableName from october
union all
select *,'november' as TableName from november
union all
select *, 'december'as TableName from december
	)
-- SELECT 
-- "ID",
-- "JoiningDay",
-- "Demographic",
-- "Value",
-- make_date(2023, date_part('month', to_Date("tablename", 'month'))::int, "JoiningDay"::int ) as JoiningDate
-- from cte
SELECT DISTINCT ON ("ID")
    "ID",
    make_date(2023, date_part('month', to_Date("tablename", 'month'))::int, "JoiningDay"::int ) as JoiningDate,
    MAX(CASE WHEN "Demographic" = 'Ethnicity' THEN "Value" END) AS Ethnicity,
    MAX(CASE WHEN "Demographic" = 'Account Type' THEN "Value" END) AS AccountType,
	MAX(CASE WHEN "Demographic" = 'Date of Birth' THEN "Value"::Date END) AS DateOfBirth
FROM CTE
GROUP BY "ID", JoiningDate
ORDER BY "ID", JoiningDate;
	
	
	
	


