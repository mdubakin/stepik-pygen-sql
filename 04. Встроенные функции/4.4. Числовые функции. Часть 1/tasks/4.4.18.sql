SELECT
    CONCAT('[', a, '; ', b, ']') AS 'range',
    FLOOR(RAND() * (b - a + 1) + a) AS random_value
FROM
    `Ranges`
ORDER BY
    id;