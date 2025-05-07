{{
  config(
    materialized='view'
  )
}}

WITH promitos AS (
    SELECT 
        PROMO_ID,
        DISCOUNT,
        STATUS,
        _FIVETRAN_DELETED,
        _FIVETRAN_SYNCED
    FROM {{ source('sql_server_dbo', 'promos') }}

    UNION ALL

    SELECT 
        'noparty' AS PROMO_ID,
        0 AS DISCOUNT,
        'inactive' AS STATUS,
        CAST(NULL AS BOOLEAN) AS _FIVETRAN_DELETED,  -- aseguras el tipo
        CURRENT_TIMESTAMP AS _FIVETRAN_SYNCED         -- o un valor similar
),

promos AS (
    SELECT 
        PROMO_ID,
        DISCOUNT,
        STATUS,
        _FIVETRAN_DELETED,
        _FIVETRAN_SYNCED
    FROM promitos
)

SELECT * FROM promos;


