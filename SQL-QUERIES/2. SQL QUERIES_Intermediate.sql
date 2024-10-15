-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category, SUM(od.quantity) AS Total_Qty
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
order by total_qty desc;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) as hour, COUNT(order_id) as order_count
FROM
    orders
GROUP BY HOUR(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS category_wise_pizza
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(pizzas_ordered), 0) AS Avg_per_day
FROM
    (SELECT 
        o.order_Date, SUM(od.quantity) AS pizzas_ordered
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_Date) AS order_qty;
 
 -- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    p.pizza_type_id, SUM(od.quantity * p.price) AS total_Rev
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.pizza_type_id
ORDER BY total_Rev DESC
LIMIT 3;