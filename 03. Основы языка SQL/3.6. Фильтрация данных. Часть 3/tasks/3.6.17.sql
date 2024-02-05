SELECT
    DISTINCT director
FROM
    `Films`
WHERE
    director LIKE '% s%n'
ORDER BY
    director;