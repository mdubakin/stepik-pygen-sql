SELECT
    task,
    executor,
    TIMEDIFF(task_end, task_start) AS time_spent
FROM
    `Tasks`
ORDER BY
    time_spent
LIMIT
    1;