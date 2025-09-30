{{ config ( 
    materialized='incremental', schema = 'silver'
    )}}

    select 
    trim(Transaction_ID) as Transaction_ID , 
     Fraud_Flag 
    from {{ source('C_CardDB','FraudBase') }} 
where 1=1
{% if is_incremental() %}
and trim(Transaction_ID) not in (select Transaction_ID  from {{this}} )
{% endif %}
