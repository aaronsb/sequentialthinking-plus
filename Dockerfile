# Base image
FROM node:20-slim

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source files
COPY index.js ./
COPY sequential-thinking-tool-schema.js ./
COPY strategy-stages-mapping.json ./
COPY semantic-routing-config.json ./

# Make the index.js executable
RUN chmod +x index.js

# Create data directory with permissions that allow any user to write to it
RUN mkdir -p /app/data && chmod 777 /app/data

# Set the entrypoint
ENTRYPOINT ["node", "index.js", "--storage-path", "/app/data"]
