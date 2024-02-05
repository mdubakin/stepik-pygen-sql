SELECT
    title,
    director
FROM
    `Films`
WHERE
    title NOT LIKE '% %'
ORDER BY
    title;