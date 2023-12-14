-- DROP TABLE IF EXISTS CarData;
-- CREATE TABLE CarData (
--   	"Brand" text ,
--   	"Model" text ,
--   	"Generation" text ,
--   	"Modification (Engine)" text,
-- 	"Start of production" text ,
-- 	"Powertrain Architecture" text ,
-- 	"Body type" text ,
-- 	"Seats" smallint ,
-- 	"Doors" smallint,
-- 	"Fuel Type" varchar,
-- 	"Acceleration 0 - 100 km/h (s)" text,
-- 	"Maximum speed (km/hr)"numeric,
-- 	"Emission standard" varchar,
-- 	"Weight-to-power ratio (kg/hp)" numeric,
-- 	"Weight-to-torque ratio (kg/Nm)" numeric,
-- 	"Battery Voltage (V)" varchar,
-- 	"Battery location" varchar,
-- 	"Electric motor power (hp)" smallint,
-- 	"Combustion Power (hp)" smallint,
-- 	"Power per litre (hp/l)" numeric,
-- 	"Combustion Torque (Nm)" smallint,
-- 	"Engine displacement (cm3)" smallint,
-- 	"Number of cylinders" smallint,
-- 	"Engine aspiration" varchar,
-- 	"Kerb Weight (kg)" numeric,
-- 	"Drag coefficient (Cd)" numeric,
-- 	"Drive wheel" varchar,
-- 	"Battery technology" varchar,
-- 	"Electric motor location" varchar,
-- 	"Electric motor Torque (Nm)" smallint,
-- 	"Gross battery capacity (kWh)" numeric,
-- 	"Max speed (electric) (km/hr)" numeric,
-- 	"Recuperation output (kW)" smallint,
-- 	"Total power (hp)" smallint,
-- 	"Total torque (Nm)"	smallint,
-- 	"CO2 Emissions (g/km)" numeric,
-- 	"Fuel Consumption (l/100 km)" numeric,
-- 	"All-electric range (km)" numeric
-- );

 select * from cardata;
 
-- Additional data cleaning
-- Acceleration 0-100km/h(s) - has at least one number with 2 decimal point, imported as text need to convert to numeric
-- Max speed(km/hr) and Max speed (electric) number is wrong, looks like only first 3 digit are the correct number
-- Fuel Consumption set deciaml length to 2


-- only one number with to decimals point it is 7.47.6
SELECT "Acceleration 0 - 100 km/h (s)", count("Acceleration 0 - 100 km/h (s)") AS CountOf
FROM cardata
GROUP BY "Acceleration 0 - 100 km/h (s)" order by Countof;

select *
from cardata
where "Acceleration 0 - 100 km/h (s)" like '%.%%.%';

-- Select only upto first digit after first '.' 
select SUBSTRING("Acceleration 0 - 100 km/h (s)", 1, strpos("Acceleration 0 - 100 km/h (s)", '.')+1) as test
from cardata;

UPDATE cardata
   SET "Acceleration 0 - 100 km/h (s)" = SUBSTRING("Acceleration 0 - 100 km/h (s)", 1, strpos("Acceleration 0 - 100 km/h (s)", '.')+1);
 
 
--  Update datatype of column"Acceleration 0 - 100 km/h (s)"
alter table cardata
alter column "Acceleration 0 - 100 km/h (s)" type numeric
USING "Acceleration 0 - 100 km/h (s)"::numeric;

select * from cardata

alter table cardata
alter column "Max speed (electric) (km/hr)" type text
USING "Max speed (electric) (km/hr)"::text;

UPDATE cardata
   SET "Max speed (electric) (km/hr)" = SUBSTRING("Max speed (electric) (km/hr)", 1, 3);
   
alter table cardata
alter column "Max speed (electric) (km/hr)" type smallint
USING "Max speed (electric) (km/hr)"::smallint;


alter table cardata
alter column "Maximum speed (km/hr)" type text
USING "Maximum speed (km/hr)"::text;

UPDATE cardata
   SET "Maximum speed (km/hr)" = SUBSTRING("Maximum speed (km/hr)", 1, 3);
   
alter table cardata
alter column "Maximum speed (km/hr)" type smallint
USING "Maximum speed (km/hr)"::smallint;

alter table cardata
alter column "Fuel Consumption (l/100 km)" type numeric(4,1)

-- Clean start of production to just year and set date datetype
update cardata
 set "Start of production" = trim(regexp_replace("Start of production", '[[:alpha:]\s(,)]*', ''));
 
update cardata
 set "Start of production" =to_date("Start of production"::text,'YYYY');
 
alter table cardata
alter column "Start of production" type date
USING "Start of production"::date;
