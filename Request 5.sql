/* 5.	Get the products that have the highest and lowest manufacturing costs. 
		The final output should contain these fields, 
        product_code, product, manufacturing_cost	*/
        
SELECT 
    m.product_code, p.product, manufacturing_cost
FROM
    fact_manufacturing_cost m
        JOIN
    dim_product p ON p.product_code = m.product_code
WHERE
    manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost)
        OR manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost);