{{/*
Create a fully qualified smppdemo name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "sinch.cc2022.smppdemo.fullname" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sinch.cc2022.smppdemo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified democlient name.
*/}}
{{- define "sinch.cc2022.smppdemo.client.name" -}}
{{- include "sinch.cc2022.smppdemo.fullname" . -}}-client
{{- end -}}


{{/*
Client Labels.
*/}}
{{- define "sinch.cc2022.smppdemo.client.labels" -}}
app.kubernetes.io/name: {{ template "sinch.cc2022.smppdemo.client.name" . }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ template "sinch.cc2022.smppdemo.chart" . }}
{{- end -}}

{/*
Client Selector labels
*/}}
{{- define "sinch.cc2022.smppdemo.client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sinch.cc2022.smppdemo.client.name" . }}
{{- end -}}

{{/*
Create a fully qualified demoserver name.
*/}}
{{- define "sinch.cc2022.smppdemo.server.name" -}}
{{- include "sinch.cc2022.smppdemo.fullname" . -}}-server
{{- end -}}


{{/*
Server Labels.
*/}}
{{- define "sinch.cc2022.smppdemo.server.labels" -}}
app.kubernetes.io/name: {{ template "sinch.cc2022.smppdemo.server.name" . }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ template "sinch.cc2022.smppdemo.chart" . }}
{{- end -}}

{/*
Server Selector labels
*/}}
{{- define "sinch.cc2022.smppdemo.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sinch.cc2022.smppdemo.server.name" . }}
{{- end -}}

{{/*
Create image registry url
*/}}
{{- define "sinch.cc2022.smppdemo.registryUrl" -}}
{{- .Values.imageCredentials.registry.url -}}
{{- end -}}