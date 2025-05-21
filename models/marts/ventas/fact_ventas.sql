
{{ config(materialized='table') }}
{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}

SELECT
    id_venta,        -- surrogate key de la venta (cliente + vehiculo)
    id_cliente,      -- clave de la dimensión cliente
    id_vehiculo,     -- clave de la dimensión vehículo
    id_vendedor,     -- clave de la dimensión vendedor
    id_ciudad as id_sucursal,       -- clave de la dimensión sucursal/ciudad
    fecha_venta,
    precio_final,
    metodo_pago
FROM {{ ref('stg_concesionario__ventas') }}
