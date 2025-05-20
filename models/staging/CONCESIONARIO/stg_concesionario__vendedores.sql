-- WITH base AS (
--   SELECT
--     id_vendedor,
--      nombre,
--      sucursal,
--     antiguedad_meses,
--     comision_por_venta
--   FROM {{ source('concesionario', 'vendedores')}}
-- )

-- SELECT
-- {{ dbt_utils.generate_surrogate_key(['id_vendedor']) }} as id_vendedor  ,
--   INITCAP(TRIM(nombre)) AS nombre,
--  {{ dbt_utils.generate_surrogate_key(['ciudad']) }} AS id_ciudad,
--   antiguedad_meses,
--   comision_por_venta
-- FROM base

-- WITH base AS (
--   SELECT
--     INITCAP(TRIM(sucursal)) AS ciudad
--   FROM {{ source('concesionario', 'vendedores') }}
-- )

WITH vendedores AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(["INITCAP(TRIM(sucursal))"]) }} AS id_ciudad,
    {{ dbt_utils.generate_surrogate_key(["id_vendedor"]) }} AS id_vendedor,
    INITCAP(TRIM(nombre)) AS nombre,
    INITCAP(TRIM(sucursal)) AS ciudad,
    antiguedad_meses,
    comision_por_venta
  FROM {{ source('concesionario', 'vendedores') }}
),

sucursales AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(["INITCAP(TRIM(ciudad))"]) }} AS id_ciudad,
    INITCAP(TRIM(nombre)) AS ciudad,
    direccion,
    telefono
  FROM {{ source('concesionario', 'sucursales') }}
)

SELECT
  v.id_vendedor,
  v.nombre,
  v.ciudad,
  v.antiguedad_meses,
  v.comision_por_venta,
  s.id_ciudad
FROM vendedores v
LEFT JOIN sucursales s
  ON v.id_ciudad = s.id_ciudad
