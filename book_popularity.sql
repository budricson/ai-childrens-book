

WITH book_stats AS (
  SELECT 
      book_title,
      COUNT(*) as number_of_orders,
      SUM(total_amount) as total_revenue,
      AVG(total_amount) as average_price,
      MIN(order_date) as first_order_date,
      MAX(order_date) as last_order_date,
      COUNT(DISTINCT user_id) as unique_customers
  FROM "childrens_books"."public"."orders"
  GROUP BY book_title
)
SELECT 
    *,
    total_revenue / NULLIF(number_of_orders, 0) as average_revenue_per_order,
    DATE_PART('day', last_order_date - first_order_date) as days_between_first_and_last_order
FROM book_stats
ORDER BY number_of_orders DESC