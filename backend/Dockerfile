FROM directus/directus:10.12.1

USER root
RUN apk add --no-cache python3 py3-requests
COPY dump /opt/dump_restore

USER node
