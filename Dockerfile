FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

FROM nginx
EXPOSE 80
# below syntax "--from" means to copy from another "PHASE"
COPY --from=builder /app/build /app/build /usr/share/nginx/html
