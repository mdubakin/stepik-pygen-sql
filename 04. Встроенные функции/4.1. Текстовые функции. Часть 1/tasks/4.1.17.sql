SELECT
    name,
    surname,
    UPPER(country) AS country
FROM
    `Directors`
ORDER BY
    country,
    name;