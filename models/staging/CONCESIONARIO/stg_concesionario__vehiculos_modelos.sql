WITH modelos AS (
    SELECT DISTINCT
        marca,
        modelo,
        ano_fabri,
        tipo,
        combustible
    FROM {{ source('concesionario', 'vehiculos') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['marca', 'modelo', 'ano_fabri', 'tipo', 'combustible']) }} AS id_modelo,
    marca,
    modelo,
    ano_fabri,
    tipo,
    combustible
FROM modelos
