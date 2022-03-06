{{ config(materialized='table') }}

with source_sales as (
        select "Deal_Value" as k  from {{ source("adludio", "sales_table") }}
    
        WHERE "Deal_created_at" LIKE '%2019%'
    ),

final as (
    select * from source_sales
)


select * from final
    

