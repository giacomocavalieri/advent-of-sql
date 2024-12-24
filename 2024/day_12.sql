with ranked as (
    select
        gifts.gift_name,
        percent_rank()
            over (order by count(*))
            as perc
    from
        gifts
        join gift_requests using(gift_id)
    group by gifts.gift_name
    order by
        perc desc,
        gifts.gift_name asc
)
select
    gift_name,
    round(perc::numeric, 2) as perc
from ranked
where perc <> (select max(perc) from ranked)
order by perc desc
limit 1

