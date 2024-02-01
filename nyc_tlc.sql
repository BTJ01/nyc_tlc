-- table preview
SELECT * FROM source LIMIT 10;

-- check relevant columns (some details are wrong in documentation, need to confirm directy)
SELECT 
    vendorID,
    passengerCount,
    puMonth,
    puYear,
    paymentType,
    fareAmount,
    improvementSurcharge,
    extra,
    mtaTax,
    tollsAmount,
    tipAmount,
    totalAmount
FROM source
LIMIT 10;

-- average money & people columns, group by payment type & date
SELECT
    vendorID,
    AVG(vendorID),

FROM source
LIMIT 10;

