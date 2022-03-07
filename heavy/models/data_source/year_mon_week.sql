 {{ config(materialized='table') }}

with source_sales as (

       
        SELECT 

            year, quarter,
            
            AVG("sum_value_per_week") AS avg_value_per_quarter, 
            AVG("sum_email_per_week") AS avg_emails_per_quarter  

        FROM (
                SELECT                
                EXTRACT(week FROM CAST("Deal_created_at" AS DATE)) as week,
                EXTRACT(quarter FROM CAST("Deal_created_at" AS DATE)) as quarter,
                EXTRACT(year FROM CAST("Deal_created_at" AS DATE)) as year,
            
                SUM("Deal_Value") AS sum_value_per_week,
                SUM("Deal_Email_messages_count") AS sum_email_per_week

                FROM sales_table 
            group by quarter, year, week
            ) as h
        
        GROUP BY year, quarter

        ORDER BY year, quarter
    ),

final as (
    select * from source_sales
)


select * from final


  
