{{ config(materialized='table') }}

with source_sales as (

        
    SELECT 
        DATE_PART('week', CAST("Deal_created_at" AS DATE)) as week,
       
        COUNT(DATE_PART('week', CAST("Deal_created_at" AS DATE))) as weekcount,

        SUM("Deal_Value") AS sum_value_per_week, 
        SUM("Deal_Email_messages_count") AS sum_emails_per_week  
    
    FROM {{ source("adludio", "sales_table") }}
    
    GROUP BY week
             

    ORDER BY week
    ),

final as (
    select * from source_sales
)


select * from final


  