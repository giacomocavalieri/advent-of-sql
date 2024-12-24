select count(*) as numofelveswithsql
from elves
where string_to_array(skills, ',') @> '{SQL}'
