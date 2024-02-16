SELECT
    num,
    CONV(num, 10, 2) AS bin,
    CONV(num, 10, 8) AS oct,
    CONV(num, 10, 16) AS hex
FROM
    `PrimeNumbers`
ORDER BY
    num DESC;