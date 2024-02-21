SELECT
    IFNULL(name, IFNULL(surname, "Unknown")) AS director,
    rating
FROM
    `Directors`
ORDER BY
    rating DESC;