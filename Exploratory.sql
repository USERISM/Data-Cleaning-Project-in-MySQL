--  Exploratory  Data Analysis

select * 
from layoffs_staging2;

select *
from layoffs_staging2
where total_laid_off =(
select max(total_laid_off)
from layoffs_staging2);

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select *
from layoffs_staging2
where percentage_laid_off =1
order by total_laid_off desc;

select min(`date`), max(`date`)
from layoffs_staging2;
