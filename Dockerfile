FROM nginx:latest

# Copy website files to nginx config
COPY . /usr/share/nginx/html

# Expose nginx port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
