
-- STEPS FOR CLEANING DATA 
-- 1. REMOVE DUPLICATES
-- 2 . STANDARDIZE THE DATA
-- 3. NULL VALUES OR BLACK VALUES
-- 4. REMOVE ANY COLUMNS

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT*
FROM layoffs_staging
;

INSERT layoffs_staging
SELECT *
FROM layoffs
;



-- REMOVIG DUPLICATES.alter

SELECT*,
ROW_NUMBER() 
OVER( PARTITION BY 
company, industry, total_laid_off, percentage_laid_off, 'date') AS row_num
FROM layoffs_staging
;

WITH dublicate_cte AS
(
SELECT*,
ROW_NUMBER() 
OVER( PARTITION BY 
company,location,industry,total_laid_off, percentage_laid_off, 'date'
,stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT*
FROM dublicate_cte
WHERE row_num >1; 

SELECT *
FROM layoffs_staging
WHERE company='casper';










CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;


INSERT INTO  layoffs_staging2
SELECT*,
ROW_NUMBER() 
OVER( PARTITION BY 
company,location,industry,total_laid_off, percentage_laid_off, 'date'
,stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging
;

select*
FROM layoffs_staging2
WHERE row_num>1;

SELECT *
FROM layoffs_staging2
;
SELECT *
FROM layoffs_staging2
WHERE company= 'casper';

-- STANDARDIZING DATA
SELECT company, TRIM(company)
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET company = TRIM(company)
;

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1
;
SELECT*
FROM layoffs_staging2
WHERE industry LIKE 'crypto%'
;

UPDATE layoffs_staging2
SET industry='crypto'
WHERE industry like 'crypto%'
;

SELECT DISTINCT  country , TRIM( TRAILING '.'  FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
 SET country =TRIM( TRAILING '.'  FROM country)
 WHERE country LIKE 'United States%'
 ;
 
 SELECT `date`,
 STR_TO_DATE(`date`,'%m/%d/%Y')
 FROM layoffs_staging2
 ;

UPDATE layoffs_staging2
SET `date`= STR_TO_DATE(`date`,'%m/%d/%Y')
;


 SELECT `date`
 FROM layoffs_staging2
 ;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE
;

-- WORKIG WITH NULLS AND BLANK VALUES.

 SELECT *
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL
 AND percentage_laid_off IS NULL
 ;
-- FIRST POPULATE DATE THAT IS POPULABLE 

SELECT *
FROM  layoffs_staging2
WHERE industry IS NULL
OR industry ='';

SELECT *
FROM layoffs_staging2
WHERE company= 'Airbnb';

-- 1st thing is to change the blanks to null.

UPDATE layoffs_staging2
SET industry =Null
WHERE industry= ''
;

SELECT company,industry
FROM layoffs_staging2
;

SELECT* 
FROM layoffs_staging2 t1
    JOIN layoffs_staging2 t2
        ON t1.company=t2.company
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL
;

UPDATE layoffs_staging2 t1
        JOIN layoffs_staging2 t2
         ON t1.company=t2.company
 SET t1.industry=t2.industry
 WHERE t1.industry IS NULL
 AND t2.industry IS NOT NULL
 ;

Select *
from layoffs_staging2
where company like 'bally%';

-- LOOK FOR THE COLUMNS THAT YOU CANT POPULATE THEN DELETE THEM.
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS  NULL
;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS  NULL
;

Select *
from layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP row_num;
