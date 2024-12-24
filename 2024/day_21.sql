with sales as (
    select
        extract(year from sale_date) as year,
        extract(quarter from sale_date) as quarter,
        sum(amount) as total_sales
    from sales
    group by year, quarter
    order by year asc, quarter asc
)
select format('%s,%s', year, quarter) as solution
from sales
order by (total_sales - lag(total_sales) over()) desc
limit 1
