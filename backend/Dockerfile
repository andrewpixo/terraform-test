FROM node:16-alpine AS builder

ARG host
ARG user
ARG pass
ARG port

ENV DB_HOST=$host
ENV DB_USER=$user
ENV DB_PASS=$pass
ENV DB_PORT=$port

WORKDIR /build
COPY . .
RUN npm config set fetch-retries 10 -g
RUN npm ci
RUN npm run build

EXPOSE 3000

ENTRYPOINT ["node", "dist/main"]
