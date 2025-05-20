

WITH base AS (
  SELECT
   nombre,
  ciudad,
  direccion,
    telefono
  FROM {{ source('concesionario', 'sucursales')}}
)

SELECT  
    nombre,
     ciudad,
   {{ dbt_utils.generate_surrogate_key(['ciudad']) }} AS id_ciudad,
    TRIM(direccion) AS direccion,
    telefono
FROM base
