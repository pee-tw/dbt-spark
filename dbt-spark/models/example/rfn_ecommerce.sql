
-- Use the `ref` function to select from other models

select * from {{ source('default', 'ecommerce') }}
