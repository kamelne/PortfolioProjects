
DROP TABLE IF EXISTS transaction_path;
CREATE TABLE transaction_path (
	transaction_id numeric,
	account_to numeric ,
	account_from numeric);
	
DROP TABLE IF EXISTS transaction_detail;
CREATE TABLE transaction_detail (
	transaction_id numeric,
	transaction_date date,
	value numeric ,
	cancelled varchar);	

DROP TABLE IF EXISTS account_information;
CREATE TABLE account_information (
	account_number numeric,
	account_type varchar,
	account_holder_id varchar,
	balance_date date,
	balance numeric);
	
DROP TABLE IF EXISTS account_holders;
CREATE TABLE account_holders (
	account_holder_id varchar,
	name varchar,
	date_of_birth text,
	contact_number numeric,
	address varchar);
UPDATE account_holders
SET date_of_birth = TO_DATE(date_of_birth, 'DD/MM/YYYY');
-- \copy transaction_path FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\7 - Flagging Fraudulent Suspicions\raw data\Transaction Path.csv' DELIMITER ',' CSV HEADER	
-- \copy transaction_detail FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\7 - Flagging Fraudulent Suspicions\raw data\Transaction Detail.csv' DELIMITER ',' CSV HEADER
-- \copy account_information FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\7 - Flagging Fraudulent Suspicions\raw data\Account Information.csv' DELIMITER ',' CSV HEADER
-- \copy account_holders FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\7 - Flagging Fraudulent Suspicions\raw data\Account Holders.csv' DELIMITER ',' CSV HEADER

-- Input the data
-- For the Transaction Path table:
	-- Make sure field naming convention matches the other tables
		-- i.e. instead of Account_From it should be Account From
-- For the Account Information table:
	-- Make sure there are no null values in the Account Holder ID
	-- Ensure there is one row per Account Holder ID
		-- Joint accounts will have 2 Account Holders, we want a row for each of them
-- For the Account Holders table:
	-- Make sure the phone numbers start with 07
-- Bring the tables together
-- Filter out cancelled transactions 
-- Filter to transactions greater than £1,000 in value 
-- Filter out Platinum accounts
-- Output the data
with info as (
select 
	"account_number" as account_from,
	"account_type",
	p."account_holder_id",
	"balance_date",
	"balance"
from account_information
cross join lateral string_to_table("account_holder_id", ', ')as p(account_holder_id)
where p."account_holder_id" is not null
)
-- alter TABLE account_holders
-- alter column "contact_number" type varchar
-- update account_holders set "contact_number" = '0' || "contact_number"


select 
"transaction_id",
"account_to",
"transaction_date",
"value",
"account_from",
"account_type",
"balance_date",
"balance",
"name",
"date_of_birth",
'0' || "contact_number"::varchar as contact_number,
"address" as first_line_of_address
from transaction_detail as d
inner join transaction_path using (transaction_id)
inner join info  using (account_from)
inner join account_holders using (account_holder_id)
where "cancelled" = 'N'
and "value" > 1000
and "account_type" <> 'Platinum'