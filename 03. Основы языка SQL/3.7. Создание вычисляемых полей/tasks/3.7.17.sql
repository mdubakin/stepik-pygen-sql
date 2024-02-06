SELECT
    CONCAT_WS('. ', id, title) AS movie,
    CONCAT('€', price) AS price
FROM
    `Films`;