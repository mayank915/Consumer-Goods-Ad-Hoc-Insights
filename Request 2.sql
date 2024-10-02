/* 2. 	What is the percentage of unique product increase in 2021 vs. 2020? 
		The final output contains these fields, 
			unique_products_2020, unique_products_2021, percentage_chg	*/


WITH cte1_fiscalyear_uniqueproducts AS
	(
		SELECT 
			fiscal_year,
			COUNT(DISTINCT(product_code)) AS unique_products
		FROM fact_sales_monthly
		GROUP BY fiscal_year
	),
	cte2_uniqueproducts AS
		(
			SELECT
				MAX(CASE WHEN fiscal_year = 2020 THEN unique_products END) AS unique_products_2020,
				MAX(CASE WHEN fiscal_year = 2021 THEN unique_products END) AS unique_products_2021
			FROM cte1_fiscalyear_uniqueproducts
		)
SELECT
	*,
    ROUND(((unique_products_2021 - unique_products_2020)/(unique_products_2020))*100, 2) AS percentage_chg
FROM cte2_uniqueproducts;