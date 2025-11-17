-- DATA CLEANING

-- Change column name 'Memory' to 'RAM'
EXEC sp_rename 'phone_sales.Memory', 'RAM', 'COLUMN';

SELECT * FROM phone_sales
where Colors is null;

-- Check Null column 
SELECT * FROM phone_sales
where Colors is null or
	RAM is null or
	Storage is null or
	Rating is null ;

-- Fill in missing values in memory column from mobile 'vivo Y20A 2021'
SELECT * FROM phone_sales
WHERE mobile = 'vivo Y20A 2021';

UPDATE phone_sales
SET RAM = '3 GB'
WHERE Models = 'Y20A 2021';

SELECT * FROM phone_sales
WHERE RAM is Null;


SELECT * FROM phone_sales
WHERE Brands = 'Apple' AND
	Models = 'iPhone 12 Pro Max' 

-- Fill in null values to '6 GB' to Models 'iPhone 12 Pro Max'
UPDATE phone_sales
SET RAM = '6 GB'
WHERE Models = 'iPhone 12 Pro Max' AND
	RAM IS NULL;

SELECT * FROM phone_sales
WHERE RAM IS NULL;

SELECT * FROM phone_sales
WHERE Models = '106' OR
	Models = '225' OR
	Models = 'GT 1200 R/I/M' OR
	Models = 'Guru 1200' OR
	Models = 'Guru E1207T' OR
	Models = 'Guru FM Plus' OR
	Models = 'Guru FM Plus SM-B110E/D' OR
	Models = 'Guru Music 2' OR
	Models = 'Guru Music 2 SM-B310E' OR
	Models = 'iPhone 7' OR
	Models = 'Metro 313' OR
	Models = 'Metro SM-B313ez' OR
	Models = 'Sm-B110E/D' OR
	Models = 'Y11T Pro' OR 
	Models = 'Y21' OR
	Models = 'Y73' ; 

SELECT DISTINCT Models, RAM, Storage FROM phone_sales
WHERE (Models = '106' OR
	Models = '225' OR
	Models = 'GT 1200 R/I/M' OR
	Models = 'Guru 1200' OR
	Models = 'Guru E1207T' OR
	Models = 'Guru FM Plus' OR
	Models = 'Guru FM Plus SM-B110E/D' OR
	Models = 'Guru Music 2' OR
	Models = 'Guru Music 2 SM-B310E' OR
	Models = 'iPhone 7' OR
	Models = 'Metro 313' OR
	Models = 'Metro SM-B313ez' OR
	Models = 'Sm-B110E/D' OR
	Models = 'Y11T Pro' OR 
	Models = 'Y21' OR
	Models = 'Y73')
	AND RAM IS  NULL; 




SELECT DISTINCT Models, RAM FROM phone_sales
WHERE
	Models NOT in (
	'Metro 313',
	'iPhone 7',
	'Y11T Pro',
	'225',
	'Guru FM Plus',
	'Y73',
	'Y21',
	'106' ) 
	

SELECT DISTINCT Models, RAM, Storage,Mobile From phone_sales
WHERE 
	Models IN 
	('GT 1200 R/I/M',
	'Guru 1200',
	'Guru E1207T',
	'Guru FM Plus SM-B110E/D',
	'Guru Music 2',
	'Guru Music 2 SM-B310E',
	'Metro SM-B313ez',
	'Sm-B110E/D') 
		
SELECT * FROM phone_sales
WHERE
	Models = 'Guru FM Plus SM-B110E/D'

-- Fill in all missing value in column 'RAM' 
UPDATE phone_sales
SET RAM = 
    CASE Models
        WHEN '106' THEN '4 MB'
        WHEN '225' THEN '8 MB'
        WHEN 'GT 1200 R/I/M' THEN '8 MB'
        WHEN 'Guru 1200' THEN '4 MB'
        WHEN 'Guru E1207T' THEN '4 MB'
        WHEN 'Guru FM Plus' THEN '4 MB'
        WHEN 'Guru Music 2' THEN '4 MB'
        WHEN 'iPhone 7' THEN '2 GB'
        WHEN 'Metro 313' THEN '2 MB'
        WHEN 'Metro SM-B313ez' THEN '10 MB'
        WHEN 'Sm-B110E/D' THEN '4 MB'
        WHEN 'Y11T Pro' THEN '8 GB'
        WHEN 'Y21' THEN '6 GB'
        WHEN 'Y73' THEN '3 GB'
        ELSE RAM
    END
