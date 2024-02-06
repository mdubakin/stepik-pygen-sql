SELECT
    title,
    (price * purchases) AS profit
FROM
    `Films`
ORDER BY
    profit DESC
LIMIT
    3;