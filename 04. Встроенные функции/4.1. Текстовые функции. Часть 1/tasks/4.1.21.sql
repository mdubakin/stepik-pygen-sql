SELECT
    REPEAT(english, CHAR_LENGTH(english)) AS english
FROM
    `Palindromes`
WHERE
    english = REVERSE(english)
    AND russian != REVERSE(russian);