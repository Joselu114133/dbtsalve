{{
  config(
    materialized='view',
    enabled=false
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
        CAST(NULL AS BOOLEAN) AS _FIVETRAN_DELETED,
        CURRENT_TIMESTAMP AS _FIVETRAN_SYNCED
),

promos AS (
    SELECT 
        {{ dbt_utils.surrogate_key(['promo_id']) }} AS promo_id,  -- surrogate key
        PROMO_ID AS promo_desc,
        DISCOUNT,
        STATUS,
        _FIVETRAN_DELETED,
        _FIVETRAN_SYNCED
    FROM promitos
)

SELECT * FROM promos
