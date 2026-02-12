#!/bin/bash

cd "$(dirname "$0")/.."
DOCKER_DIR="docker"

case "$1" in
  build)
    echo "Building MongoDB container..."
    cd "$DOCKER_DIR"
    docker-compose -f docker-compose-mongo.yml build mongodb
    ;;
    
  start)
    echo "Starting MongoDB services..."
    cd "$DOCKER_DIR"
    docker-compose -f docker-compose-mongo.yml up -d
    echo "MongoDB: localhost:27017"
    echo "Mongo Express: http://localhost:8081 (admin/admin123)"
    ;;
    
  stop)
    echo "Stopping MongoDB services..."
    cd "$DOCKER_DIR"
    docker-compose -f docker-compose-mongo.yml down
    ;;
    
  logs)
    cd "$DOCKER_DIR"
    docker-compose -f docker-compose-mongo.yml logs mongodb
    ;;
    
  test)
    echo "Testing MongoDB connection..."
    docker exec mern_employees_mongodb mongosh \
      --username admin --password admin123 --authenticationDatabase admin \
      --eval "
        db = db.getSiblingDB('employees');
        print('Database:', db.getName());
        print('Total records:', db.records.count());
        print('All records:');
        db.records.find().forEach(printjson);
      "
    ;;
    
  status)
    docker ps | grep -E "(mongodb|mongo-express)"
    ;;
    
  *)
    echo "Usage: $0 {build|start|stop|logs|test|status}"
    ;;
esac

