{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}

{{ config(materialized='view') }}

SELECT
    fv.id_vehiculo,
    v.modelo AS modelo_coche,         -- Asegúrate que 'modelo' existe en dim_vehiculo
    v.marca AS marca_coche,           -- Y 'marca' también, si la quieres mostrar
    COUNT(fv.id_venta) AS total_ventas,
    SUM(fv.precio_final) AS total_facturado,
    MIN(fv.fecha_venta) AS primera_venta,
    MAX(fv.fecha_venta) AS ultima_venta
FROM {{ ref('fact_ventas') }} fv
INNER JOIN {{ ref('dim_vehiculo') }} v
    ON fv.id_vehiculo = v.id_vehiculo
GROUP BY fv.id_vehiculo, v.modelo, v.marca
ORDER BY total_facturado DESC

