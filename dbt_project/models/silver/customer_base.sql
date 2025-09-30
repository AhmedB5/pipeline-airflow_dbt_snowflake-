{{ config ( 
    materialized='incremental', schema = 'silver'
    )}}

select
trim(Cust_ID) as Cust_ID,
cast(Age as integer) as Age, 
upper(trim(Customer_Segment)) as Cust_Segment,
trim(Customer_Vintage_Group) as Cust_Vintage_Group
from {{ source('C_CardDB' , 'CustomerBase') }} 
where Age between 19 and 100
and upper(trim(Customer_Segment)) in ('DIAMOND','GOLD','PLATINUM')

{% if is_incremental()%}
and cust_ID not in (select cust_ID from {{ this }})
{% endif %}