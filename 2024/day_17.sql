select
    max(
        (current_date + business_start_time)
        at time zone timezone
        at time zone 'utc'
    )::time as earliest_start_time
from workshops;
