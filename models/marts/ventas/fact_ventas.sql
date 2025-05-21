
-- {{ config(materialized='table') }}
{{ config(database='ALUMNO14_DEV_GOLD_DB' ,
    materialized='incremental',
    unique_key='id_venta',
  schema='ventas'  ) }}


SELECT
    v.id_venta,
    v.fecha_venta,
    v.id_cliente,
    v.id_ciudad as id_sucursal,
    v.id_vendedor,
    v.id_vehiculo,
    v.metodo_pago,
    v.precio_final
FROM
    {{ ref('stg_concesionario__ventas') }} v

{% if is_incremental() %}
    -- Solo inserta las ventas nuevas (las que no existen aún en la tabla incremental)
    WHERE v.fecha_venta >  (select max(fecha_venta) from {{ this }})
{% endif %}