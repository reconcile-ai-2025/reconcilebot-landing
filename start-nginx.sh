#!/bin/sh

# Start nginx with Railway's dynamic PORT
# Railway provides PORT environment variable

# Use Railway's PORT or default to 8080
PORT=${PORT:-8080}

echo "Starting nginx on port $PORT"

# Create nginx config with Railway's PORT
cat > /etc/nginx/conf.d/default.conf << EOF
server {
    listen ${PORT};
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    # Enable gzip compression
    gzip on;
    gzip_types text/html text/css application/javascript application/json;
    gzip_min_length 1000;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Cache static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Main location
    location / {
        try_files \$uri \$uri/ /index.html;
    }

    # robots.txt
    location = /robots.txt {
        add_header Content-Type text/plain;
    }

    # sitemap.xml
    location = /sitemap.xml {
        add_header Content-Type application/xml;
    }

    # Health check endpoint for Railway
    location /health {
        access_log off;
        return 200 "OK";
        add_header Content-Type text/plain;
    }
}
EOF

# Start nginx in foreground
exec nginx -g "daemon off;"
