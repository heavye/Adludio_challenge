{{ config(materialized='table') }}

with source_sales as (

        
    SELECT 
        DATE_PART('week', CAST("Deal_created_at" AS DATE)) as week,
        DATE_PART('year', CAST("Deal_created_at" AS DATE)) as year,
        DATE_PART('month', CAST("Deal_created_at" AS DATE)) as month,

        COUNT("Deal_created_at") as No_of_deal_created,

        SUM("Deal_Value") AS sum_value_per_week, 
        SUM("Deal_Email_messages_count") AS sum_emails_per_week  
    
    FROM {{ source("adludio", "sales_table") }}
    
    GROUP BY year , month, week
             

    ORDER BY week
    ),

final as (
    select * from source_sales
)


select * from final


  