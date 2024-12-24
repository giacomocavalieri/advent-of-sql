select
    url,
    (
        select count(distinct match[1])
        from regexp_matches(url, '[?&]([^=#&]+)=([^&#]*)', 'g') as match
    ) as count_params
from web_requests
where url like '%utm_source=advent-of-sql%'
order by count_params desc, url asc
limit 1;
