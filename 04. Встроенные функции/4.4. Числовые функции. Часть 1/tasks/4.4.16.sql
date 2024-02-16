SELECT
    x,
    y,
    ROUND((SQRT(POW(x, 2) + POW(y, 2))), 2) AS distance
FROM
    `Points`
WHERE
    ROUND((SQRT(POW(x, 2) + POW(y, 2))), 2) > 20
ORDER BY
    distance DESC;