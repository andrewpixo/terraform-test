FROM node:16-alpine AS builder

WORKDIR /build
COPY . .
RUN npm config set fetch-retries 10 -g
RUN npm ci
RUN npm run build

EXPOSE 3000

ENTRYPOINT ["node", "dist/main"]
