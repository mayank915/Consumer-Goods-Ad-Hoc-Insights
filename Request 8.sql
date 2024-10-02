/* 8. 	In which quarter of 2020, got the maximum total_sold_quantity?
		The final output contains these fields sorted by the total_sold_quantity,
        Quarter total_sold_quantity		*/
-- Method 1:
        
SELECT 
    CONCAT('Q',
            CONVERT( CEIL(MONTH(DATE_ADD(date, INTERVAL 4 MONTH)) / 3) , CHAR)) AS Quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM
    fact_sales_monthly
WHERE
    fiscal_year = 2020
GROUP BY Quarter
ORDER BY total_sold_quantity DESC;

-- Method 2:

WITH quarter AS
(
	SELECT
		*,
		CONCAT('Q', CONVERT(CEIL(MONTH(DATE_ADD(date, INTERVAL 4 MONTH))/3), CHAR)) AS Quarter
	FROM fact_sales_monthly
	WHERE fiscal_year = 2020
)
SELECT
	Quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM quarter
GROUP BY Quarter
ORDER BY total_sold_quantity DESC;