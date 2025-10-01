# Pipeline: Airflow + dbt + Snowflake

## Overview
This project implements a modern data pipeline using:
- **Snowflake** as the cloud data warehouse  
- **Astro + Airflow** for orchestration  
- **dbt** for data transformation and modeling  
- **CSV datasets** as the raw data source  
---

## Project Structure

```plaintext
pipeline-airflow_dbt_snowflake-/
│
├── Snowflake_Scripts/
│   ├── create_warehouse_and_db.sql
│   ├── create_bronze_tables.sql
│   └── load_bronze_data.sql
│
├── dags/
│   ├── dbt_dag.py
│   ├── exampledag.py
│   ├── .airflowignore
│   └── logs/
│
├── datasets/
│   ├── CardBase.csv
│   ├── CustomerBase.csv
│   ├── FraudBase.csv
│   ├── TransactionBase.csv
│   └── placeholder/
│
├── include/
│   └── profiles.yml
│
├── dbt_project/
│   ├── macros/
│   │   ├── .gitkeep
│   │   └── generate_schema_name.sql
│   │
│   ├── snapshots/
│   │   ├── .gitkeep
│   │   ├── CardBase_snapshot.sql
│   │   ├── CustomerBase_snapshot.sql
│   │   ├── FraudBase_snapshots.sql
│   │   └── TransactionBase_snapshots.sql
│   │
│   └── models/
│
├── tests/dags/
├── logs/
├── .dockerignore
├── .gitignore
├── requirements.txt
├── LICENSE
└── README.md
```
## Data Flow

1. **Raw Data (CSV files)**  
   - Source data is collected in CSV format (`CardBase.csv`, `CustomerBase.csv`, `TransactionBase.csv`, `FraudBase.csv`).  
   - Files are stored in the `datasets/` folder.  

2. **Bronze Layer (Snowflake Stage & Tables)**  
   - A **Snowflake Stage** is created to load CSV files into the **bronze schema**.  
   - Data is ingested **as-is** from the CSVs into Snowflake tables:  
     - `bronze.CardBase`  
     - `bronze.CustomerBase`  
     - `bronze.TransactionBase`  
     - `bronze.FraudBase`  

3. **Silver Layer (dbt Transformations)**  
   - dbt models are built on top of bronze tables.  
   - Data cleaning and transformations are applied.  
   - **Incremental loading** is used → only **new data** is processed (avoiding duplication).  
   - Outputs are stored in the **silver schema**.  

4. **Gold Layer (dbt Modeling)**  
   - Final business models are created for analytics.  
   - **Fact and Dimension tables** are designed for reporting.  
   - Stored in the **gold schema** for BI tools and analysis.  

<img width="914" height="456" alt="Screenshot 2025-09-29 141530" src="https://github.com/user-attachments/assets/d8bca132-bf04-4048-b987-cd00d8b5df93" />

---
## Orchestration (Airflow)
- **Airflow DAGs** are defined in `/dags/`.  
- They handle the sequence:
  1. Load raw data into Bronze (Snowflake)  
  2. Run dbt models for Silver layer  
  3. Build Gold layer (fact & dimension tables)  

---

## 📬 Contact
- **Gmail**: drmohamedahmedb@gmail.com  
- **WhatsApp**: [+201127981884](https://wa.me/201127981884)  
- **LinkedIn**: [Ahmed Badawy](https://www.linkedin.com/in/ahmed-badawy-18275324b)  
- **GitHub**: [AhmedB5](https://github.com/AhmedB5)  





