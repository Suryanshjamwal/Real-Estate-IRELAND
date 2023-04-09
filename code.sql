-- Querying data for cleaning, insights and transformation
-- This sql file has some of the related significant queries 

-----------------------------------------------------------------------
-- Property Table

-- Dropping Eircode column
ALTER TABLE `property`
DROP COLUMN Eircode;

-- Change Currency in Excel with find and replace
-- Replace 'Ä' to '' and then format the column price as currency

-- Checking Distinct values for property description and size

SELECT DISTINCT(Description_of_Property)
FROM `property`;

/*
Output:
Row	Description_of_Property
1	New Dwelling house /Apartment
2	Teach/Árasán Cónaithe Atháimhe
3	Second-Hand Dwelling house /Apartment
4	Teach/Árasán Cónaithe Nua
5	Teach/?ras?n C?naithe Nua
*/

-- We need to convert Irish to English language

UPDATE `property`
SET Description_of_Property = REPLACE(Description_of_Property, 'Teach/Árasán Cónaithe Atháimhe', 'Second-Hand Dwelling house /Apartment')
WHERE Description_of_Property='Teach/Árasán Cónaithe Atháimhe';

/*
Output:

Row	Description_of_Property
1	New Dwelling house /Apartment
2	Second-Hand Dwelling house /Apartment
3	Teach/Árasán Cónaithe Nua
4	Teach/?ras?n C?naithe Nua
*/

-- Similarly we replaced the rest

SELECT DISTINCT(Property_Size_Description)
FROM `property`;

/*
Output:

Row	Property_Size_Description Total
1	níos mó ná nó cothrom le 38 méadar cearnach agus níos lú ná 125 méadar cearnach 2
2	NULL 536210 
3	greater than or equal to 38 sq metres and less than 125 sq metres 38085
4	greater than 125 sq metres 6853
5	less than 38 sq metres 3263
6	greater than or equal to 125 sq metres 4610
7	n?os l? n? 38 m?adar cearnach 1
*/

-- CLearly we have more than 90% NULL values in the size column
-- Drop the Property_Size_Description

ALTER TABLE `property`
DROP COLUMN Property_Size_Description;

-- Using Vlookup in excel to fill out regions based on different counties
-- Or Using Case statements like:

SELECT County, Region = 
CASE 
WHEN County = 'Dublin' THEN 'Dublin'
WHEN County = 'Meath' OR
     County = 'Louth' OR
     County = 'Kildare' OR
     County = 'Wicklow' THEN 'Mid East'
WHEN County = 'Wexford' OR
     County = 'Carlow' OR
     County = 'Kilkenny' OR
     County = 'Waterford' THEN 'South East'
WHEN County = 'Cork' OR
     County = 'Kerry' THEN 'South West' 
WHEN County = 'Limerick' OR
     County = 'Clare' OR
     County = 'Tipperary' THEN 'Mid West'
WHEN County = 'Galway' OR
     County = 'Mayo' OR
     County = 'Roscommon' THEN 'West'
WHEN County = 'Longford' OR
     County = 'Westmeath' OR
     County = 'Offaly' OR
     County = 'Laoighis' THEN 'Midlands'
WHEN County = 'Monaghan' OR
     County = 'Cavan' OR
     County = 'Leitrim' OR
     County = 'Sligo' OR
     County = 'Donegal' THEN 'Border'
END 
FROM 'property'
GO

-----------------------------------------------------------------------
-- Rental Table

SELECT * FROM `rental` 
WHERE VALUE IS NOT NULL;

-- 67104 values extracted
-- Saved the table for further cleaning
-- Further addresses had to be separted according to different counties
-- Excel tools like sorting, text to columns and manual transformation helped extracting county names
-- Time taken 45 mins to clean

-----------------------------------------------------------------------
-- Population table
-- Getting an insight 

SELECT Region, Sex, Year, Age_Group, VALUE
FROM `Population` 
Where Year = 2021
and Sex = 'Both sexes'
and Region = 'State'

/*
Output:

Row	Region    Sex    Year Age_Group VALUE
1	State Both sexes 2022 All ages 5100

Value is in thousands
*/

-----------------------------------------------------------------------
-- Income Table 

DELETE FROM `Income`
WHERE Year BETWEEN 2000 AND 2009;

SELECT DISTINCT(Year) 
FROM `Income`;

-- Now table has values from 2010 to 2020

SELECT DISTINCT(Statistic_Label) 
FROM `Income`;

/* 
Output:

Row	Statistic_Label
1	Primary Income
2	Total Household Income
3	Current Taxes on Income
4	Income of Self Employed
5	Total Income per Person
6	Disposable Household Income
7	Disposable Income per Person
8	Index of Total Income per Person
9	Index of Disposable Income per Person
10	Social Benefits and Other Current Transfers
11	Disposable Income per Person (excluding Rent)
12	Index of Disposable Income per Person (excluding Rent)
13	Rent of dwellings (including imputed rent of owner-occupied dwellings)
14	Compensation of Employees (i.e. Wages and Salaries, Benefits in kind, Employers' social insurance contribution)
*/

-- For this analysis we use 'Total income per person', 'Disposable Income per Person' and 'Disposable Income per Person (excluding Rent)'

-----------------------------------------------------------------------
-- Migration table