WHERE
    Models IN ('106', '225', 'GT 1200 R/I/M', 'Guru 1200', 'Guru E1207T', 'Guru FM Plus', 
               'Guru Music 2', 'iPhone 7', 'Metro 313', 'Metro SM-B313ez', 'Sm-B110E/D', 
               'Y11T Pro', 'Y21', 'Y73');

UPDATE phone_sales
SET RAM = 
    CASE Models
		WHEN 'Guru Music 2 SM-B310E' THEN '4 MB'
		WHEN 'Guru FM Plus SM-B110E/D' THEN '4 MB'
		ELSE RAM
	END
WHERE
	MODELS IN ('Guru Music 2 SM-B310E', 'Guru FM Plus SM-B110E/D');

-- Standardize space in RAM column
UPDATE phone_sales
SET RAM = 
	REPLACE(REPLACE(REPLACE(RAM, ' ', ''), 'GB', ' GB'), 'MB', ' MB')
WHERE 
	RAM Like '%GB%' OR RAM Like '%MB%';

-- Column RAM is done. There is no null values anymore

SELECT Mobile, Storage, Colors, Original_Price FROM phone_sales
WHERE 
	Mobile IN (
	'Apple iPhone 13 Pro Max',
	'Apple iPhone 6s Plus',
	'realme 1',
	'realme 2',
	'realme 3',
	'realme 5i',
	'realme 6',
	'realme 6i',
	'realme 8',
	'realme 8 Pro',
	'realme C15',
	'realme C2',
	'realme C21Y',
	'realme Narzo 30A',
	'realme X',
	'realme X2',
	'realme X3 SuperZoom',
	'SAMSUNG Galaxy M20') 
ORDER BY 1,2;

-- Fill in NULL in column 'Storage'
UPDATE phone_sales
SET Storage =
    CASE
        -- Apple iPhone 13 Pro Max (Requires Color filter)
        WHEN Mobile = 'Apple iPhone 13 Pro Max' AND Colors = 'Silver' THEN '128 GB'
        WHEN Mobile = 'Apple iPhone 13 Pro Max' AND Colors = 'Sierra Blue' THEN '256 GB'
        WHEN Mobile = 'Apple iPhone 13 Pro Max' AND Colors = 'Gold' THEN '1 TB'
        -- realme 1 (Requires Price filter)
        WHEN Mobile = 'realme 1' AND Original_Price = 12990 THEN '32 GB'
        WHEN Mobile = 'realme 1' AND Original_Price = 14990 THEN '128 GB'
        -- Other Models (Based on Mobile Name Only)
        WHEN Mobile = 'Apple iPhone 6s Plus' THEN '32 GB'
        WHEN Mobile = 'realme 2' THEN '32 GB'
        WHEN Mobile = 'realme 3' THEN '32 GB'
        WHEN Mobile = 'realme 5i' THEN '64 GB'
        WHEN Mobile = 'realme 6' THEN '64 GB'
        WHEN Mobile = 'realme 6i' THEN '64 GB'
        WHEN Mobile = 'realme 8' THEN '128 GB'
        WHEN Mobile = 'realme 8 Pro' THEN '128 GB'
        WHEN Mobile = 'realme C15' THEN '64 GB'
        WHEN Mobile = 'realme C2' THEN '32 GB'
        WHEN Mobile = 'realme Narzo 30A' THEN '64 GB'
        WHEN Mobile = 'realme X' THEN '128 GB'
        WHEN Mobile = 'realme X2' THEN '64 GB'
        WHEN Mobile = 'realme X3 SuperZoom' THEN '256 GB'
        WHEN Mobile = 'realme C21Y' THEN '64 GB'
        WHEN Mobile = 'SAMSUNG Galaxy M20' THEN '64 GB'
        
        ELSE Storage -- Keep the existing Storage value if there is no match.
    END
WHERE
    Mobile IN ( -- Filter to speed up execution (optional)
        'Apple iPhone 13 Pro Max', 'Apple iPhone 6s Plus', 'realme 1', 'realme 2', 'realme 3', 
        'realme 5i', 'realme 6', 'realme 6i', 'realme 8', 'realme 8 Pro', 'realme C15', 
        'realme C2', 'realme Narzo 30A', 'realme X', 'realme X2', 'realme X3 SuperZoom', 
        'realme C21Y', 'SAMSUNG Galaxy M20'
    );

