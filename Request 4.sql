/* 4.	Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
		The final output contains these fields, 
        segment, product_count_2020, product_count_2021, difference		*/


WITH cte1_segment_year_productcount AS
	(        
		SELECT
			p.segment,
			s.fiscal_year,
			COUNT(DISTINCT(s.product_code)) AS product_count
		FROM fact_sales_monthly s
		JOIN dim_product p ON p.product_code = s.product_code
		GROUP BY p.segment, s.fiscal_year
	),
	cte2_segment_productcount AS
		(
			SELECT
				segment,
				MAX(CASE WHEN fiscal_year = 2020 THEN product_count END) AS product_count_2020,
				MAX(CASE WHEN fiscal_year = 2021 THEN product_count END) AS product_count_2021
			FROM cte1_segment_year_productcount
			GROUP BY segment
		)
SELECT
	*,
    product_count_2021 - product_count_2020 AS difference
FROM cte2_segment_productcount;