SELECT DISTINCT(Inward_or_Outward_Flow)
FROM `Migration`

/*
Output:

Row	Inward_or_Outward_Flow 
1	Net migration 
2	Immigrants: All origins 
3	Emigrants: All destinations
*/

-- It would be interesting to see how emigrants and immigrants affect the housing market

-----------------------------------------------------------------------

-- Queries used in tableau


SELECT AVG(Price) AS avg_price, Year, County, Description_of_Property
FROM `property`
GROUP BY Year, County, Description_of_Property
ORDER BY County ASC;

SELECT AVG(Price) AS avg_price, Year
FROM `property`
GROUP BY Year;

SELECT R.Year, R.VALUE, AVG(P.Price) AS avg_price
FROM `property` P
INNER JOIN `GDP_R` R
ON R.Year = P.Year
GROUP BY R.VALUE, R.Year    
ORDER BY R.Year ASC;

SELECT * FROM `Income` 
WHERE Statistic_Label = 'Disposable Income per Person' 
OR Statistic_Label = 'Total Income per Person';  

-- DASHBOARD 1

SELECT COUNT(Price), Year, County, Description_of_property
FROM `property` 
WHERE Price IS NOT NULL
GROUP BY Year, County, Description_of_property
ORDER BY Year ASC;

SELECT AVG(Price), Year, County, Description_of_property
FROM `property` 
WHERE Price IS NOT NULL
GROUP BY Year, County, Description_of_property
ORDER BY Year ASC;

SELECT COUNT(r.VALUE), p.Year, p.County, r.Number_of_Bedrooms
FROM `property` p
LEFT JOIN `rental` r
ON p.County = r.Location
GROUP BY p.Year, p.County, r.Number_of_Bedrooms
ORDER BY p.Year ASC;

SELECT AVG(r.VALUE), p.Year, p.County, r.Number_of_Bedrooms
FROM `property` p
INNER JOIN `rental` r
ON p.County = r.Location
GROUP BY p.Year, p.County, r.Number_of_Bedrooms
ORDER BY p.Year ASC;

-- DASHBOARD 2

SELECT DISTINCT(g.VALUE)*1000000 AS GVA0, g.Year, AVG(p.Price)
FROM `property` p
INNER JOIN `GVA` g
ON p.Year = g.Year
GROUP BY g.Year, g.VALUE
ORDER BY g.Year ASC;

SELECT i.Percent_increase, p.Year, AVG(p.Price) AS AveragePrice
FROM `property` p
RIGHT JOIN `inflation`i
ON p.Year = i.Year
GROUP BY p.Year, i.Percent_increase
ORDER BY p.Year ASC;

SELECT i.interest_rates, p.Year, AVG(p.Price) AS AveragePrice
FROM `property` p
INNER JOIN `interest`i
ON p.Year = i.Year
GROUP BY p.Year, i.interest_rates
ORDER BY p.Year ASC;

SELECT SUM(m.VALUE) OVER(PARTITION BY m.Inward_or_Outward_Flow) AS Migrants,
p.Year, AVG(p.Price) AS AveragePrice, m.Inward_or_Outward_Flow
FROM `property` p
INNER JOIN `migration`m
ON p.Year = m.Year
GROUP BY p.Year, m.Inward_or_Outward_Flow
ORDER BY p.Year ASC;

SELECT u.Annual_change, p.Year, AVG(p.Price) AS AveragePrice
FROM `property` p
INNER JOIN `uemployement` u
ON p.Year = u.Year
GROUP BY p.Year, u.Annual_change
ORDER BY p.Year ASC;

-- DASHBOARD 3

SELECT VALUE, Year, Property_Type, Number_of_Bedrooms
FROM `rental` 
WHERE Property_Type 
IN ('Apartment', 'Detached House', 'Semi-Detached House', 'Terrace House');

SELECT AVG(VALUE), Year, Property_Type, Number_of_Bedrooms, Location, 
FROM `rental` 
WHERE Property_Type 
IN ('Apartment', 'Detached House', 'Semi-Detached House', 'Terrace House')
GROUP BY Property_Type, Location
ORDER BY Property_Type ASC;

-- DASHBOARD 4

SELECT COUNT(VALUE), Stamp_Duty_Event,
Year, Transaction_Class, NUTS_3_Region
FROM `Buyers` 
WHERE St = 'Volume of Sales'
Group BY Year, NUTS_3_Region
ORDER BY Year DESC;

SELECT AVG(VALUE), Stamp_Duty_Event,
Year, Transaction_Class, NUTS_3_Region
FROM `Buyers` 
WHERE St = 'Median Price'
Group BY Year, NUTS_3_Region
ORDER BY Year DESC;

SELECT AVG(VALUE), Stamp_Duty_Event,
Year, Transaction_Class, NUTS_3_Region, Type_of_Buyer
FROM `Buyers` 
WHERE St = 'Median Age'
Group BY Year, NUTS_3_Region
ORDER BY Year DESC;

SELECT AVG(VALUE), Stamp_Duty_Event,
Year, Transaction_Class, NUTS_3_Region, Type_of_Buyer
FROM `Buyers` 
WHERE St = 'Median Income'
Group BY Year, NUTS_3_Region
ORDER BY Year DESC;















