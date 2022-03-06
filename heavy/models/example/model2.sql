
-- Use the `ref` function to select from other models

select *
from {{ ref('model1') }}
where id = 1
