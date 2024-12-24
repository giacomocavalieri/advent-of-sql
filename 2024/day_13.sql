with emails as (
    select unnest(email_addresses) as email
    from contact_list
)
select
    split_part(email, '@', 2) as domain,
    count(*) as total_users
from emails
group by domain
order by total_users desc
limit 1