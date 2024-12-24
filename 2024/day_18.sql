with recursive tree(staff_id, staff_name, level, manager_id) as (
    select
        staff_id,
        staff_name,
        1,
        manager_id
    from staff
    where manager_id is null
    union all
    select
        staff.staff_id,
        staff.staff_name,
        tree.level + 1,
        staff.manager_id
    from staff
        join tree on staff.manager_id = tree.staff_id
)
select
    staff_id,
    staff_name,
    level,
    count(manager_id) over(partition by level) as peers
from tree
order by
    peers desc,
    level desc,
    staff_id asc
limit 1
