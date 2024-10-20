# AI-Powered Children's Book Platform

## Project Overview

This project demonstrates a robust data pipeline for an AI-powered children's book recommendation platform. It showcases various data engineering skills and best practices, integrating multiple technologies to create a scalable and efficient system.

## Technologies Used

- **PostgreSQL**: For primary data storage
- **dbt (data build tool)**: For data transformation and modeling
- **Apache Airflow**: For orchestrating the data pipeline
- **Flask**: For serving the API
- **Python**: Primary programming language used throughout the project

## Project Components

### 1. PostgreSQL Database

Our database schema includes the following main tables:
- `users`: Stores user information
- `orders`: Contains order details
- `book_popularity`: Derived table showing book popularity metrics
- `user_preferences`: Stores user book preferences
- `personalized_recommendations`: Holds personalized book recommendations for users

### 2. dbt Models

We use dbt for transforming raw data into analytics-ready models. Key models include:
- `user_reading_habits`: Analyzes user reading patterns
- `book_popularity`: Calculates popularity metrics for books
- `user_preferences`: Derives user preferences based on order history

### 3. Airflow DAG

Our Airflow DAG (`childrens_books_etl.py`) orchestrates the entire ETL process:
- Extracts data from the PostgreSQL database
- Triggers dbt runs to transform the data
- Loads transformed data back into the database
- Runs data quality checks

### 4. Flask API

The API serves book recommendations and user analytics. Key endpoints include:
- `/analyze_book/<book_title>`: Provides analysis for a specific book
- `/get_recommendations/<user_id>`: Retrieves personalized book recommendations for a user

## Setup Instructions

1. Clone the repository:
git clone [your-repo-url]
cd ai-powered-childrens-book-platform

2. Set up a virtual environment:
python3 -m venv venv_311
source venv_311/bin/activate

3. Install dependencies:
pip install -r requirements.txt

4. Set up PostgreSQL database:
- Install PostgreSQL
- Create a new database named `childrens_books`
- Run the SQL scripts in the `database_setup` folder to create the necessary tables

5. Configure dbt:
- Update `profiles.yml` with your database credentials
- Run `dbt deps` to install dependencies
- Run `dbt compile` to compile models

6. Configure Airflow:
- Set `AIRFLOW_HOME` environment variable
- Initialize the Airflow database: `airflow db init`
- Create an Airflow user: `airflow users create --username admin --password admin --firstname Admin --lastname User --role Admin --email admin@example.com`

7. Start the Flask API:

python app.py

## Usage

1. Start the Airflow webserver and scheduler:

airflow webserver --port 8080
airflow scheduler

2. Access the Airflow UI at `http://localhost:8080` and trigger the `childrens_books_etl` DAG.

3. Once the DAG has run successfully, you can use the Flask API to get book recommendations and analytics.

## Project Structure

ai-powered-childrens-book-platform/
│
├── dags/
│   └── childrens_books_etl.py
│
├── models/
│   ├── user_reading_habits.sql
│   ├── book_popularity.sql
│   ├── user_preferences.sql
│   └── sources.yml
│
├── app.py
├── book_analyzer.py
├── recommendation_model.py
├── requirements.txt
├── README.md
└── dbt_project.yml

## Skills Demonstrated

- Database Design and Management: Designing and managing PostgreSQL databases
- Data Modeling: Creating efficient data models with dbt
- ETL Pipeline Development: Building robust ETL pipelines with Airflow
- API Development: Creating RESTful APIs with Flask
- Data Analysis: Implementing data analysis techniques for book recommendations
- Python Programming: Utilizing Python for various aspects of the project
- Version Control: Using Git for version control
- Documentation: Creating comprehensive project documentation

## Future Enhancements

- Implement machine learning models for more advanced book recommendations
- Add real-time data processing capabilities
- Develop a front-end interface for easier interaction with the system
- Implement more advanced data quality checks and monitoring

## Contributing

[Instructions for how others can contribute to your project, if applicable]

## License

[Your chosen license, e.g., MIT License]

