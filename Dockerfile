# Dockerfile for ReconcileBot Landing Page (Static Site)
# Uses nginx to serve static HTML files on Railway's dynamic PORT

FROM nginx:alpine

# Copy static files to nginx html directory
COPY index.html /usr/share/nginx/html/
COPY robots.txt /usr/share/nginx/html/
COPY sitemap.xml /usr/share/nginx/html/

# Copy startup script
COPY start-nginx.sh /start-nginx.sh
RUN chmod +x /start-nginx.sh

# Railway provides PORT environment variable
ENV PORT=8080

# Start nginx with dynamic port
CMD ["/start-nginx.sh"]
