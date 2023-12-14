-- Input the data (help)
show datestyle;
set datestyle to 'iso, dmy';

DROP TABLE IF EXISTS Week1;
CREATE TABLE Week1 (
  	"TransactionCode" text ,
  	"Value" numeric ,
  	"CustomerCode" numeric ,
  	"OnlineInPerson" smallint,
	"TransactionDate" varchar
);

-- import using psql
-- \copy Week1 FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\The Data Source Bank\raw data\PD 2023 Wk 1 Input.csv' DELIMITER ',' CSV HEADER

select * from Week1;

-- Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction (help)
-- Rename the new field with the Bank code 'Bank'. 
Select split_part("TransactionCode", '-', 1) as Bank
from Week1;

Alter Table Week1 add column Bank text;
update week1 set Bank = split_part("TransactionCode", '-', 1);

-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 
ALTER TABLE week1 
ALTER COLUMN "OnlineInPerson" TYPE VARCHAR;

update week1
	set "OnlineInPerson" =
		(case 
		when "OnlineInPerson" = '1' then 'Online'
		when "OnlineInPerson" = '2' then 'In-Person'
	end);

-- Change the date to be the day of the week (help)
Select split_part("TransactionDate", ' ', 1) as Date
from Week1;

Update Week1 
	set "TransactionDate" = split_part("TransactionDate", ' ', 1);


ALTER TABLE week1 
ALTER COLUMN "TransactionDate" TYPE Date using ("TransactionDate"::date);

Alter Table Week1 add column Date text;
update week1 set Date =  to_char("TransactionDate", 'DY');

-- Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways (help):
-- 1. Total Values of Transactions by each bank
Create Table if not exists TotalBankTransactions
as select "bank" as Bank, sum("Value") as SumOfTransactions
from week1
group by "bank"
-- \copy TotalBankTransactions to 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\The Data Source Bank\TotalBankTransactions.csv' with csv header

-- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
Create Table if not exists TotalBankDOW
as select "bank" as Bank, "date" as DayOfWeek, "OnlineInPerson" as TransactionType, sum("Value") as SumOfTransactions
from week1
group by "bank", "date", "OnlineInPerson"
Order by "bank", "OnlineInPerson"
-- \copy TotalBankDOW to 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\The Data Source Bank\TotalBankDOW.csv' with csv header

-- 3. Total Values by Bank and Customer Code
Create Table if not exists TotalBankCustCode
as select "bank" as Bank, "CustomerCode", sum("Value") as SumOfTransactions
from week1
group by "bank", "CustomerCode"
order by "CustomerCode"
-- \copy TotalBankCustCode to 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\The Data Source Bank\TotalBankCustCode.csv' with csv header

-- Output each data file (help) use psql code above


