{{ config(
    materialized='table'
) }}
{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}


SELECT
    id_ciudad as id_sucursal,
    nombre,
    ciudad,
    direccion,
    telefono
FROM {{ ref('stg_concesionario__sucursales') }}
