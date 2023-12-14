-- Input the data
-- Reshape the data so we have 5 rows for each customer, with responses for the Mobile App and Online Interface being in separate fields on the same row
-- Clean the question categories so they don't have the platform in from of them
	-- e.g. Mobile App - Ease of Use should be simply Ease of Use
-- Exclude the Overall Ratings, these were incorrectly calculated by the system
-- Calculate the Average Ratings for each platform for each customer 
-- Calculate the difference in Average Rating between Mobile App and Online Interface for each customer
-- Catergorise customers as being:
	-- Mobile App Superfans if the difference is greater than or equal to 2 in the Mobile App's favour
	-- Mobile App Fans if difference >= 1
	-- Online Interface Fan
	-- Online Interface Superfan
	-- Neutral if difference is between 0 and 1
-- Calculate the Percent of Total customers in each category, rounded to 1 decimal place
-- Output the data
Drop table if exists DSB_Ratings;
CREATE Table  DSB_Ratings(
	Customer_ID numeric,
	Mobile_App_Ease_Use numeric,
	Mobile_App_Ease_Access	 numeric,
	Mobile_App_Navigation	numeric,
	Mobile_App_Likelihood_Recommend numeric,
	Mobile_App_Overall_Rating	numeric,
	Online_Interface_Ease_Use	numeric,
	Online_Interface_Ease_Access	numeric,
	Online_Interface_Navigation	numeric,
	Online_Interface_Likelihood_Recommend	numeric,
	Online_Interface_Overall_Rating numeric
);

-- \copy DSB_Ratings FROM 'C:\Users\nizar\OneDrive\PortfolioProjects\Mastering SQL\6 - DSB Customer Ratings\raw data\DSB Customer Survery.csv' DELIMITER ',' CSV HEADER
select * from dsb_ratings;

with CTE as(
select c."customer_id", t.*
from dsb_ratings c
  cross join lateral (
	  values
	  ('Ease_of_Use', c."mobile_app_ease_use", c."online_interface_ease_use" ),
	  ('Ease_of_Access',c."mobile_app_ease_access", c."online_interface_ease_access" ),
	  ('Navigation',c."mobile_app_navigation" ,c."online_interface_navigation"),
	  ('Likelihood_to_Recommend',c."mobile_app_likelihood_recommend" ,c."online_interface_likelihood_recommend")
-- 	  ,('Overall_Rating',c."mobile_app_overall_rating" ,c."online_interface_overall_rating")
	  )as t(factor, mobile_app, online_interface)
order by customer_id, factor
	)
, avgs as (
	select
	"customer_id",
	avg("mobile_app") as avg_mobile,
	avg("online_interface") as avg_online,
	avg("mobile_app") - avg("online_interface") as diff,
	case
	when avg("mobile_app") - avg("online_interface") >= 2 then 'Mobile App SuperFans'
	when avg("mobile_app") - avg("online_interface") >= 1 then 'Mobile App Fans'
	when avg("mobile_app") - avg("online_interface") <= -2 then 'Online Interface Superfan'
	when avg("mobile_app") - avg("online_interface") <= -1 then 'Online Interface Fan'
	else  'Neutral'
	end as Fan_category
	from cte
	group by "customer_id"
)

select
"fan_category" as preference,
round((COUNT("customer_id")::numeric / (SELECT COUNT("customer_id")::numeric FROM avgs))*100,1) as percent_of_customers
from avgs
group by "fan_category"


