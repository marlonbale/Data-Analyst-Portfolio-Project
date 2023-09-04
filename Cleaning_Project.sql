# Data Cleaning Project

use portofolio_projects;

-- 1. change the names of the columns

ALTER TABLE coffee_data
CHANGE COLUMN `Farm.Name` Farm VARCHAR(100);

ALTER TABLE coffee_data
CHANGE COLUMN `Number.of.Bags` Number_of_bags VARCHAR(100);

ALTER TABLE coffee_data
CHANGE COLUMN `Grading.Date` Grading_date VARCHAR(100);

ALTER TABLE coffee_data
CHANGE COLUMN `Bag.Weight` Bag_weight VARCHAR(100);

ALTER TABLE coffee_data
CHANGE COLUMN `In.Country.Partner` In_Country_Partner VARCHAR(100);

ALTER TABLE coffee_data
CHANGE COLUMN `Harvest.Year` Harvest_Year VARCHAR(100);

ALTER TABLE coffee_data
CHANGE COLUMN `Country.of.Origin` Origin_Country VARCHAR(100);

ALTER TABLE coffee_data
CHANGE COLUMN `MyUnknownColumn` ID Integer(100);

ALTER TABLE coffee_data
CHANGE COLUMN `Clean.cup` Clean_Cup Varchar(100);


ALTER TABLE coffee_data
DROP COLUMN `Region`;




-- 2. finding null values
select * from coffee_data;

-- finding the cells where Farm is Null iy has empty values.
SELECT *
FROM coffee_data
WHERE Farm IS NULL OR Farm = '';

-- updating the coulumn Farm in the table with 'unknown'
SET SQL_SAFE_UPDATES = 0; -- unable safety edit

SELECT *
FROM coffee_data
WHERE Farm IS NULL OR Farm = '';

update coffee_data
SET Farm = 'unknown'
WHERE Farm IS NULL OR Farm = '';

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM coffee_data
WHERE Company IS NULL OR Company = '';

SET SQL_SAFE_UPDATES = 0;
-- replacing and updating null values in column 'Company' with 'unknown'

UPDATE coffee_data
SET Company = 'unknown'
WHERE Company IS NULL OR Company = '';

-- replacing and updating null values in column 'region' with 'unknown'

update coffee_data
SET Region = 'unknown'
where Region IS NULL OR REGION = '';

SELECT *
FROM coffee_data
WHERE Producer IS NULL OR Producer = '';  -- checking if it is null or an empty string

update coffee_data
SET Producer = 'unknown'
WHERE Producer IS NULL OR Producer = '';

update coffee_data
SET `Processing.Method` = 'unknown'  -- HAVE TO USE BACK TICKS IF THE COLUMN NAME CONTAINS A DOT
WHERE `Processing.Method` IS NULL OR `Processing.Method` = '';

select * from coffee_data;

update coffee_data
SET Producer = 'unknown'
WHERE Producer IS NULL OR Producer = '';

update coffee_data
SET Color = 'unknown'
WHERE Color IS NULL OR Color = '';

update coffee_data
SET Variety = '-'
WHERE Variety IS NULL OR Variety = '';


-- 3. Capitalizing the first letter of each coloumn with a string ;

SELECT UPPER(LEFT(Region, 1)) AS first_letter
FROM coffee_data;

UPDATE coffee_data
set In_Country_Partner = CONCAT(UPPER(SUBSTRING(In_Country_Partner,1,1)),SUBSTRING(In_Country_Partner,2))
where In_Country_Partner IS NOT NULL;

select * from coffee_data;


UPDATE coffee_data
set Farm = CONCAT(UCASE(SUBSTRING(FARM,1,1)),LOWER(substring(Farm,2)))
where FARM IS NOT NULL;

UPDATE coffee_data
set PRODUCER = CONCAT(UCASE(SUBSTRING(PRODUCER,1,1)),LOWER(substring(PRODUCER,2)))
where PRODUCER IS NOT NULL;

UPDATE coffee_data
set Company = CONCAT(UCASE(SUBSTRING(Company,1,1)),LOWER(substring(Company,2)))
where PRODUCER IS NOT NULL;


-- 4. Standardizing date format

select Grading_date,
	DATE_FORMAT(STR_TO_DATE(Grading_date, '%M %D, %Y'), '%Y-%m-%d') AS standardized_date
from coffee_data 
WHERE Grading_date IS NOT NULL; 

Update coffee_data
SET Grading_date = 	Date_Format(STR_TO_DATE(Grading_date,'%M %D,%Y'), '%Y-%m-%d') 
WHERE Grading_date IS NOT NULL; 

select Expiration,
	DATE_FORMAT(STR_TO_DATE(Expiration, '%M %D, %Y'), '%Y-%m-%d') AS expiration_date
from coffee_data
WHERE Expiration IS NOT NULL;    

UPDATE coffee_data
SET Expiration = DATE_FORMAT(STR_TO_DATE(Expiration, '%M %D, %Y'), '%Y-%m-%d')
WHERE Expiration IS NOT NULL;


-- 5. ALTERNATE NAME OF Bag_weight column to Bag_weight_kg and make all values integers only

ALTER TABLE coffee_data
CHANGE COLUMN `Bag_weight` Bag_weight_kg VARCHAR(100);

-- removing kg suffix

SELECT CONVERT(SUBSTRING(Bag_weight_kg, 1, LENGTH(Bag_weight_kg) - 2), SIGNED) AS weight_in_kg
FROM coffee_data;

select * from coffee_data;

UPDATE coffee_data
SET Bag_weight_kg = CONVERT(SUBSTRING(Bag_weight_kg, 1, LENGTH(Bag_weight_kg) - 2), SIGNED)
WHERE Bag_weight_kg REGEXP '[0-9]+kg';

-- WHERE Bag_weight_kg REGEXP '[0-9]+kg' Part: We're making sure to only update the values that match the pattern of a number followed by "kg."



-- 6. IDENTIFYING UNIQUE VALUES AND COUNTS
SELECT Species, Origin_Country, COUNT(*) AS count
FROM coffee_data
GROUP BY Species, Origin_Country;

-- This query gives list of unique species and origin country combinations along with the count.

-- 7 update inconsistent values

select species from coffee_data
where species = 'Arabic';


--- SQL Queries

-- 1. Calculating average caffeine content for each coffee type;

SELECT species,Roud(AVG(Balance,2)) As Avg_Balance
FROM coffee_data
group by Species;

-- 2.windows function to rank top 3 coffee with sweetness
select species, sweetness,
     Rank() over (Order by sweetness desc) as ranking
from coffee_data
limit 3;


