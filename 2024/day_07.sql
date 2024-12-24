with experience as (
    -- For each experience we keep track of what are the minimum and
    -- maximum years of experience in order to pair the least
    -- experienced elf (junior) with the most experienced (senior).
    select
        primary_skill as skill,
        min(years_experience) as min_years,
        max(years_experience) as max_years
    from workshop_elves
    group by primary_skill
)
-- For each skill we pick the elf with the most experience and the
-- one with the least experience (in case of a tie we pick the elf
-- with the greatest id for each category).
select
    min(seniors.elf_id) as senior,
    min(juniors.elf_id) as junior,
    experience.skill
from
    experience
    join workshop_elves as juniors
        on experience.min_years = juniors.years_experience
        and experience.skill = juniors.primary_skill
    join workshop_elves as seniors
        on experience.max_years = seniors.years_experience
        and experience.skill = seniors.primary_skill
where
    -- We want to make sure we never end up pairing an elf with
    -- themselves, this might happen in case they are the only
    -- elf with this given skill!
    seniors.elf_id <> juniors.elf_id
group by experience.skill
order by experience.skill
