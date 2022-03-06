{{ config(materialized='table') }}

with source_sales as (

        
    SELECT AVG("Deal_Value") AS avg_value_perweek FROM {{ source("adludio", "sales_table") }}
    
               GROUP BY DATE_PART('week', CAST("Deal_created_at" AS DATE))
    ),

final as (
    select * from source_sales
)


select * from final


  