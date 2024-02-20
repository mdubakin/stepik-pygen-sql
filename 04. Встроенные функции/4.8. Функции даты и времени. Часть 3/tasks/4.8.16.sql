SELECT
    name,
    surname,
    TIMESTAMPDIFF(YEAR, birth_date, UTC_DATE) AS age
FROM
    `Actors`
ORDER BY
    age DESC;