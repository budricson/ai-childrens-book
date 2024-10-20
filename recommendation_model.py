import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

def create_user_item_matrix(user_book_ratings):
    users = list(set(rating[0] for rating in user_book_ratings))
    books = list(set(rating[1] for rating in user_book_ratings))
    
    user_book_matrix = np.zeros((len(users), len(books)))
    
    for user, book, rating in user_book_ratings:
        user_index = users.index(user)
        book_index = books.index(book)
        user_book_matrix[user_index][book_index] = rating
    
    return user_book_matrix, users, books

def get_recommendations(user_id, user_book_matrix, users, books, n=5):
    user_index = users.index(user_id)
    user_ratings = user_book_matrix[user_index]
    
    similarities = cosine_similarity([user_ratings], user_book_matrix)[0]
    similar_users = similarities.argsort()[::-1][1:6]  # top 5 similar users
    
    recommendations = {}
    for similar_user in similar_users:
        for book_index, rating in enumerate(user_book_matrix[similar_user]):
            if rating > 0 and user_ratings[book_index] == 0:
                if books[book_index] not in recommendations:
                    recommendations[books[book_index]] = rating
    
    return sorted(recommendations.items(), key=lambda x: x[1], reverse=True)[:n]

# Example usage
user_book_ratings = [
    ('U001', 'Book A', 5),
    ('U001', 'Book B', 3),
    ('U002', 'Book A', 4),
    ('U002', 'Book C', 5),
    ('U003', 'Book B', 4),
    ('U003', 'Book C', 3)
]

matrix, users, books = create_user_item_matrix(user_book_ratings)
print(get_recommendations('U001', matrix, users, books))