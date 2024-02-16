SELECT
    title,
    director,
    (
        CONCAT_WS(
            ':',
            LPAD(running_time DIV 60, 2, '0'),
            LPAD(running_time MOD 60, 2, '0')
        )
    ) AS timing
FROM
    `Films`
ORDER BY
    running_time DESC;