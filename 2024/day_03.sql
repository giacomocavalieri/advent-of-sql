with events as (
    select
        -- Depending on the version of the document, the number of guests will
        -- be stored at a different path.
        -- The database only has three different versions.
        case xpath('//*/@version', menu_data)::text[]
            when '{1.0}' then xpath('//*/total_count/text()', menu_data)
            when '{2.0}' then xpath('//*/total_guests/text()', menu_data)
            when '{3.0}' then xpath('//*/total_present/text()', menu_data)
            end as headcount,
        -- All the xml documents store the food in a list of `food_item_id`
        -- elements so we don't have to take different actions based on the
        -- version. 
        unnest(xpath('//*/food_item_id/text()', menu_data)::text[]) as food
    from christmas_menus
)
select food
from events
where
    -- The headcount we extracted using `xpath` is still an `xml` document, so
    -- to turn it into a number we first transofrm it into a `text[]`. It will
    -- contain just a single element -the headcount- that we can then select
    -- and parse into an integer.
    -- > 💡 I could have done the transformation directly in the CVE but to
    -- > avoid repeating it for all different branches I opted to go for this
    -- > solution.
    (headcount::text[])[1]::int >= 78
group by food
order by count(*) desc
limit 1
