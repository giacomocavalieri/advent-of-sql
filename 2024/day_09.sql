with averages as (
    select
        reindeer_id,
        avg(speed_record) as average
    from training_sessions
    group by
        reindeer_id,
        exercise_name
)
select
    reindeers.reindeer_name,
    round(max(averages.average), 2) as best_speed
from
    reindeers
    join averages using(reindeer_id)
where reindeers.reindeer_name <> 'Rudolph'
group by reindeers.reindeer_name
order by best_speed desc
limit 3