{{- define "dagster.instance.postgresqlConfig" }}
postgres_db:
  username:
    env: POSTGRES_USER
  password:
    env: POSTGRES_PASSWORD
  hostname:
    env: POSTGRES_HOST
  db_name:
    env: POSTGRES_DB
  port:
    env: POSTGRES_PORT
{{- end }}