with source_sale as (
    select * from {{ source("adludio", "sales_table") }}
),

final as (
    select * from source_sale
)

select * from final