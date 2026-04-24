#!/bin/bash

set -e

echo "Starting containers..."
docker compose up -d

echo "Waiting for PostgreSQL..."
until docker exec biua_postgres pg_isready -U superset -d biua_dw > /dev/null 2>&1; do
  sleep 2
done

echo "Waiting for Superset..."
until docker exec biua_superset curl -s http://localhost:8088 > /dev/null 2>&1; do
  sleep 2
done

echo "Restoring database..."
docker exec -i biua_postgres psql -U superset -d biua_dw < backups/biua_dw.sql

echo "Importing datasources..."
docker cp backups/datasources.zip biua_superset:/app/datasources.zip
docker exec biua_superset superset import_datasources -p /app/datasources.zip -u admin

echo "Importing dashboards..."
docker cp backups/dashboards.zip biua_superset:/app/dashboards.zip
docker exec biua_superset superset import-dashboards -p /app/dashboards.zip -u admin

echo "Setup complete!"