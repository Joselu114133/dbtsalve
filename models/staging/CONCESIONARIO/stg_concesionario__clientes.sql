-- models/clientes.sql

with source as (
    select * from {{ source ('concesionario','clientes') }}
),

with_surrogate_key as (
    select
        {{ dbt_utils.generate_surrogate_key(['id_cliente']) }} as id_cliente,
        nombre_completo,
        email,
        telefono,
        fecha_registro,
        ciudad
    from source
)

select * from with_surrogate_key
