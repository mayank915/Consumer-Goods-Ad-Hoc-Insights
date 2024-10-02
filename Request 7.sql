/* 7.	Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . 
		This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
		The final report contains these columns: 
		Month, Year, Gross sales Amount		*/
    
SELECT 
    date AS Month,
	s.fiscal_year,
    SUM(s.sold_quantity) AS total_sold_quantity,
    ROUND(SUM(s.sold_quantity * g.gross_price)/1000000, 2) AS 'Gross Sales Amount'
FROM
    fact_sales_monthly s
        JOIN
    fact_gross_price g ON g.product_code = s.product_code
        AND g.fiscal_year = s.fiscal_year
        JOIN
    dim_customer c ON c.customer_code = s.customer_code
WHERE
    c.customer LIKE 'Atliq Exclusive'
GROUP BY s.fiscal_year, s.date
ORDER BY Month;