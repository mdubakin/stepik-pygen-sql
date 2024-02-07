SELECT
    name,
    surname,
    CONCAT(LPAD(rating, 3, 0), '%') AS rating
FROM
    `Directors`
ORDER BY
    rating;