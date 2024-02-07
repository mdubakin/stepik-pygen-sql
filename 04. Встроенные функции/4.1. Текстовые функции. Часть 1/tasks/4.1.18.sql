SELECT
    REPEAT('*', CHAR_LENGTH(name)) AS name,
    surname
FROM
    `Directors`
ORDER BY
    name DESC,
    surname;