

WITH user_book_counts AS (
    SELECT 
        user_id,
        book_title,
        COUNT(*) as book_count
    FROM "childrens_books"."public"."orders"
    GROUP BY user_id, book_title
),
user_book_ranks AS (
    SELECT 
        user_id,
        book_title,
        book_count,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY book_count DESC) as rank
    FROM user_book_counts
)
SELECT 
    user_id,
    book_title as recommended_book,
    book_count as recommendation_strength
FROM user_book_ranks
WHERE rank <= 5
ORDER BY user_id, rank