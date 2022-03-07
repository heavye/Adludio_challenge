 {{ config(materialized='table') }}

with source_sales as (


    /*
   This model will address the first two tasks which are 
    Calculating 
    - Quarterly Avg Deal Value per week
    - Quarterly  Avg Emails per week

     The approach I took is first I grouped the data in weeks which are 53 weeks for all 2019 and 2020
     then finding the sum of those in each week.
     then I grouped the data quaretly to find the Quarterly Avg.
     Finally, I nested the sum values of the weeks in an average function to the Quarterly grouped
     To make it more readable I grouped in a yearly manner.
     It is implemented in a nested select statement as follows
     I took the advantage of EXTRACT Function to get quarters, years and weeks 
    */
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
                
                GROUP BY quarter, year, week
           
        ) as h
        
        GROUP BY year, quarter

        ORDER BY year, quarter
    ),

final as (
    select * from source_sales
)


select * from final