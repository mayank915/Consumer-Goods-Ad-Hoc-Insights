/* 9. 	Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? 
		The final output contains these fields, 
        channel, gross_sales_mln, percentage	*/

WITH percentage AS
(        
	SELECT 
		c.channel,
		ROUND(SUM(s.sold_quantity * g.gross_price)/1000000, 2) AS gross_sales_mln
	FROM fact_sales_monthly s
	JOIN fact_gross_price g ON g.product_code = s.product_code AND g.fiscal_year = s.fiscal_year
	JOIN dim_customer c ON c.customer_code = s.customer_code
	WHERE s.fiscal_year = 2021
	GROUP BY c.channel
)
SELECT
	*,
    (gross_sales_mln*100)/SUM(gross_sales_mln) OVER() AS percentage
FROM percentage
ORDER BY percentage DESC;