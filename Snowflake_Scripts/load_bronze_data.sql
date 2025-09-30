-- LOAD DATA INTO BRONZE TABLES

COPY INTO bronze.CardBase
FROM @bronze.my_stage/CardBase.csv
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1);

COPY INTO bronze.CustomerBase
FROM @bronze.my_stage/CustomerBase.csv
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1);

COPY INTO bronze.TransactionBase
FROM @bronze.my_stage/TransactionBase.csv
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1);

COPY INTO bronze.FraudBase
FROM @bronze.my_stage/FraudBase.csv
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1);

