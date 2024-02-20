SELECT
    CONCAT_WS(' ', name, surname) AS staffer
FROM
    `Staff`
WHERE
    LAST_DAY(hire_date) - hire_date + 1 < 15
ORDER BY
    staffer;