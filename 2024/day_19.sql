with employee as (
    select
        salary,
        year_end_performance_scores[array_upper(year_end_performance_scores, 1)]
            as score
    from employees
),
salaries as (
    select
        case
            when score > avg(score) over () then salary * 1.15
            else salary
        end as salary
    from employee
)
select round(sum(salary), 2) as total_salary_with_bonuses
from salaries;
