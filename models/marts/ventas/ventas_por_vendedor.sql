{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}
{{ config(materialized='view') }}

SELECT
    fv.id_vendedor,
    v.nombre ,
    COUNT(fv.id_venta) AS total_ventas,
    SUM(fv.precio_final) AS total_facturado,
    MIN(fv.fecha_venta) AS primera_venta,
    MAX(fv.fecha_venta) AS ultima_venta
FROM {{ ref('fact_ventas') }} fv
INNER JOIN {{ ref('dim_vendedor') }} v
    ON fv.id_vendedor = v.id_vendedor
GROUP BY fv.id_vendedor, v.nombre
ORDER BY total_facturado DESC
