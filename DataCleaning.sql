-- DATA CLEANING

select * 
from world_layoffs.layoffs;


-- step1 Remove Duplicates
-- step2 Standardize the data
-- step3 Null values or blank values
-- step4 Remove any columns


Create table world_layoffs.layoffs_staging 
like world_layoffs.layoffs;

select *
from layoffs_staging;

insert layoffs_staging 
select *
from layoffs;




-- step1 Remove Duplicates


with duplicate_cte as 
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;



select * 
from layoffs_staging
where company= 'casper';


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


select * 
from layoffs_staging2;


INSERT INTO layoffs_staging2
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;


delete
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2;




-- Standrazing data
-- The TRIM() function in SQL is a standard way to remove unwanted leading, trailing, or both leading and trailing characters (by default, spaces) from a string
select company, trim(company)
from layoffs_staging2;


UPDATE layoffs_staging2
SET company = TRIM(company);


select distinct industry
from layoffs_staging2;

select *
from layoffs_staging2
where industry like 'Crypto%';


update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


select distinct country
from layoffs_staging2
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country = trim(trailing '.' from country)
where country like 'United States%';


-- should be all min nd 'y' MAJ 'Y' idk why t-t
select `date`, str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;


update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;