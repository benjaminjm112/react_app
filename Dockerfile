FROM node:16-alpine as builder

WORKDIR '/app'
RUN chown node:node /app

USER node

COPY --chown=node:node package.json package-lock.json* ./

RUN npm install

COPY --chown=node:node . .

RUN npm run test

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

