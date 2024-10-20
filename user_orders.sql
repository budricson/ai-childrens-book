

WITH user_order_stats AS (
  SELECT
    u.user_id,
    u.email,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
  FROM "childrens_books"."public"."users" u
  LEFT JOIN "childrens_books"."public"."orders" o ON u.user_id = o.user_id
  GROUP BY u.user_id, u.email
)

SELECT *
FROM user_order_stats