-- Requirements
-- Input the data
DROP TABLE IF EXISTS Transactions;
CREATE TABLE Transactions (
	"TransactionID" varchar	,
	"AccountNumber" numeric	,
	"SortCode" varchar	,
	"Bank" varchar
);

DROP TABLE IF EXISTS SwiftCodes;
CREATE TABLE SwiftCodes (
	"Bank" varchar,
	"SWIFTcode" varchar,
	"CheckDigits" varchar
);

-- Import data using PSQL code below
-- \copy Transactions FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\Week 2 - International Bank Account Numbers\raw data\Transactions.csv' DELIMITER ',' CSV HEADER
-- \copy SwiftCodes FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\Week 2 - International Bank Account Numbers\raw data\Swift Codes.csv' DELIMITER ',' CSV HEADER
select * from transactions
select * from swiftcodes

-- In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string 
update transactions
	set "SortCode" = replace("SortCode",'-', '');

-- Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account
DROP TABLE IF EXISTS JoinedBankInfo;
create table JoinedBankInfo as
Select transactions."TransactionID", transactions."AccountNumber", transactions."SortCode", transactions."Bank", swiftcodes."CheckDigits", swiftcodes."SWIFTcode" 
from transactions inner join swiftcodes on swiftcodes."Bank" = transactions."Bank";

select * from JoinedBankInfo

-- Add a field for the Country Code, all these transactions take place in the UK so the Country Code should be GB
alter TABLE joinedbankinfo
add column "CountryCode" varchar;

Update joinedbankinfo
set "CountryCode" = 'GB';

-- Create the IBAN (CountryCode, CheckDigit, SwiftCode, SortCode, AccountNumber) , watch out for trying to combine sting fields with numeric fields - check data types
alter TABLE joinedbankinfo
add column "IBAN" varchar;

Update joinedbankinfo
set "IBAN" = concat("CountryCode","CheckDigits" , "SWIFTcode" , "SortCode" ,"AccountNumber");

-- Remove unnecessary fields 
Alter TABLE joinedbankinfo
drop COLUMN "AccountNumber",
drop COLUMN	"SortCode",
drop column "Bank",
drop column "CheckDigits",
drop column "SWIFTcode",
Drop COLUMN "CountryCode";
-- Output the data

-- \copy joinedbankinfo to 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\Week 2 - International Bank Account Numbers\IBAN.csv' with csv header
