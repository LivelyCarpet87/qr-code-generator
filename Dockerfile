FROM nginx:1.29-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY . /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

# Create writable directories needed by nginx.
RUN mkdir -p \
        /tmp/nginx/client_temp \
        /tmp/nginx/proxy_temp \
        /tmp/nginx/fastcgi_temp \
        /tmp/nginx/uwsgi_temp \
        /tmp/nginx/scgi_temp \
    && chown -R nginx:nginx /tmp/nginx

USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
