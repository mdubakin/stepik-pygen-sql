SELECT
    name,
    surname,
    REPLACE(card_number, '-', '') AS card_number
FROM
    `Clients`
WHERE
    LEFT(surname, 1) = 's'
ORDER BY
    surname;