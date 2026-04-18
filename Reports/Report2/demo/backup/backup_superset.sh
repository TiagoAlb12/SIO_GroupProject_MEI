#!/bin/bash

echo "Exporting Superset assets..."

DATE=$(date +%Y%m%d_%H%M%S)

docker exec biua_superset superset export-dashboards -f /app/superset_home/dashboards_$DATE.zip
docker exec biua_superset superset export_datasources -f /app/superset_home/datasources_$DATE.zip

docker cp biua_superset:/app/superset_home/dashboards_$DATE.zip .
docker cp biua_superset:/app/superset_home/datasources_$DATE.zip .

docker exec -e PGPASSWORD=superset -t biua_postgres pg_dump -U superset -d biua_dw > superset_$DATE.sql

echo "Backup completed! Files:"
echo " - dashboards_$DATE.zip"
echo " - datasources_$DATE.zip"
echo " - superset_$DATE.sql"