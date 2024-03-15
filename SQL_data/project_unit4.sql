SELECT `Food product`, ROUND((AVG(`Production (tonnes)`)*1000),2) AS 'AVERAGE KG PRODUCTION' FROM proyect_unit4.european_food_production
GROUP BY `Food product`
ORDER BY `AVERAGE KG PRODUCTION` DESC;

CREATE TEMPORARY TABLE proyect_unit4.product_total_eu_emmision
SELECT  efp.`country`, efp.`Food product`, efp.`production (tonnes)`*1000 as 'Production Kg',fpe.`Total_emissions` as 'World Emissions per kg',
((efp.`production (tonnes)`*1000)*fpe.`Total_emissions`) as 'Total emissiones per country vs product'
FROM proyect_unit4.european_food_production as efp
JOIN proyect_unit4.food_prodcution_emission1 as fpe
ON fpe.`Food product`= efp.`Food product`
ORDER BY `Total emissiones per country vs product` DESC;

SELECT * FROM proyect_unit4.product_total_eu_emmision;

SELECT `country`, SUM(`Total emissiones per country vs product`) FROM proyect_unit4.product_total_eu_emmision
GROUP BY `country`
ORDER BY SUM(`Total emissiones per country vs product`) DESC;

SELECT `country`, `Food product`, `Production Kg`, `World Emissions per kg`, `Total emissiones per country vs product`,
		AVG(`Total emissiones per country vs product`) OVER(partition by `Food product`)
FROM proyect_unit4.product_total_eu_emmision
order by `World Emissions per kg` DESC;

