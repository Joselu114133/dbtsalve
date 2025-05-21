{{ config(
    materialized='incremental',
    unique_key='id_venta'
) }}

WITH ventas_base AS (
  SELECT
    id_venta,
    id_cliente,
    id_vehiculo,
    id_vendedor,
    fecha_venta,
    precio_final,
    metodo_pago,
    {{ dbt_utils.generate_surrogate_key(['sucursal']) }} AS id_ciudad
  FROM {{ source('concesionario', 'ventas') }}
),

sucursales AS (
  SELECT
    id_ciudad
  FROM {{ ref('stg_concesionario__sucursales') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['v.id_cliente','v.id_vehiculo']) }} as id_venta,
    {{ dbt_utils.generate_surrogate_key(['v.id_cliente']) }} as id_cliente,
    {{ dbt_utils.generate_surrogate_key(['v.id_vehiculo']) }} as id_vehiculo,
    {{ dbt_utils.generate_surrogate_key(['v.id_vendedor']) }} as id_vendedor,
    s.id_ciudad,
    v.fecha_venta,
    v.precio_final,
    v.metodo_pago
FROM ventas_base v
LEFT JOIN sucursales s
  ON v.id_ciudad = s.id_ciudad

{% if is_incremental() %}
  
  WHERE v.fecha_venta > 
    (select max(fecha_venta) from {{ this }}
  )
{% endif %}
