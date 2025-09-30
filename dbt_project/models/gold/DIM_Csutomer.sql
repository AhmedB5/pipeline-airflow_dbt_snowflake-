{{ config ( 
    materialized='view', schema = 'gold'
    )}}
select 
Cust_ID , 
Age , 
Cust_Segment ,
Cust_Vintage_Group
from {{ ref("customer_base")}}