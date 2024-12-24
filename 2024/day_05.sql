with toy_production as (
    -- For each date we keep track of the number of toys produced that day
    -- _and_ the day before.
    -- 
    -- > 💡 This CTE is not strictly necessary but it makes defining the
    -- > percentage increase (or decrease) a lot easier by just refering the
    -- > two values `today` and `yesterday`.
    select
        production_date,
        toys_produced as today,
        lag(toys_produced, 1)
            over(order by production_date)
            as yesterday
    from toy_production
)
select
    production_date,
    today,
    yesterday,
    100.0 * (today - yesterday) / yesterday as perc_diff
from toy_production
order by perc_diff desc nulls last
limit 1