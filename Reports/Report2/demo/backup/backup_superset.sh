#!/bin/bash

set -e

echo "Exporting Superset assets..."

mkdir -p backups

echo "Exporting dashboards..."
docker exec biua_superset superset export-dashboards -f /app/superset_home/dashboards.zip

echo "Exporting datasources..."
docker exec biua_superset superset export_datasources -f /app/superset_home/datasources.zip

echo "Copying export files..."
docker cp biua_superset:/app/superset_home/dashboards.zip backups/dashboards.zip
docker cp biua_superset:/app/superset_home/datasources.zip backups/datasources.zip

echo "Exporting data warehouse database..."
docker exec -e PGPASSWORD=superset biua_postgres pg_dump \
  -U superset \
  -d biua_dw \
  --no-owner \
  --no-privileges \
  | gzip -9 > backups/biua_dw.sql.gz

echo "Backup completed!"
echo "Files created:"
echo " - backups/dashboards.zip"
echo " - backups/datasources.zip"
echo " - backups/biua_dw.sql.gz"