{{ config(  materialized='incremental', schema = 'silver') }}

select 
    trim(card_number) as card_number,
    trim(card_family) as card_family,
    cast(credit_limit as integer) as credit_limit,
    trim(cust_ID) as cust_id
from {{ source('C_CardDB', 'CardBase') }}
where 1=1
and regexp_like(trim(card_number), '^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$')
and trim(card_family) in ('Premium','Platinum','Gold')

{% if is_incremental() %}
and card_number not in (select card_number from {{ this }})
{% endif %}
