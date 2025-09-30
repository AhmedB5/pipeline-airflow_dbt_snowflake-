{% snapshot CardBase_snapshot %}
{{
    config(
        target_schema='bronze',
        unique_key='Card_Number',
        strategy='check',
        check_cols='all'
    )
}}

select
    *,
    current_timestamp() as changed_at
from {{ source('C_CardDB', 'CardBase') }}

{% endsnapshot %}
