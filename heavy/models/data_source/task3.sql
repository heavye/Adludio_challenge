 {{ config(materialized='table') }}



with source_sales as (

    SELECT 

            year, quarter,
                   SUM('RFPs') AS sum_RFP,
                   SUM('Meeting') AS sum_Meet,
                   SUM('IO_Sent') AS sum_IO      
            
            

    FROM(
  
            SELECT  
                   (select count(distinct "Deal_Stage") from sales_table where "Deal_Stage" ='RFP') as RFPs,
                   (select count(distinct "Deal_Stage") from sales_table where "Deal_Stage" ='Meeting') as Meeting,
                   (select count(distinct "Deal_Stage") from sales_table where "Deal_Stage" ='IO Sent') as IO_Sent,

                   EXTRACT(week FROM CAST("Deal_created_at" AS DATE)) as week,
                   EXTRACT(quarter FROM CAST("Deal_created_at" AS DATE)) as quarter,
                   EXTRACT(year FROM CAST("Deal_created_at" AS DATE)) as year

                   
            FROM sales_table 
            GROUP BY year, quarter,week
          ) as e
        
        GROUP BY year, quarter,sum_RFP, sum_Meet, sum_IO

        ORDER BY year, quarter
    ),

final as (
    select * from source_sales
)


select * from final


  
