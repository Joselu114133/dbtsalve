{% snapshot clientes_snapshot %}
  
  {{
    config(
      target_schema='snapshots',       
      unique_key='id_cliente',         
      strategy='check',                 
      check_cols=['nombre_completo', 'email', 'telefono', 'fecha_registro', 'ciudad']
    )
  }}

  select
    id_cliente,
    nombre_completo,
    email,
    telefono,
    fecha_registro,
    ciudad
  from {{ ref('stg_concesionario__clientes') }}   -- Ajusta si tu modelo staging tiene otro nombre

{% endsnapshot %}