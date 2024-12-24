with times as (
    select
        areas.place_name,
        min(sleigh_locations.timestamp) as got_in,
        max(sleigh_locations.timestamp) as got_out
    from
        sleigh_locations
        join areas on
            st_intersects(areas.polygon, sleigh_locations.coordinate)
    group by areas.place_name
    order by got_in asc
)
select
    place_name,
    coalesce(lead(got_in, 1) over(), got_out) - got_in
        as total_hours_spent
from times
order by total_hours_spent desc nulls last
