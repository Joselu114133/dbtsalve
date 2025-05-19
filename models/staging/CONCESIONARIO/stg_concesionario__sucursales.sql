

WITH base AS (
  SELECT
    INITCAP(TRIM(nombre)) AS nombre,
    INITCAP(TRIM(ciudad)) AS ciudad,
    TRIM(direccion) AS direccion,
    telefono
  FROM {{ ref('ALUMNO14_DEV_BRONZE_DB.CONCESIONARIO.SUCURSALES') }}
)

SELECT
  'S' || LPAD(ROW_NUMBER() OVER (ORDER BY nombre), 3, '0') AS id_sucursal,
  nombre,
  ciudad,
  direccion,
  telefono
FROM base