select * from phone_sales
WHERE storage is NULL
-- Column Storage is DONE


SELECT Mobile, Avg(Rating) as avg_rating From phone_sales
WHERE rating is not null
GROUP BY Mobile
ORDER BY 1

SELECT COUNT( Distinct Models) From phone_sales

SELECT COUNT(Distinct Mobile) From phone_sales
WHERE Rating is NULL

SELECT Distinct Mobile From phone_sales
WHERE RATING is null
order by Mobile

-- Average rating for 'Mobile' that has a null value in the rating column 
SELECT
    Mobile,
    AVG(Rating) AS Average_Rating_Per_Model
FROM
    phone_sales
WHERE
    Mobile IN (
        'Apple iPhone 13',
        'Apple iPhone 13 Mini',
        'Apple iPhone 13 Pro',
        'Apple iPhone 13 Pro Max',
        'Apple iPhone 6s',
        'ASUS ROG 5s',
        'ASUS ROG 5s Pro',
        'ASUS ROG Phone 5 Pro',
        'ASUS ROG Phone 5 Ultimate',
        'GIONEE F10 Plus',
        'Lenovo Vibe S1',
        'LG G8s ThinQ',
        'Motorola Edge 20 Fusion',
        'Nokia 110 4G',
        'Nokia 6310',
        'Nokia C01 Plus',
        'Nokia G10',
        'Nokia G20',
        'OPPO A16',
        'OPPO A74 5G',
        'OPPO F11 Pro Marvel? Avengers Limited Edition',
        'OPPO F19s',
        'OPPO Reno7 5G',
        'POCO F1',
        'realme 1',
        'realme 8i',
        'realme 8s 5G',
        'realme C21Y',
        'realme C25Y',
        'SAMSUNG Fold 2 5G',
        'SAMSUNG Galaxy M21 2021 Edition',
        'SAMSUNG Galaxy M32 5G',
        'SAMSUNG Galaxy Z Flip',
        'SAMSUNG Guru FM Plus',
        'SAMSUNG M32 5G',
        'SAMSUNG S20 FE 5G',
        'vivo T1 5G',
        'vivo Y20G 2021',
        'vivo Y73',
        'Xiaomi Mi A3',
        'Xiaomi Redmi Note 7',
        'Xiaomi REDMI Note 9',
        'Xiaomi Redmi Note 9 Pro',
        'Xiaomi Redmi Y2'
    )
    AND Rating IS NOT NULL 
GROUP BY
    Mobile
ORDER BY
    Mobile;


-- Fill in Rating with their average rating each Mobile
UPDATE phone_sales
SET Rating =
    CASE Mobile
        WHEN 'Apple iPhone 13' THEN 4.7
        WHEN 'Apple iPhone 13 mini' THEN 4.6
        WHEN 'Apple iPhone 13 Pro' THEN 4.7
        WHEN 'Apple iPhone 13 Pro Max' THEN 4.68947368421053
        WHEN 'Apple iPhone 6s' THEN 4.5
        WHEN 'Motorola Edge 20 Fusion' THEN 3.9
        WHEN 'OPPO A16' THEN 3.85
        WHEN 'OPPO A74 5G' THEN 4.3
        WHEN 'POCO F1' THEN 4.5
        WHEN 'realme 1' THEN 4.34444444444444
        WHEN 'realme 8s 5G' THEN 4.5
        WHEN 'realme C21Y' THEN 4.4
        WHEN 'realme C25Y' THEN 4.5
        WHEN 'SAMSUNG Guru FM Plus' THEN 4.2
        WHEN 'vivo Y20G 2021' THEN 4.3
        WHEN 'vivo Y73' THEN 4.4
        WHEN 'Xiaomi Mi A3' THEN 4.35
        WHEN 'Xiaomi Redmi Note 7' THEN 4.25
        WHEN 'Xiaomi REDMI Note 9' THEN 4.35
        WHEN 'Xiaomi Redmi Note 9 Pro' THEN 4.34
        WHEN 'Xiaomi Redmi Y2' THEN 4.27777777777778
        ELSE Rating 
    END
