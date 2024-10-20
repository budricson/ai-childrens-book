import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from collections import Counter

nltk.download('punkt')
nltk.download('stopwords')

def analyze_book_content(content):
    # Tokenize the content
    tokens = word_tokenize(content.lower())
    
    # Remove stopwords
    stop_words = set(stopwords.words('english'))
    filtered_tokens = [word for word in tokens if word.isalnum() and word not in stop_words]
    
    # Get the most common words
    word_freq = Counter(filtered_tokens)
    most_common = word_freq.most_common(10)
    
    return most_common

# Example usage
book_content = "Once upon a time, in a magical forest, there lived a curious little rabbit..."
print(analyze_book_content(book_content))