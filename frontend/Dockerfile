FROM node:lts-alpine3.14 AS builder
ARG API_URL
ENV VITE_API_URL=$API_URL
RUN mkdir /app
COPY package*.json /app
WORKDIR /app
RUN npm ci
COPY . .
RUN npm run build


FROM nginx:alpine AS server
EXPOSE 80
COPY --from=builder /app/dist /usr/share/nginx/html