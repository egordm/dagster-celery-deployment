{{- define "dagster.postgresql.secretName" -}}
{{- printf "%s-postgresql-secret" (include "dagster.name" .) }}
{{- end }}

{{- define "dagster.celery.secretName" -}}
{{- printf "%s-celery-secret" (include "dagster.name" .) }}
{{- end }}

{{- define "dagster.celery.broker_url" -}}
{{- $host := printf "%s-redis-master.%s" (include "dagster.name" .) .Release.Namespace -}}
{{- printf "redis://:%s@%s:%g/%g" .Values.redis.password $host .Values.redis.port  (.Values.redis.brokerDbNumber | default (float64 0)) }}
{{- end -}}


{{- define "dagster.celery.backend_url" -}}
{{- $host := printf "%s-redis-master.%s" (include "dagster.name" .) .Release.Namespace -}}
{{- printf "redis://:%s@%s:%g/%g" .Values.redis.password $host .Values.redis.port  (.Values.redis.backendDbNumber | default (float64 0)) }}
{{- end -}}

{{- define "dagster.shared_env" -}}
DAGSTER_HOME: {{ .Values.global.dagsterHome | quote }}
{{- end -}}

{{/*
This environment shared across all User Code containers
*/}}
{{- define "dagster.codelocation.shared_env" -}}
DAGSTER_HOME: {{ .Values.global.dagsterHome | quote }}
DAGSTER_K8S_PIPELINE_RUN_NAMESPACE: "{{ .Release.Namespace }}"
DAGSTER_K8S_PIPELINE_RUN_ENV_CONFIGMAP: "{{ template "dagster.name" . }}-pipeline-env"
{{- end -}}