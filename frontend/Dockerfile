FROM node:18-alpine as build
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . .
RUN node setup-env.js
RUN npm run build-prod

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/dist/frontend/browser/* /usr/share/nginx/html/
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
