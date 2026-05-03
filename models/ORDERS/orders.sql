
{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    INITCAP(customer_name) AS customer_name,
    order_date,
    product_name,
    quantity,
    unit_price,
    quantity * unit_price AS calculated_total_amount,
    total_amount AS original_total_amount,

    CASE
        WHEN quantity * unit_price = total_amount THEN 'MATCHED'
        ELSE 'MISMATCHED'
    END AS amount_validation_status,

    UPPER(order_status) AS order_status,
    payment_method,
    shipping_city,
    shipping_state,

    CURRENT_TIMESTAMP() AS dbt_loaded_at

FROM DBT_CLOUD.RAW_DATA.ORDERS