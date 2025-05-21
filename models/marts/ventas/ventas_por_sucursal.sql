{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}
{{ config(materialized='view') }}


SELECT
    fv.id_sucursal,
    s.nombre AS nombre_sucursal,  
    COUNT(fv.id_venta) AS total_ventas,
    SUM(fv.precio_final) AS total_facturado,
    MIN(fv.fecha_venta) AS primera_venta,
    MAX(fv.fecha_venta) AS ultima_venta
FROM {{ ref('fact_ventas') }} fv
LEFT JOIN {{ ref('dim_sucursal') }} s
    ON fv.id_sucursal = s.id_sucursal
GROUP BY fv.id_sucursal, s.nombre
ORDER BY total_facturado DESC
