-- BASIC
-- 1 Retrieve the total number of orders placed.

SELECT 
    COUNT(*) AS Total_no_of_orders
FROM
    orders;

-- 2 Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;

-- 3 Identify the highest-priced pizza.
SELECT 
    pt.Name, p.price
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- 4 Identify the most common pizza size ordered.
SELECT 
    size, COUNT(order_details_id) AS most_common_pizza_ordered
FROM
    pizzas p
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY size
ORDER BY COUNT(od.order_details_id) DESC
LIMIT 1;

-- 5 List the top 5 most ordered pizza types along with their quantities.
SELECT 
    p.pizza_type_id, SUM(od.quantity) AS most_common_pizza_type
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.pizza_type_id
ORDER BY COUNT(od.quantity) DESC
LIMIT 5;