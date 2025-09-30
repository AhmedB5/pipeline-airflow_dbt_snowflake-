{% snapshot FraudBase_snapshot %}
{{
    config(
        target_schema='bronze',
        unique_key='Transaction_ID',
        strategy='check',
        check_cols='all'
    )
}}

select
    *,
    current_timestamp() as changed_at
from {{ source('C_CardDB', 'FraudBase') }}

{% endsnapshot %}
