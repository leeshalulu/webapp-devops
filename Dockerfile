# Use nginx as base image (Nginx is a web server)
FROM nginx:latest

# Copy our index.html into nginx default folder
COPY index.html /usr/share/nginx/html/index.html

