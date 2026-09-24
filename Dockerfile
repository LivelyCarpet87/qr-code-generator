FROM nginx:1.29-alpine

# Remove nginx's default site.
RUN rm -rf /usr/share/nginx/html/*

# Copy the upstream application as-is.
COPY . /usr/share/nginx/html/

# Replace the default nginx configuration.
COPY docker/nginx.conf /etc/nginx/nginx.conf

# nginx needs these writable locations when running unprivileged.
RUN mkdir -p /tmp/nginx/client_temp \
             /tmp/nginx/proxy_temp \
             /tmp/nginx/fastcgi_temp \
             /tmp/nginx/uwsgi_temp \
             /tmp/nginx/scgi_temp \
    && chown -R nginx:nginx /tmp/nginx

USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
