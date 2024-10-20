

WITH user_order_counts AS (
    SELECT 
        user_id,
        COUNT(*) as total_orders,
        COUNT(DISTINCT book_title) as unique_books_ordered,
        MIN(order_date) as first_order_date,
        MAX(order_date) as last_order_date,
        SUM(total_amount) as total_spent
    FROM "childrens_books"."public"."orders"
    GROUP BY user_id
)

SELECT
    uoc.user_id,
    u.email,
    uoc.total_orders,
    uoc.unique_books_ordered,
    uoc.total_spent,
    uoc.total_orders::float / NULLIF(DATE_PART('day', uoc.last_order_date - uoc.first_order_date), 0) as orders_per_day,
    uoc.unique_books_ordered::float / NULLIF(uoc.total_orders, 0) as unique_book_ratio,
    uoc.total_spent / NULLIF(uoc.total_orders, 0) as average_order_value,
    u.created_at,
    u.last_login
FROM user_order_counts uoc
JOIN "childrens_books"."public"."users" u ON uoc.user_id = u.user_id