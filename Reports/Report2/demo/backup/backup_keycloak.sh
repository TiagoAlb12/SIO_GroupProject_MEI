#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
EXPORT_DIR="$SCRIPT_DIR/keycloak/import"

echo "Exporting Keycloak realm..."

mkdir -p "$EXPORT_DIR"

KEYCLOAK_VOLUME=$(docker inspect biua_keycloak \
  --format '{{range .Mounts}}{{if eq .Destination "/opt/keycloak/data"}}{{.Name}}{{end}}{{end}}')

if [ -z "$KEYCLOAK_VOLUME" ]; then
  echo "Could not find Keycloak data volume from container biua_keycloak."
  exit 1
fi

echo "Using volume: $KEYCLOAK_VOLUME"

echo "Stopping Keycloak..."
docker compose -f "$PROJECT_ROOT/docker-compose.yml" --project-directory "$PROJECT_ROOT" stop keycloak

echo "Exporting realm ua-bi..."
docker run --rm \
  -v "$KEYCLOAK_VOLUME:/opt/keycloak/data" \
  -v "$EXPORT_DIR:/tmp/keycloak-export" \
  quay.io/keycloak/keycloak:26.6.2 \
  export --dir /tmp/keycloak-export --realm ua-bi --users realm_file

echo "Restarting Keycloak..."
docker compose -f "$PROJECT_ROOT/docker-compose.yml" --project-directory "$PROJECT_ROOT" up -d keycloak

echo "Keycloak realm export completed."
echo "Files:"
ls -lh "$EXPORT_DIR"