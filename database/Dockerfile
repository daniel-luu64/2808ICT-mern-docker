# database/Dockerfile
FROM mongo:7.0

# Set environment variables for initialization
ENV MONGO_INITDB_ROOT_USERNAME=admin
ENV MONGO_INITDB_ROOT_PASSWORD=admin123
ENV MONGO_INITDB_DATABASE=employees

# Copy initialization scripts
COPY ../init-scripts/ /docker-entrypoint-initdb.d/


# Expose MongoDB port
EXPOSE 27017

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD mongosh --eval "db.adminCommand('ping')" || exit 1cd