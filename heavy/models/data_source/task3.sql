 {{ config(materialized='table') }}



with source_sales as (

    SELECT 

            year, quarter,
            
            AVG("sum_RFP") AS avg_value_per_quarter, 
            AVG("sum_Meet") AS avg_emails_per_quarter,
            AVG("sum_IO") AS avg_value_per_quarter

    FROM(
  
            SELECT  
                   (select count(*) from sales_table where "Deal_Stage" ='RFP') as RFPs,
                   (select count(*) from sales_table where "Deal_Stage" ='Meeting') as Meeting,
                   (select count(*) from sales_table where "Deal_Stage" ='IO Sent') as IO_Sent,

                   EXTRACT(week FROM CAST("Deal_created_at" AS DATE)) as week,
                   EXTRACT(quarter FROM CAST("Deal_created_at" AS DATE)) as quarter,
                   EXTRACT(year FROM CAST("Deal_created_at" AS DATE)) as year,

                   SUM('RFPs') AS sum_RFP,
                   SUM('Meeting') AS sum_Meet,
                   SUM('IO_Sent') AS sum_IO      
            FROM sales_table 
          ) as e
        
        GROUP BY year, quarter

        ORDER BY year, quarter
    ),

final as (
    select * from source_sales
)


select * from final


  
