

WITH base AS (
  SELECT
  id_sucursal,
   nombre,
  ciudad,
  direccion,
    telefono
  FROM {{ source('concesionario', 'sucursales')}}
)

SELECT
 {{ dbt_utils.generate_surrogate_key(['id_sucursal']) }} as id_sucursal,   
    nombre,
     ciudad,
   {{ dbt_utils.generate_surrogate_key(['ciudad']) }} AS id_ciudad,
    TRIM(direccion) AS direccion,
    telefono
FROM base
