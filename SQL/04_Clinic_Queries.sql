-- Q1: Revenue by sales channel
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

-- Q2: Top 10 most valuable customers
SELECT uid, SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- Q3: Month-wise revenue, expense, profit, status
SELECT t.month, t.revenue, e.expense, (t.revenue - e.expense) AS profit,
       CASE WHEN (t.revenue - e.expense) >=0 THEN 'Profitable' ELSE 'Not-Profitable' END AS status
FROM
    (SELECT MONTH(datetime) AS month, SUM(amount) AS revenue
     FROM clinic_sales
     WHERE YEAR(datetime) = 2021
     GROUP BY MONTH(datetime)) t
JOIN
    (SELECT MONTH(datetime) AS month, SUM(amount) AS expense
     FROM expenses
     WHERE YEAR(datetime) = 2021
     GROUP BY MONTH(datetime)) e
ON t.month = e.month;

-- Q4: Most profitable clinic per city (example: September)
SELECT city, cid, MAX(profit) AS max_profit
FROM (
    SELECT c.city, cs.cid, SUM(cs.amount) - SUM(e.amount) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
    GROUP BY c.city, cs.cid
) t
GROUP BY city;

-- Q5: Second least profitable clinic per state
SELECT state, cid, profit
FROM (
    SELECT c.state, cs.cid, SUM(cs.amount) - SUM(e.amount) AS profit,
           DENSE_RANK() OVER(PARTITION BY c.state ORDER BY SUM(cs.amount) - SUM(e.amount) ASC) AS rnk
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
    GROUP BY c.state, cs.cid
) t
WHERE rnk = 2;