#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build --tag=capstone-container .

# Step 2:
# List docker images use only when doing local testing
#docker image ls

# Step 3:
# Run the NGINIX server only when doing local testing 
#docker run -p 8000:80 capstone-container
