SELECT
    task,
    executor,
    DATEDIFF(task_end, task_start) + 1 AS days_spent
FROM
    `Tasks`
ORDER BY
    days_spent DESC
LIMIT
    1;