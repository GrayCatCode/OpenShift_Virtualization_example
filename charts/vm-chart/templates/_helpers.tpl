{{- define "vm-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Values.vmName | trunc 63 -}}
{{- end -}}
