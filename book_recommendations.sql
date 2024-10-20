

WITH user_purchase_history AS (
    -- Critical: This CTE establishes the user's purchase history
    -- Removing or altering this would break the recommendation logic
    SELECT 
        user_id,
        book_title,
        COUNT(*) as purchase_count
    FROM "childrens_books"."public"."orders"
    GROUP BY user_id, book_title
),

book_similarity AS (
    -- Critical: This CTE calculates book similarity based on co-purchases
    -- Altering this would significantly change recommendation results
    SELECT 
        a.book_title as book_a,
        b.book_title as book_b,
        COUNT(DISTINCT a.user_id) as co_purchases
    FROM "childrens_books"."public"."orders" a
    JOIN "childrens_books"."public"."orders" b ON a.user_id = b.user_id AND a.book_title < b.book_title
    GROUP BY a.book_title, b.book_title
),

user_recommendations AS (
    -- Critical: This section generates the actual recommendations
    -- Modifying this would directly affect the recommendation output
    SELECT 
        uph.user_id,
        bs.book_b as recommended_book,
        SUM(uph.purchase_count * bs.co_purchases) as recommendation_strength,
        ROW_NUMBER() OVER (PARTITION BY uph.user_id ORDER BY SUM(uph.purchase_count * bs.co_purchases) DESC) as rank
    FROM user_purchase_history uph
    JOIN book_similarity bs ON uph.book_title = bs.book_a
    WHERE bs.book_b NOT IN (SELECT book_title FROM user_purchase_history WHERE user_id = uph.user_id)
    GROUP BY uph.user_id, bs.book_b
)

SELECT 
    user_id,
    recommended_book,
    recommendation_strength
FROM user_recommendations
WHERE rank <= 5  -- Limiting to top 5 recommendations per user
ORDER BY user_id, recommendation_strength DESC