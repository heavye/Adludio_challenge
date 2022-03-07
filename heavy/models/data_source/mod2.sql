
{{ config(materialized='table') }}

select *
from {{ ref('year_mon_week') }}
