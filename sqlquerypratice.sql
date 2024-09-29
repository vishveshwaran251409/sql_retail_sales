select * from pizza_sales;
use [pizza DB]

--kpi's
--find out total revenue
select sum(total_price) as TOTAL_REVENUE from pizza_sales

--average order values
select sum(total_price) / count(distinct order_id) as AVG_ORDER_VALUE from pizza_sales

--total pizza's sold
select sum(quantity) as TOTAL_PIZZASOLD from pizza_sales

--total orders
select count(distinct order_id ) as TOTAL_ORDERS from pizza_sales

--average pizza's per order
select cast( cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id ) as decimal(10,2)) as decimal(10 as AVERAGE_PIZZAS_PERORDER from pizza_sales

--chart's
--daily trend for total orders
select datename(dw,order_date) as ORDER_DAY , count(distinct order_id ) as TOTAL_ORDER from pizza_sales group by datename(dw,order_date)

--Hourly trend
select datepart(hour,order_time) as ORDER_HOUR , count( distinct order_id) as TOTAL__ORDERS from pizza_sales group  by  datepart(hour,order_time) order by  datepart(hour,order_time)

--percentage of sales by pizza category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--NOTE (month wise)
select pizza_category , sum(total_price) as TOTAL_SALES ,sum(total_price) * 100 / (select sum(total_price) from pizza_sales where MONTH(order_date) = 1) as PCT  from pizza_sales where month(order_date) = 1 group by pizza_category 

--percentage of sales by pizza size
select pizza_size , cast(sum(total_price) as decimal(10,2)) as total_revenue , cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal (10,2)) as pct from pizza_sales group by pizza_size order by pct desc

--total pizza sold by pizza category
select pizza_category , sum( quantity) as TOTAL_PIZZAS_SOLD from pizza_sales group by pizza_category

--top 5 best sellers by total pizzas sold
select top 5 pizza_name ,sum(quantity) as total_pizzas_sold from pizza_sales group by pizza_name order by sum(quantity) desc

--top 5 worst sellers by total_pizzas sold
select top 5 pizza_name ,sum(quantity) as total_pizzas_sold from pizza_sales group by pizza_name order by sum(quantity) asc
