show datestyle;
set datestyle to ISO, DMY ;
DROP TABLE IF EXISTS DSBRanking;
CREATE TABLE DSBRanking (
  	"TransactionCode" text ,
  	"Value" numeric ,
  	"CustomerCode" numeric ,
  	"OnlineInPerson" smallint,
	"TransactionDate" varchar
);
-- \copy DSBRanking FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\5 - DSB Ranking\raw data\dsb.csv' DELIMITER ',' CSV HEADER
Select * from dsbranking

-- Input data
-- Create the bank code by splitting out off the letters from the Transaction code, call this field 'Bank'
-- Change transaction date to the just be the month of the transaction
-- Total up the transaction values so you have one row for each bank and month combination
-- Rank each bank for their value of transactions each month against the other banks. 1st is the highest value of transactions, 3rd the lowest. 
-- Without losing all of the other data fields, find:
	-- The average rank a bank has across all of the months, call this field 'Avg Rank per Bank'
	-- The average transaction value per rank, call this field 'Avg Transaction Value per Rank'
-- Output the data
select 
extract('month' from "TransactionDate"::date),
to_char("TransactionDate"::date, 'Month')
from dsbranking

Alter Table dsbranking add column Bank text;
update dsbranking set Bank = split_part("TransactionCode", '-', 1);
update dsbranking set "TransactionDate" = to_char("TransactionDate"::date, 'Month')

With CTE as(
Select
	split_part("TransactionCode", '-', 1) as Bank,
	to_char("TransactionDate"::date, 'Month') as month,
	sum("Value") as total_transaction_values,
	rank() over(partition by to_char("TransactionDate"::date, 'Month') order by sum("Value") desc) as Rank
from dsbranking
group by  Bank, month
)
,avg_rank as ( 
select 
	"bank",
	round(avg("rank"), 2) as average_rank_across_all_months
from CTE
	group by "bank"
)
, AVG_RNK_VALUE as (
select 
	"rank",
	round(avg("total_transaction_values"), 2) as avg_transaction_per_rank
from CTE
group by "rank"
)
SELECT 
*
FROM CTE
Natural JOIN AVG_RANK 
Natural JOIN AVG_RNK_VALUE 
-- SELECT 
-- CTE.*,
-- average_rank_across_all_months as avg_rank_per_bank,
-- avg_transaction_per_rank as avg_transaction_value_per_rank
-- FROM CTE
-- INNER JOIN AVG_RANK as AR ON AR.bank = CTE.bank
-- INNER JOIN AVG_RNK_VALUE as AV ON AV.rnk = CTE.rnk

