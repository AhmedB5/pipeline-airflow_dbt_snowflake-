{{ config ( 
    materialized='view', schema = 'gold'
)}}

select  
    t.Transaction_ID , 
    t.Transaction_Date ,
    t.Credit_Card_ID ,
    t.Transaction_Value ,
    t.Transaction_Segment ,
    coalesce(f.Fraud_Flag, 0) as Fraud_Flag
from {{ ref("Transaction_Base") }} as t
left join {{ ref("fraud_base") }} as f
    on t.Transaction_ID = f.Transaction_ID