WHERE
    Rating IS NULL -- Only update rows whose Rating is NULL
    AND Mobile IN ( 
        'Apple iPhone 13', 'Apple iPhone 13 mini', 'Apple iPhone 13 Pro', 'Apple iPhone 13 Pro Max',
        'Apple iPhone 6s', 'Motorola Edge 20 Fusion', 'OPPO A16', 'OPPO A74 5G', 'POCO F1',
        'realme 1', 'realme 8s 5G', 'realme C21Y', 'realme C25Y', 'SAMSUNG Guru FM Plus',
        'vivo Y20G 2021', 'vivo Y73', 'Xiaomi Mi A3', 'Xiaomi Redmi Note 7', 'Xiaomi REDMI Note 9',
        'Xiaomi Redmi Note 9 Pro', 'Xiaomi Redmi Y2'
    );

SELECT DISTINCT Mobile From phone_sales
WHERE Rating is NULL

SELECT
    Mobile,
    AVG(Rating) AS Average_Rating_Per_Model
FROM
    phone_sales
WHERE
    Mobile IN (
        'ASUS ROG 5s',
        'ASUS ROG 5s Pro',
        'ASUS ROG Phone 5 Pro',
        'ASUS ROG Phone 5 Ultimate',
        'GIONEE F10 Plus',
        'Lenovo Vibe S1',
        'LG G8s ThinQ',
        'Nokia 110 4G',
        'Nokia 6310',
        'Nokia C01 Plus',
        'Nokia G10',
        'Nokia G20',
        'OPPO F11 Pro Marvel? Avengers Limited Edition',
        'OPPO F19s',
        'OPPO Reno7 5G',
        'realme 8i',
        'SAMSUNG Fold 2 5G',
        'SAMSUNG Galaxy M21 2021 Edition',
        'SAMSUNG Galaxy M32 5G',
        'SAMSUNG Galaxy Z Flip',
        'SAMSUNG M32 5G',
        'SAMSUNG S20 FE 5G',
        'vivo T1 5G'
    )
    AND Rating IS  NULL --
GROUP BY
    Mobile
ORDER BY
    Mobile; -- These 23 rows have no Average Rating 


-- Drop Mobile that does not exist Average rating per model


-- STEP 1: VERIFICATION (Check which rows will be deleted)
SELECT COUNT(*) AS Rows_to_be_Deleted
FROM phone_sales
WHERE Mobile IN (
    'ASUS ROG 5s', 'ASUS ROG 5s Pro', 'ASUS ROG Phone 5 Pro', 'ASUS ROG Phone 5 Ultimate',
    'GIONEE F10 Plus', 'Lenovo Vibe S1', 'LG G8s ThinQ', 'Nokia 110 4G', 
    'Nokia 6310', 'Nokia C01 Plus', 'Nokia G10', 'Nokia G20', 
    'OPPO F11 Pro Marvel? Avengers Limited Edition', 'OPPO F19s', 'OPPO Reno7 5G',
    'realme 8i', 'SAMSUNG Fold 2 5G', 'SAMSUNG Galaxy M21 2021 Edition', 
    'SAMSUNG Galaxy M32 5G', 'SAMSUNG Galaxy Z Flip', 'SAMSUNG M32 5G', 
    'SAMSUNG S20 FE 5G', 'vivo T1 5G'
);

-- STEP 2: EXECUTE DELETION IN TRANSACTION (Secure Delete)
BEGIN TRAN; -- Starting a transaction (changes not yet final)

DELETE FROM phone_sales
WHERE Mobile IN (
    'ASUS ROG 5s', 'ASUS ROG 5s Pro', 'ASUS ROG Phone 5 Pro', 'ASUS ROG Phone 5 Ultimate',
    'GIONEE F10 Plus', 'Lenovo Vibe S1', 'LG G8s ThinQ', 'Nokia 110 4G', 
    'Nokia 6310', 'Nokia C01 Plus', 'Nokia G10', 'Nokia G20', 
    'OPPO F11 Pro Marvel? Avengers Limited Edition', 'OPPO F19s', 'OPPO Reno7 5G',
    'realme 8i', 'SAMSUNG Fold 2 5G', 'SAMSUNG Galaxy M21 2021 Edition', 
    'SAMSUNG Galaxy M32 5G', 'SAMSUNG Galaxy Z Flip', 'SAMSUNG M32 5G', 
    'SAMSUNG S20 FE 5G', 'vivo T1 5G'
);


COMMIT TRAN; -- Save changes permanently to the database

SELECT * FROM phone_sales;



-- DATA CLEANING IS DONE 
