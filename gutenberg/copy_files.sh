#!/bin/bash

# Lista de IDs (podés modificarla directamente acá)
book_ids=(
PG75703
PG75739
PG75775
PG8870
PG9890
PG9895
PG9980
)

src_dir="data/text"
dst_dir="data/seleccion"

# Crear carpeta destino si no existe
mkdir -p "$dst_dir"

# Copiar cada archivo
for id in "${book_ids[@]}"; do
    file="${src_dir}/${id}_text.txt"
    if [[ -f "$file" ]]; then
        cp "$file" "$dst_dir/"
        echo "Copiado: $file"
    else
        echo "No encontrado: $file"
    fi
done
