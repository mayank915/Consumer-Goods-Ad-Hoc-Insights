/* 6. 	Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct 
		for the fiscal year 2021 and in the Indian market. 
		The final output contains these fields, 
        customer_code, customer, average_discount_percentage	*/

-- Method 1:

SELECT 
    c.customer_code,
    c.customer,
    ROUND(AVG(pre_invoice_discount_pct), 3) AS average_discount_percentage
FROM
    fact_pre_invoice_deductions pid
        JOIN
    dim_customer c ON c.customer_code = pid.customer_code
WHERE
    fiscal_year = 2021
        AND c.market LIKE 'India'
GROUP BY c.customer_code , c.customer
ORDER BY average_discount_percentage DESC
LIMIT 5;

-- Method 2:
WITH customercode_average AS
(
	SELECT 
		customer_code,
		AVG(pre_invoice_discount_pct) AS average_discount_percentage
	FROM fact_pre_invoice_deductions
	WHERE fiscal_year = 2021
	GROUP BY customer_code
)
SELECT
	cca.customer_code,
    customer,
    ROUND(cca.average_discount_percentage, 3) AS average_discount_percentage
FROM customercode_average cca
JOIN dim_customer c ON c.customer_code = cca.customer_code
where market LIKE 'India'
ORDER BY average_discount_percentage DESC
LIMIT 5;