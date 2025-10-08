# Stage 1: Build the Angular application
FROM node:lts-alpine AS build

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# Stage 2: Serve the application using NGINX
FROM nginx:alpine

# Remove default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the built Angular application
COPY --from=build /app/dist/your-app-name /usr/share/nginx/html

# Set appropriate permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

USER nginx

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
