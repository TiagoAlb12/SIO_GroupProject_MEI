#!/bin/sh

superset db upgrade

superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@ua.pt \
  --password admin || true

superset init

superset run -h 0.0.0.0 -p 8088