{{ config(
    materialized='table'
) }}
{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}

with clientes as (

    select
        id_cliente,
        nombre_completo,
        email,
        telefono,
        fecha_registro,
        ciudad

    from {{ ref('stg_concesionario__clientes') }}

)

select * from clientes