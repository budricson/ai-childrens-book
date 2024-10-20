from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'childrens_books_etl',
    default_args=default_args,
    description='ETL process for children\'s books platform',
    schedule_interval=timedelta(days=1),
)

# Define your tasks here

# Example task:
# task = BashOperator(
#     task_id='print_date',
#     bash_command='date',
#     dag=dag,
# )
