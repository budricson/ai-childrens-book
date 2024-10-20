

WITH user_book_stats AS (
    SELECT 
        user_id,
        book_title,
        COUNT(*) as book_count,
        SUM(total_amount) as total_spent,
        AVG(total_amount) as avg_spent_per_book
    FROM "childrens_books"."public"."orders"
    GROUP BY user_id, book_title
),
ranked_books AS (
    SELECT 
        user_id,
        book_title,
        book_count,
        total_spent,
        avg_spent_per_book,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY book_count DESC, total_spent DESC) as book_rank
    FROM user_book_stats
)
SELECT 
    rb.user_id,
    rb.book_title as favorite_book,
    rb.book_count as favorite_book_count,
    rb.total_spent as favorite_book_total_spent,
    rb.avg_spent_per_book as favorite_book_avg_spent
FROM ranked_books rb
WHERE rb.book_rank = 1