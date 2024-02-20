SELECT
    name,
    TIMEDIFF(rent_end, rent_start) AS rent_time,
    CONCAT(HOUR(TIMEDIFF(rent_end, rent_start)) * 10, "€") AS rent_amount
FROM
    `Rental`
WHERE
    car_brand = "BMW"
ORDER BY
    rent_time,
    name;