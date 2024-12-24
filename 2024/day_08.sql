with recursive management_tree as (
    -- Base case: we select the upper management, that is those
    -- who do not have a manager. Their level starts at 1 as they are
    -- at the root of the management tree.
    select
        staff_id,
        1 as level
    from staff
    where manager_id is null
    union
    -- Recursive case: we pick all the employees managed by
    -- someone on the level above. They're one level below in the
    -- management tree, so we have to increase it by one!
    select 
        staff.staff_id,
        management_tree.level + 1 as level
    from
        management_tree
        join staff on staff.manager_id = management_tree.staff_id
)
select max(level)
from management_tree
