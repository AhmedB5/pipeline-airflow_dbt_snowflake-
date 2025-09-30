-- CREATE BRONZE TABLES

CREATE OR REPLACE TABLE bronze.CardBase(
    Card_Number VARCHAR,
    Card_Family VARCHAR, 
    Credit_limit INTEGER,
    Cust_ID VARCHAR
); 

CREATE OR REPLACE TABLE bronze.CustomerBase(
    Cust_ID VARCHAR,
    Age INTEGER, 
    Customer_Segment VARCHAR,
    Customer_Vintage_Group VARCHAR
);

CREATE OR REPLACE TABLE bronze.TransactionBase(
    Transaction_ID VARCHAR, 
    Transaction_Date DATE,
    Credit_Card_ID VARCHAR, 
    Transaction_Value INTEGER,
    Transaction_Segment VARCHAR
);

CREATE OR REPLACE TABLE bronze.FraudBase(
    Transaction_ID VARCHAR, 
    Fraud_Flag INTEGER
);

