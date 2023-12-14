-- Input each of the 12 monthly files
drop table if exists mock_data;
create table mock_data(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
ALTER TABLE mock_data ADD COLUMN file_date NUMERIC DEFAULT 1;
--\copy mock_data(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA.csv' DELIMITER ',' CSV HEADER 
select * from mock_data

drop table if exists mock_data_2;
create table mock_data_2(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_2(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-2.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_2 ADD COLUMN file_date NUMERIC DEFAULT 2;


drop table if exists mock_data_3;
create table mock_data_3(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_3(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-3.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_3 ADD COLUMN file_date NUMERIC DEFAULT 3;

drop table if exists mock_data_4;
create table mock_data_4(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_4(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-4.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_4 ADD COLUMN file_date NUMERIC DEFAULT 4;

drop table if exists mock_data_5;
create table mock_data_5(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_5(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-5.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_5 ADD COLUMN file_date NUMERIC DEFAULT 5;

drop table if exists mock_data_6;
create table mock_data_6(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_6(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-6.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_6 ADD COLUMN file_date NUMERIC DEFAULT 6;

drop table if exists mock_data_7;
create table mock_data_7(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_7(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-7.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_7 ADD COLUMN file_date NUMERIC DEFAULT 7;

drop table if exists mock_data_8;
create table mock_data_8(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_8(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-8.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_8 ADD COLUMN file_date NUMERIC DEFAULT 8;

drop table if exists mock_data_9;
create table mock_data_9(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_9(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-9.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_9 ADD COLUMN file_date NUMERIC DEFAULT 9;

drop table if exists mock_data_10;
create table mock_data_10(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_10(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-10.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_10 ADD COLUMN file_date NUMERIC DEFAULT 10;

drop table if exists mock_data_11;
create table mock_data_11(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_11(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-11.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_11 ADD COLUMN file_date NUMERIC DEFAULT 11;

drop table if exists mock_data_12;
create table mock_data_12(
id	NUMERIC,
first_name varchar ,
last_name varchar,
Ticker varchar,
Sector varchar,
Market varchar,
Stock_Name varchar,
Market_Cap text,
Purchase_Price text);
--\copy mock_data_12(id,first_name,last_name,Ticker,Sector,Market,Stock_Name,Market_Cap,Purchase_Price) FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\8 - Taking Stock\raw_data\MOCK_DATA-12.csv' DELIMITER ',' CSV HEADER
ALTER TABLE mock_data_12 ADD COLUMN file_date NUMERIC DEFAULT 12;

-- Create a 'file date' using the month found in the file name
	-- The Null value should be replaced as 1
		--created columns filled with date corresponding with month manually,  
-- Clean the Market Cap value to ensure it is the true value as 'Market Capitalisation'
	-- Remove any rows with 'n/a'
-- Categorise the Purchase Price into groupings
	-- 0 to 24,999.99 as 'Low'
	-- 25,000 to 49,999.99 as 'Medium'
	-- 50,000 to 74,999.99 as 'High'
	-- 75,000 to 100,000 as 'Very High'
-- Categorise the Market Cap into groupings
	-- Below $100M as 'Small'
	-- Between $100M and below $1B as 'Medium'
	-- Between $1B and below $100B as 'Large' 
	-- $100B and above as 'Huge'
-- Rank the highest 5 purchases per combination of: file date, Purchase Price Categorisation and Market Capitalisation Categorisation.
-- Output only records with a rank of 1 to 5


with CTE as(
select * from mock_data
union all
select * from mock_data_2
union all
select * from mock_data_3
union all
select * from mock_data_4
union all
select * from mock_data_5
union all
select * from mock_data_6
union all
select * from mock_data_7
union all
select * from mock_data_8
union all
select * from mock_data_9
union all
select * from mock_data_10
union all
select * from mock_data_11
union all
select * from mock_data_12
),
n as (select  
	"market_cap",
	"purchase_price", 
    CASE
        WHEN "market_cap" = 'n/a' THEN NULL
        WHEN "market_cap" ~ '\$[0-9]+(\.[0-9]+)?[MmBb]?$' THEN
            CASE
                WHEN "market_cap" ~ 'M$' THEN
                    CAST(REGEXP_REPLACE("market_cap", '\$|M', '', 'g') AS numeric) * 1000000
                WHEN "market_cap" ~ 'B$' THEN
                    CAST(REGEXP_REPLACE("market_cap", '\$|B', '', 'g') AS numeric) * 1000000000
                ELSE
                    CAST(REGEXP_REPLACE("market_cap", '\$', '', 'g') AS numeric)
            END
        ELSE NULL
    END AS Market_Cap_$,
	replace("purchase_price", '$', '')::numeric as purchase_price_$
from CTE
)
,g as(
select 
	"market_cap_$",
	"purchase_price_$",
	case
		when Market_cap_$ < 100000000 then 'Small'
		when Market_Cap_$ < 1000000000 then 'Medium'
		when Market_Cap_$  < 100000000000 then 'Large'
		when Market_Cap_$ >= 100000000000 then 'Huge'
	else NULL
	End as Market_Cap_Group,
	Case
		when purchase_price_$ < 25000 then 'Low'
		when purchase_price_$ < 50000 then 'Medium'
		when purchase_price_$  < 75000 then 'High'
		when purchase_price_$ <= 100000 then 'Very High'
	else NULL
	End as Purchase_Price_Group
from n
where "market_cap_$" is not null
)
, ranked as (
SELECT 
    cte."file_date" as file_month,
    cte."ticker",
    cte."sector",
    cte."market",
    cte."stock_name",
    g."market_cap_$",
    g."market_cap_group",
    g."purchase_price_$",
    g."purchase_price_group",
	DENSE_RANK() OVER (PARTITION BY cte."file_date"::numeric, g."market_cap_group", g."purchase_price_group" ORDER BY n."purchase_price" DESC, cte."stock_name" ASC, g."purchase_price_$" desc) AS  overall_rank
FROM g
JOIN n on n."market_cap_$" = g."market_cap_$"
join cte on  cte."market_cap" = n."market_cap"
where g."market_cap_$" is not Null)

SELECT * 
FROM ranked
WHERE overall_rank <= 5
ORDER BY file_month, market_cap_group, purchase_price_group, overall_rank;


