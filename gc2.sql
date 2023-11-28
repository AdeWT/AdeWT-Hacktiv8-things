-- CREATE DATABASE GC2;

-- Creating Segments table
BEGIN;
CREATE TABLE Segments (
	SegmentID smallint,
	Segment char(20)
);
COMMIT

-- Forgot to assign primary key to Segments table, so here it is:
BEGIN;
ALTER TABLE Segments ADD PRIMARY KEY (SegmentID);
COMMIT;

-- Creating Countries table
BEGIN;
CREATE TABLE Countries (
	CountryID smallint PRIMARY KEY,
	Country char(30)
);
COMMIT;

-- Creating Products table
BEGIN;
CREATE TABLE Products (
	ProductID smallint PRIMARY KEY,
	Product char(20)
);
COMMIT;

-- Creating DiscountBands table
BEGIN;
CREATE TABLE DiscountBands (
	DiscountBandID smallint PRIMARY KEY,
	DiscountBand char(20)
);
COMMIT;


-- check table, one by one

SELECT * FROM Segments;
SELECT * FROM Countries;
SELECT * FROM Products;
SELECT * FROM DiscountBands;

-- input data
BEGIN;
COPY Segments(SegmentID, Segment)
FROM 'C:/Users/Lewell/Documents/GitHub/AdeWT-Hacktiv8-things/Segments.csv'
DELIMITER ','
CSV HEADER;
COMMIT;

BEGIN;
COPY Countries(CountryID, Country)
FROM 'C:/Users/Lewell/Documents/GitHub/AdeWT-Hacktiv8-things/Countries.csv'
DELIMITER ','
CSV HEADER;
COMMIT;

BEGIN;
COPY Products(ProductID, Product)
FROM 'C:/Users/Lewell/Documents/GitHub/AdeWT-Hacktiv8-things/Products.csv'
DELIMITER ','
CSV HEADER;
COMMIT;

BEGIN;
COPY DiscountBands(DiscountBandID, DiscountBand)
FROM 'C:/Users/Lewell/Documents/GitHub/AdeWT-Hacktiv8-things/DiscountBands.csv'
DELIMITER ','
CSV HEADER;
COMMIT;

-- Creating main table CleanFinancials

BEGIN;
CREATE TABLE CleanFinancials (
	SaleID serial PRIMARY KEY,
	SegmentID smallint REFERENCES Segments(SegmentID),
	CountryID smallint REFERENCES Countries(CountryID),
	ProductID smallint REFERENCES Products(ProductID),
	DiscountBandID smallint REFERENCES DiscountBands(DiscountBandID),
	UnitsSold float8,
	ManufacturingPrice float8,
	SalePrice float8,
	GrossSales float8,
	Discounts float8,
	Sales float8,
	COGS float8,
	Profit float8,
	Date char(30),
	MonthNumber smallint,
	MonthName char(30),
	Year smallint
);
COMMIT;

-- input data

BEGIN;
COPY CleanFinancials (
	'Segment ID', 'Country ID', 'Product ID', 'Discount Band ID',
    'Units Sold', 'Manufacturing Price', 'Sale Price', 'Gross Sales',
    'Discounts', 'Sales', 'COGS', 'Profit', 'Date', 'Month Number',
    'Month Name', 'Year'
)
FROM 'C:/Users/Lewell/Documents/GitHub/AdeWT-Hacktiv8-things/CleanFinancials.csv'
DELIMITER ','
CSV HEADER;
COMMIT;

-- check data

select * from cleanfinancials

--Creating users

BEGIN;
CREATE USER John;
COMMIT;

BEGIN;
CREATE USER Doe;
COMMIT;

-- Granting
BEGIN;
GRANT SELECT 
ON ALL TABLES IN SCHEMA public
TO Doe;
COMMIT;


BEGIN;
GRANT ALL
ON SCHEMA public
to John;
COMMIT;

-- Query

SELECT s.Segment, sum(cf.Profit)
FROM cleanFinancials as cf
JOIN Segments as s ON cf.SegmentID = s.SegmentID
WHERE cf.DiscountBandID = 1 -- 1 = none
GROUP BY s.Segment;

SELECT
	c.Country,
	AVG(cf.Sales) as averageSale,
	MIN(cf.Sales) as minSales,
	MAX(cf.Sales) as maxSales
FROM cleanFinancials as cf
JOIN Countries as c ON cf.CountryID = c.CountryID
GROUP BY c.Country;