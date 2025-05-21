
{{ config(materialized='table') }}
{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}

SELECT
    id_venta,        
    id_cliente,     
    id_vehiculo,     
    id_vendedor,     
    id_ciudad as id_sucursal,       --
    fecha_venta,
    precio_final,
    metodo_pago
FROM {{ ref('stg_concesionario__ventas') }}
