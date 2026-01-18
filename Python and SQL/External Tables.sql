--------------------
-- Create Credential
--------------------

CREATE MASTER KEY ENCRYPTION BY PASSWORD = ''


CREATE DATABASE SCOPED CREDENTIAL cred_kaustubh
WITH
	IDENTITY = 'Managed Identity'


-------------------------------------------------------------
-- Create External Data Source for Silver and Gold containers
-------------------------------------------------------------

CREATE EXTERNAL DATA SOURCE source_silver
WITH
(
	LOCATION = 'https://dataengineeringproject1.dfs.core.windows.net/silver',
	CREDENTIAL = cred_kaustubh
)


CREATE EXTERNAL DATA SOURCE source_gold
WITH
(
	LOCATION = 'https://dataengineeringproject1.dfs.core.windows.net/gold',
	CREDENTIAL = cred_kaustubh
)


--------------------------------
-- CREATE EXTERNAL FILE FORMAT
--------------------------------

CREATE EXTERNAL FILE FORMAT format_parquet
WITH
(
	FORMAT = PARQUET,
	DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)


--------------------------------
-- CREATE EXTERNAL TABLE (CETAS)
--------------------------------

-- Sales
CREATE EXTERNAL TABLE gold.ext_sales
WITH
(
	LOCATION = 'extSales',
	DATA_SOURCE = source_gold,
	FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales


-- Calendar
CREATE EXTERNAL TABLE gold.ext_calendar
WITH
(
	LOCATION = 'extCalendar',
	DATA_SOURCE = source_gold,
	FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.calendar


-- Territories
CREATE EXTERNAL TABLE gold.ext_territories
WITH
(
	LOCATION = 'extTerritories',
	DATA_SOURCE = source_gold,
	FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.territories










 