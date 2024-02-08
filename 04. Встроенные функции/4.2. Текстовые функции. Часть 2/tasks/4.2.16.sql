SELECT
    CONCAT_WS('. ', LEFT(name, 1), surname) AS director
FROM
    `Directors`
ORDER BY
    LEFT(name, 1),
    surname;