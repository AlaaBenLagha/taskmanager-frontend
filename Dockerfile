FROM nginxinc/nginx-unprivileged

# Create and adjust permissions
RUN mkdir -p /var/cache/nginx/client_temp \
    && mkdir -p /var/run/nginx \
    && chown -R nginx:nginx /var/cache/nginx /var/run/nginx /var/log/nginx

# Copy config
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/

# Expose port etc.
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
