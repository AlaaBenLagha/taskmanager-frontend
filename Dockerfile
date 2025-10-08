FROM nginx:alpine 
# Remove the default configuration and replace with our own 
COPY default.conf /etc/nginx/conf.d/default.conf 
# Copy static files into nginx’s html directory 
COPY index.html /usr/share/nginx/html/index.html 
COPY styles.css /usr/share/nginx/html/styles.css 
COPY script.js /usr/share/nginx/html/script.js 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
