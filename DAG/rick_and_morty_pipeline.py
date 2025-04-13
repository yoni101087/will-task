from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
import requests
import psycopg2
import logging
import os

# DB connection variables (best to move to Airflow Variables or Secrets Manager later)
DB_HOST = "education.cxamz4c5t7dy.us-west-2.rds.amazonaws.com"
DB_NAME = "dummydb"
DB_USER = "super"
DB_PASS = "ChangeMe123!"

API_URL = "http://your-api-loadbalancer-url/characters"

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=2)
}

def fetch_and_insert_characters():
    response = requests.get(API_URL)
    response.raise_for_status()

    characters = response.json()

    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )

    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE IF NOT EXISTS rick_and_morty_characters (
            name TEXT,
            location TEXT,
            image TEXT
        )
    """)

    for char in characters:
        cur.execute("""
            INSERT INTO rick_and_morty_characters (name, location, image)
            VALUES (%s, %s, %s)
        """, (char["name"], char["location"]["name"], char["image"]))

    conn.commit()
    cur.close()
    conn.close()
    logging.info(f"Inserted {len(characters)} characters into RDS")

with DAG(
    dag_id="rick_and_morty_pipeline",
    default_args=default_args,
    start_date=datetime(2024, 1, 1),
    schedule_interval="*/5 * * * *",
    catchup=False
) as dag:

    ingest_characters = PythonOperator(
        task_id="fetch_and_insert_characters",
        python_callable=fetch_and_insert_characters
    )
