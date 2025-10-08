FROM nginxinc/nginx-unprivileged

# Switch to root to do privileged operations
USER root

RUN mkdir -p /var/cache/nginx/client_temp \
    && mkdir -p /var/run/nginx \
    && mkdir -p /var/log/nginx \
    && chown -R nginx:nginx /var/cache/nginx /var/run/nginx /var/log/nginx

# Copy your config & static files
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/

# Then switch back to the unprivileged (nginx) user
USER nginx

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
