-- Exploratory Data Analysis

-- Here we are just going to explore the data and find trends or patterns.

-- with this info we are just going to look around and see what we find!

select *
from layoffs_staging2;

-- Looking at Percentage to see how big these layoffs were
select Max(total_laid_off), Max(percentage_laid_off)
from layoffs_staging2;

-- Which companies had 1 which is basically 100 percent of they company laid off

select *
from layoffs_staging2
where percentage_laid_off = 1
Order by funds_raised_millions DESC ;

-- these are mostly startups it looks like who all went out of business during this time




-- Companies with the most Total Layoffs
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

select min(`date`), max(`date`)
from layoffs_staging2;


select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 DESC;


select *
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 DESC;



-- this it total in the past 3 years or in the dataset

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 DESC;



select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 DESC;


select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 DESC;


select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc;


-- Rolling Total of Layoffs Per Month

with rolling_total as
(select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`,total_off,
sum(total_off) over(order by `month`) as rolling_tot
from rolling_total;


select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 DESC;




-- Now let's look at that per year.

with company_year (company, years,total_laidoff)as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), company_year_rank as
(
select*, dense_rank() over(partition by years order by total_laidoff desc) as ranking
from company_year
where years is not null
)
select * 
from company_year_rank
where ranking <= 5;



















