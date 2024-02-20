SELECT
    CONCAT_WS(" ", name, surname) AS staffer,
    TIMEDIFF(
        SUBTIME(work_end, TIMEDIFF(break_end, break_start)),
        work_start
    ) AS work_time
FROM
    `Staff`
ORDER BY
    work_time DESC,
    staffer;