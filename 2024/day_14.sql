select
    record_date,
    cleaning_receipts
from santarecords
where cleaning_receipts @> '[{"garment": "suit", "color": "green"}]'
order by record_date desc
limit 1
