#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `build-docker-image.sh`

# Step 1:
# Create dockerpath
 dockerpath="brea/udcty-capstone"

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker tag capstone-container $dockerpath

# Step 3:
# Push image to a docker repository
docker push $dockerpath
