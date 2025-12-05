FROM alpine:latest

RUN apk update && apk add --no-cache nginx

RUN mkdir -p /run/nginx \
    /var/log/nginx \
    /var/lib/nginx

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
