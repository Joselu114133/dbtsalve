{{ config(
    materialized='table'
) }}
{{ config(database='ALUMNO14_DEV_GOLD_DB') }}
{{ config(schema='ventas') }}

SELECT
    vs.id_vehiculo,
    vm.marca,
    vm.modelo,
    vm.ano_fabri       AS ano_fabricacion,
    vm.tipo,
    vm.combustible,
    vs.precio_lista,
    vs.estado
FROM {{ ref('stg_concesionario__vehiculos_stock') }} vs
JOIN {{ ref('stg_concesionario__vehiculos_modelos') }} vm
    ON vs.id_modelo = vm.id_modelo
