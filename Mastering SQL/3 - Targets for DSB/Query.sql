-- Input the data
DROP TABLE IF EXISTS transactions3;
CREATE TABLE transactions3 (
  	"TransactionCode" text ,
  	"Value" numeric ,
  	"CustomerCode" numeric ,
  	"OnlineInPerson" smallint,
	"TransactionDate" varchar
);
Drop table if exists targets;
Create table targets(
	"OnlineInPerson" varchar,	
	"Q1" numeric,	
	"Q2"	numeric,
	"Q3"	numeric,
	"Q4" numeric
)
-- \copy transactions3 FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\Targets for DSB\raw data\PD 2023 Wk 1 Input.csv' DELIMITER ',' CSV HEADER
-- \copy targets FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\Targets for DSB\raw data\targets.csv' DELIMITER ',' CSV HEADER
select * from transactions3;
select * from targets;

-- For the transactions file:
-- 		Filter the transactions to just look at DSB 
-- 			These will be transactions that contain DSB in the Transaction Code field
-- 		Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
-- 		Change the date to be the quarter 
-- 		Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) 

select * from transactions3
where "TransactionCode" ~* '^DSB';

ALTER TABLE transactions3 
ALTER COLUMN "OnlineInPerson" TYPE VARCHAR;
update transactions3
	set "OnlineInPerson" =
		(case 
		when "OnlineInPerson" = '1' then 'Online'
		when "OnlineInPerson" = '2' then 'In-Person'
	end);
	
show datestyle;
set datestyle to 'iso, dmy'; --refresh server
ALTER TABLE transactions3 
ALTER COLUMN "TransactionDate" TYPE timestamp using ("TransactionDate"::date);
SELECT * ,EXTRACT (QUARTER FROM "TransactionDate") from transactions3

Alter Table transactions3 add column "Quarter" numeric;
update transactions3 set "Quarter" = EXTRACT (QUARTER FROM "TransactionDate");

-- hold new information in new wtable
drop table if exists CleanedTransactions;
create table CleanedTransactions(
	Quarter numeric,
	OnlineInPerson varchar,  
	Value numeric
);
Insert into CleanedTransactions
Select "Quarter", "OnlineInPerson", sum("Value") as VALUE
from transactions3
where "TransactionCode" ~* '^DSB'
group by 1,2

Select * from CleanedTransactions

-- For the targets file:
-- 		Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter 
--  		Rename the fields
-- 		Remove the 'Q' from the quarter field and make the data type numeric
select 
"OnlineInPerson",
unnest(array['1', '2', '3', '4'])::numeric AS Quarter,
unnest(array["Q1", "Q2", "Q3", "Q4"]) AS Target
from targets 
-- Create table to hold transposed table
drop table if exists TranposeTarget;
create table TranposeTarget(
	OnlineInPerson varchar, 
	Quarter numeric, 
	Target numeric
);

Insert into TranposeTarget
select "OnlineInPerson",
		unnest(array['1', '2', '3', '4'])::numeric AS Quarter,
		unnest(array["Q1", "Q2", "Q3", "Q4"]) AS Target
from targets 

Select * from TranposeTarget


-- Join the two datasets together 
-- 		You may need more than one join clause!
-- Remove unnecessary fields
-- Calculate the Variance to Target for each row 
-- Output the data  v."value" - s."target" as Variance
-- CleanedTransaction and TransposeTarget

Select 
cln."onlineinperson",
cln."quarter",
cln."value",
tra."target",
cln."value" - tra."target" as variance
from CleanedTransactions cln
join TranposeTarget tra
on cln."onlineinperson" = tra."onlineinperson" and cln."quarter" = tra."quarter"
order by 1,2


