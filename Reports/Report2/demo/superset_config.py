import os

SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY")
if not SECRET_KEY:
    raise ValueError("SUPERSET_SECRET_KEY is not set")

SQLALCHEMY_DATABASE_URI = "postgresql+psycopg2://superset:superset@db:5432/biua_dw"