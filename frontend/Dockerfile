FROM node:18-alpine as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build-prod

FROM nginx:stable as run
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/dist/frontend /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80