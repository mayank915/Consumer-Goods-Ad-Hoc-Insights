-- 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

SELECT DISTINCT
    market
FROM
    dim_customer
WHERE
    customer LIKE 'Atliq Exclusive'
        AND region LIKE 'APAC';