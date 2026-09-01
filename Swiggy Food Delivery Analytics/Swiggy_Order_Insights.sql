CREATE TABLE swiggy_orders (
    state VARCHAR(100),
    city VARCHAR(100),
    order_date DATE,
    day_name VARCHAR(20),
    quarter_name VARCHAR(10),
    week INT,
    restaurant_name VARCHAR(200),
    location VARCHAR(200),
    category VARCHAR(200),
    dish_name VARCHAR(300),
    food_type VARCHAR(20),
    price_inr NUMERIC,
    rating NUMERIC,
    rating_count NUMERIC
);

SELECT COUNT(*) AS total_rows FROM swiggy_orders;

--Total Orders
SELECT COUNT(*) AS total_orders
FROM swiggy_orders;

--Total revenue
SELECT SUM(price_inr) AS total_revenue
FROM swiggy_orders;

--Average rating
SELECT AVG(rating) AS avg_rating,
       MIN(rating) AS min_rating,
       MAX(rating) AS max_rating
FROM swiggy_orders;

--Rating distribution
SELECT rating, COUNT(*) AS count
FROM swiggy_orders
GROUP BY rating
ORDER BY rating DESC;

--Most ordered items
SELECT dish_name, COUNT(*) AS order_count
FROM swiggy_orders
GROUP BY dish_name
ORDER BY order_count DESC
LIMIT 10;

--Top 5 restaurants by revenue
SELECT restaurant_name, SUM(price_inr) AS total_revenue
FROM swiggy_orders
GROUP BY restaurant_name
ORDER BY total_revenue DESC
LIMIT 5;

--Top 5 restaurants by order volume
SELECT restaurant_name, COUNT(*) AS order_count
FROM swiggy_orders
GROUP BY restaurant_name
ORDER BY order_count DESC
LIMIT 5;

--Monthly ordering trends
SELECT DATE_TRUNC('month', order_date) AS month, COUNT(*) AS orders
FROM swiggy_orders
GROUP BY month
ORDER BY month;

--Revenue by city
SELECT city, SUM(price_inr) AS city_revenue
FROM swiggy_orders
GROUP BY city
ORDER BY city_revenue DESC;

--Customer satisfaction metrics
SELECT ROUND(
  100.0 * SUM(CASE WHEN rating >= 4 THEN 1 ELSE 0 END) / COUNT(*)
  , 2) AS pct_high_rating
FROM swiggy_orders;

--Top rated restaurants where order is greater than 20
SELECT restaurant_name, AVG(rating) AS avg_rating, COUNT(*) AS reviews
FROM swiggy_orders
GROUP BY restaurant_name
HAVING COUNT(*) >= 20
ORDER BY avg_rating DESC
LIMIT 5;

--Highest average order value (AOV) by city
SELECT city,
       ROUND(AVG(price_inr), 2) AS avg_order_value
FROM swiggy_orders
GROUP BY city
ORDER BY avg_order_value DESC;

--Lowest-rated restaurants (min 30 reviews)
SELECT restaurant_name,
       ROUND(AVG(rating),2) AS avg_rating,
       COUNT(*) AS total_orders
FROM swiggy_orders
GROUP BY restaurant_name
HAVING COUNT(*) >= 30
ORDER BY avg_rating ASC
LIMIT 10;

--Revenue by food category
SELECT category, SUM(price_inr) AS total_revenue
FROM swiggy_orders
GROUP BY category
ORDER BY total_revenue DESC;

--Number of Veg vs Non-Veg split
SELECT food_type, COUNT(*) AS orders
FROM swiggy_orders
GROUP BY food_type;

--Highest-rated food categories
SELECT category, ROUND(AVG(rating),2) AS avg_rating
FROM swiggy_orders
GROUP BY category
ORDER BY avg_rating DESC;

--Orders by day of week
SELECT day, COUNT(*) AS orders
FROM swiggy_orders
GROUP BY day
ORDER BY orders DESC;

--Revenue by month
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(price_inr) AS total_revenue
FROM swiggy_orders
GROUP BY month
ORDER BY month;

--Weekly ordering trend
SELECT week, COUNT(*) AS weekly_orders
FROM swiggy_orders
GROUP BY week
ORDER BY week;

--Count of ratings (1–5 stars)
SELECT rating, COUNT(*) AS rating_count
FROM swiggy_orders
GROUP BY rating
ORDER BY rating DESC;

--Percentage of high-rated orders
SELECT ROUND(
    100.0 * SUM(CASE WHEN rating >= 4 THEN 1 ELSE 0 END) / COUNT(*),
    2
) AS pct_high_rating
FROM swiggy_orders;

--Average spending by food type
SELECT food_type, ROUND(AVG(price_inr),2) AS avg_spend
FROM swiggy_orders
GROUP BY food_type;

--Most expensive categories
SELECT category,
       ROUND(AVG(price_inr),2) AS avg_price
FROM swiggy_orders
GROUP BY category
ORDER BY avg_price DESC;

--High-value orders (greater than 500)
SELECT *
FROM swiggy_orders
WHERE price_inr > 500
ORDER BY price_inr DESC;

--Repeatability Indicator (Do cheap dishes repeat?)
SELECT dish_name,
       ROUND(AVG(price_inr),2) AS avg_price,
       COUNT(*) AS order_freq
FROM swiggy_orders
GROUP BY dish_name
HAVING COUNT(*) > 10
ORDER BY order_freq DESC, avg_price;

--Price sensitivity per city
SELECT city,
       ROUND(AVG(price_inr),2) AS avg_price,
       MIN(price_inr) AS min_price,
       MAX(price_inr) AS max_price
FROM swiggy_orders
GROUP BY city
ORDER BY avg_price;

--Category contribution to revenue
SELECT category,
       ROUND(100.0 * SUM(price_inr) / (SELECT SUM(price_inr) FROM swiggy_orders), 2)
       AS revenue_percentage
FROM swiggy_orders
GROUP BY category
ORDER BY revenue_percentage DESC;

--Avg price vs Avg rating (Customer Happiness Curve)
SELECT category,
       ROUND(AVG(price_inr),2) AS avg_price,
       ROUND(AVG(rating),2) AS avg_rating
FROM swiggy_orders
GROUP BY category
ORDER BY avg_rating DESC;

--Revenue concentration (Pareto 80/20 Rule)
SELECT restaurant_name, SUM(price_inr) AS revenue
FROM swiggy_orders
GROUP BY restaurant_name
ORDER BY revenue DESC
LIMIT (SELECT COUNT(*) * 0.2 FROM swiggy_orders);

--Is higher price leading to better rating?
SELECT
    CASE WHEN price_inr < 200 THEN 'Low Price'
         WHEN price_inr BETWEEN 200 AND 400 THEN 'Medium Price'
         ELSE 'High Price' END AS price_band,
    ROUND(AVG(rating), 2) AS avg_rating
FROM swiggy_orders
GROUP BY price_band
ORDER BY avg_rating DESC;










