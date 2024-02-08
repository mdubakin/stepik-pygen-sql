SELECT
    id,
    name,
    surname,
    CONCAT(REPEAT('*', 12), RIGHT(card_number, 4)) AS card_number
FROM
    `Clients`
LIMIT
    5;