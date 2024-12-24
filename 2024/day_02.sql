with chars as (
    -- We take all the chars from the first table followed by the
    -- chars coming from the second one. It's fundamental we use
    -- `union all` or we eould end up eliminating duplicate letters
    -- coming from the second table!
    (
        select value
        from letters_a
        order by id
    ) union all (
        select value
        from letters_b
        order by id
    )
)
-- We turn each ascii value into a char, aggregate all the valid
-- selected values into an array that we then concat into a single
-- string.
select concat(variadic array_agg(chr(value))) as letter
from chars
where chr(value) similar to '[a-zA-Z!"''(),-.:;? ]'
