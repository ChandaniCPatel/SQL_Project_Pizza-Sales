-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pt.category,
    ROUND(SUM(od.quantity * p.price) / (SELECT 
                    ROUND(SUM(od.quantity * p.price), 2) AS total_Sales
                FROM
                    order_details od
                        JOIN
                    pizzas p ON p.pizza_id = od.pizza_id) * 100,
            2) AS rev
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY rev DESC;

--  Analyze the cumulative revenue generated over time.
with cte as
(select o.ORDER_DATE, sum(od.quantity*p.price) as total_rev
 from order_details od
join orders o
on od.ORDER_id=o.ORDER_ID
join pizzas p
on p.pizza_id=od.pizza_id
group by o.ORDER_DATE)
select order_Date,  
round(sum(total_rev) over(order by order_date),2) as  cum_rev 
from cte;

-- Determine the top 3 most ordered pizza types based on revenue
-- for each pizza category.

select name, total_Rev
from
(with cte as
(SELECT 
    pt.category, pt.name, SUM(od.quantity * p.price) AS total_Rev
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
    join pizza_types pt
    on pt.pizza_type_id=p.pizza_type_id
GROUP BY pt.category, pt.name) 
select category, name, total_rev,
rank() over(partition by category order by total_rev desc) as top_orders
from cte) as cte2
where cte2.top_orders<=3;