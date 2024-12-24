-- Show the 3-season moving average per field per season per year
-- > 🚨 Seasons are ordered Spring, Summer, Fall, Winter!
-- 
select
    field_name,
    harvest_year,
    season,
    avg(trees_harvested) over (
        partition by harvest_year, field_name
        order by array_position('{Spring, Summer, Fall, Winter}', season)
        rows between 2 preceding and current row
    )
from treeharvests
order by avg desc




