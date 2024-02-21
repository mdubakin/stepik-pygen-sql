SELECT
    name,
    surname,
    IFNULL(rating, 0) AS rating
FROM
    `Directors`
ORDER BY
    rating,
    name;