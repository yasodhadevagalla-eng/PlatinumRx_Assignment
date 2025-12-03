1.SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021   -- given year
GROUP BY sales_channel; 
2.SELECT 
    c.uid,
    cu.name,
    SUM(c.amount) AS total_spent
FROM clinic_sales c
JOIN customer cu ON cu.uid = c.uid
WHERE YEAR(c.datetime) = 2021
GROUP BY c.uid, cu.name
ORDER BY total_spent DESC
LIMIT 10;
