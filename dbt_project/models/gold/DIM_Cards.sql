{{ config ( 
    materialized='view', schema = 'gold'
    )}}
select 
card_number ,
card_family ,
credit_limit
from {{ ref("card_base")}}