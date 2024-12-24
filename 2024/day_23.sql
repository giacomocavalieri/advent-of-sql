with ids as (
    select
        id,
        lag(id) over(order by id) as previous_id
    from sequence_table
)
select
    previous_id + 1 as gap_start,
    id - 1 as gap_end,
    array(select generate_series(previous_id + 1, id - 1)) as missing_numbers
from ids
where id - previous_id <> 1
