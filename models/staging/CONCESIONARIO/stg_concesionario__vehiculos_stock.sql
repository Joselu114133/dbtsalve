WITH stock AS (
    SELECT
        id_vehiculo,
        marca,
        modelo,
        ano_fabri,
        tipo,
        combustible,
        precio_lista,
        estado
    FROM {{ source('concesionario', 'vehiculos') }}
),

modelos AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['marca', 'modelo', 'ano_fabri', 'tipo', 'combustible']) }} AS id_modelo,
        marca,
        modelo,
        ano_fabri,
        tipo,
        combustible
    FROM {{ source('concesionario', 'vehiculos') }}
)

SELECT
    s.id_vehiculo,
    m.id_modelo,
    s.precio_lista,
    s.estado
FROM stock s
LEFT JOIN modelos m
    ON s.marca = m.marca
    AND s.modelo = m.modelo
    AND s.ano_fabri = m.ano_fabri
    AND s.tipo = m.tipo
    AND s.combustible = m.combustible

