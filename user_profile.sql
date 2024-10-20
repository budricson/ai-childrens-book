

WITH top_recommendation AS (
    SELECT 
        user_id,
        recommended_book,
        recommendation_strength,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY recommendation_strength DESC) as rank
    FROM "childrens_books"."public"."book_recommendations"
)
SELECT 
    up.user_id,
    up.favorite_book,
    up.favorite_book_count,
    up.favorite_book_total_spent,
    up.favorite_book_avg_spent,
    tr.recommended_book as top_recommendation,
    tr.recommendation_strength
FROM "childrens_books"."public"."user_preferences" up
LEFT JOIN top_recommendation tr
    ON up.user_id = tr.user_id
    AND tr.rank = 1  -- This gets the top recommendation for each user