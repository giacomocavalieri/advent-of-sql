select
    children.name as child_name,
    gifts.name as gift_name,
    gifts.price as gift_price
from
    children
    join gifts using (child_id)
where
    -- Note how we only care about kids who have been gifted toys with a price
    -- that is above average!
    gifts.price > (
        select avg(gifts.price)
        from gifts
    )
order by gift_price asc
limit 1
