FROM node:8 AS build

WORKDIR /src
COPY . .
RUN npm install && \
    npm install -g bower && \
    bower install --allow-root && \
    npm build

FROM nginx:stable

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/app /usr/share/nginx/html

EXPOSE 80
