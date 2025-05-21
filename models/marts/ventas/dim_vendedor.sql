{{ config(
    materialized='table'
) }}
{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}

SELECT
    id_vendedor,
    nombre,
    antiguedad_meses,
   
FROM {{ ref('stg_concesionario__vendedores') }}
