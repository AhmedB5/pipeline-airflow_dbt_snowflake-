from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail 

# Connection Settings
# Put your SendGrid key
SEND_GRID  = "**********************************************************"
FROM_EMAIL = "airflowahmed@gmail.com"
TO_EMAIL   = "drmohamedahmedb@gmail.com"

def send_email(**context):
    failed_task = context['task_instance'].task_id 
    html_content = f"<p>Task: {failed_task} has failed</p>"
    
    sg = SendGridAPIClient(api_key=SEND_GRID)
    email = Mail(
        from_email=FROM_EMAIL,
        to_emails=TO_EMAIL,
        subject=f"Task Failed: {failed_task}", 
        html_content=html_content
    )
    sg.send(email)
    
# DAG
with DAG(
    dag_id='pipeline',
    start_date=datetime(2025, 9, 28, 0, 0),
    schedule='0 */24 * * *',
    catchup=False
) as dag:
            
    # snapshot
    snapshot = BashOperator(
        task_id="snapshot", 
        bash_command="dbt snapshot --project-dir /usr/local/airflow/dbt_project --profiles-dir /usr/local/airflow/include",
        retries=2,
        retry_delay=timedelta(minutes=30),
        execution_timeout=timedelta(minutes=5)
    )

    # run silver layer
    silver = BashOperator(
        task_id="silver", 
        bash_command="dbt run --project-dir /usr/local/airflow/dbt_project --profiles-dir /usr/local/airflow/include --select models/silver",
        retries=0, 
        retry_delay=timedelta(minutes=30),
        execution_timeout=timedelta(minutes=5)
    )

    # run gold layer 
    gold = BashOperator(
        task_id="gold", 
        bash_command="dbt run --project-dir /usr/local/airflow/dbt_project --profiles-dir /usr/local/airflow/include --select models/gold",
        retries=0, 
        retry_delay=timedelta(minutes=30),
        execution_timeout=timedelta(minutes=5)
    )

    # notify_failure
    notify_failure = PythonOperator(
        task_id="notify_failure",
        python_callable=send_email,
        trigger_rule="one_failed", 
        retries=0, 
        retry_delay=timedelta(minutes=30),
        execution_timeout=timedelta(minutes=1)
    )

    silver >> gold
    snapshot 
    [snapshot, silver, gold] >> notify_failure

