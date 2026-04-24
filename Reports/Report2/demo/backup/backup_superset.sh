#!/bin/bash

echo "Exporting Superset assets..."

mkdir -p backups

docker exec biua_superset superset export-dashboards -f /app/superset_home/dashboards.zip
docker exec biua_superset superset export_datasources -f /app/superset_home/datasources.zip

docker cp biua_superset:/app/superset_home/dashboards.zip backups/dashboards.zip
docker cp biua_superset:/app/superset_home/datasources.zip backups/datasources.zip

docker exec -e PGPASSWORD=superset -t biua_postgres pg_dump -U superset -d biua_dw > backups/biua_dw.sql

echo "Backup completed! Files:"
echo " - backups/dashboards.zip"
echo " - backups/datasources.zip"
echo " - backups/biua_dw.sql"