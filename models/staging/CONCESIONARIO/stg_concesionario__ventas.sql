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
    {{ dbt_utils.generate_surrogate_key(['v.id_venta']) }} as id_venta,
  v.id_cliente,
  v.id_vehiculo,
  v.id_vendedor,
  s.id_ciudad,
  v.fecha_venta,
  v.precio_final,
  v.metodo_pago
FROM ventas_base v
LEFT JOIN sucursales s
  ON v.id_ciudad = s.id_ciudad
