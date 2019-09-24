FROM nginx

## Step 1:
# Create a working directory
# Copy source code to working directory
COPY static-html /usr/share/nginx/html

## Step 4:
# Expose port 80
EXPOSE 80
