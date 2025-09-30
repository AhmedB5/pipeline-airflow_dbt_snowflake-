{{ config ( 
    materialized='incremental', schema = 'silver'
    )}}

select  
trim(Transaction_ID) as Transaction_ID,
cast(Transaction_Date as date) as Transaction_Date ,
trim(Credit_Card_ID) as Credit_Card_ID,
cast(Transaction_Value as integer) as Transaction_Value,
trim(Transaction_Segment) as Transaction_Segment

from {{ source('C_CardDB' ,'TransactionBase') }}

where regexp_like(trim(Credit_Card_ID), '^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$')

{% if is_incremental() %}
and Transaction_ID not in (select Transaction_ID from {{ this }}  )
{% endif %}


