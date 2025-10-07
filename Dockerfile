##
# Dockerfile for the Angular frontend.  This image simply serves
# static HTML, CSS and JavaScript using nginx.  A custom nginx
# configuration proxies API calls to the backend service in the
# cluster (see k8s manifests).

FROM nginx:alpine

# Remove the default configuration and replace with our own
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy static files into nginx’s html directory
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css
COPY script.js /usr/share/nginx/html/script.js

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]