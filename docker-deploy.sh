#!/bin/bash

# Spendwise Application Docker Deployment Script
# This script helps build and deploy the complete Spendwise application

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker and try again."
        exit 1
    fi
}

# Function to check if docker-compose is available
check_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        print_error "docker-compose is not installed. Please install it and try again."
        exit 1
    fi
}

# Function to build and start services
start_services() {
    local env_file=${1:-"development"}
    
    print_status "Starting Spendwise application in $env_file mode..."
    
    if [ "$env_file" = "production" ]; then
        docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
    else
        docker-compose up -d --build
    fi
    
    print_success "Services started successfully!"
    print_status "Application URLs:"
    echo "  - Frontend: http://localhost:3000"
    echo "  - Backend API: http://localhost:8080/spendwise"
    echo "  - MySQL: localhost:3306"
}

# Function to stop services
stop_services() {
    print_status "Stopping Spendwise application..."
    docker-compose down
    print_success "Services stopped successfully!"
}

# Function to view logs
view_logs() {
    local service=${1:-""}
    if [ -z "$service" ]; then
        docker-compose logs -f
    else
        docker-compose logs -f "$service"
    fi
}

# Function to rebuild specific service
rebuild_service() {
    local service=$1
    if [ -z "$service" ]; then
        print_error "Please specify a service to rebuild (backend, frontend, mysql)"
        exit 1
    fi
    
    print_status "Rebuilding $service..."
    docker-compose build --no-cache "$service"
    docker-compose up -d "$service"
    print_success "$service rebuilt and restarted successfully!"
}

# Function to check service health
check_health() {
    print_status "Checking service health..."
    
    # Check MySQL
    if docker-compose exec mysql mysqladmin ping -h localhost -u user -puserpassword &> /dev/null; then
        print_success "MySQL: Healthy"
    else
        print_error "MySQL: Unhealthy"
    fi
    
    # Check Backend
    if curl -f http://localhost:8080/spendwise/actuator/health &> /dev/null; then
        print_success "Backend: Healthy"
    else
        print_error "Backend: Unhealthy"
    fi
    
    # Check Frontend
    if curl -f http://localhost:3000 &> /dev/null; then
        print_success "Frontend: Healthy"
    else
        print_error "Frontend: Unhealthy"
    fi
}

# Function to clean up Docker resources
cleanup() {
    print_warning "This will remove all stopped containers, unused networks, images, and build cache."
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Cleaning up Docker resources..."
        docker-compose down -v --remove-orphans
        docker system prune -a -f
        print_success "Cleanup completed!"
    else
        print_status "Cleanup cancelled."
    fi
}

# Function to show usage
usage() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo
    echo "Commands:"
    echo "  start [dev|prod]    Start the application (default: dev)"
    echo "  stop                Stop the application"
    echo "  restart             Restart the application"
    echo "  logs [service]      View logs (all services or specific service)"
    echo "  rebuild [service]   Rebuild and restart a specific service"
    echo "  health              Check service health status"
    echo "  cleanup             Remove all containers, images, and volumes"
    echo "  help                Show this help message"
    echo
    echo "Examples:"
    echo "  $0 start            # Start in development mode"
    echo "  $0 start prod       # Start in production mode"
    echo "  $0 logs backend     # View backend logs"
    echo "  $0 rebuild frontend # Rebuild frontend service"
}

# Main script logic
main() {
    check_docker
    check_docker_compose
    
    case ${1:-help} in
        start)
            start_services ${2:-development}
            ;;
        stop)
            stop_services
            ;;
        restart)
            stop_services
            start_services ${2:-development}
            ;;
        logs)
            view_logs $2
            ;;
        rebuild)
            rebuild_service $2
            ;;
        health)
            check_health
            ;;
        cleanup)
            cleanup
            ;;
        help|--help|-h)
            usage
            ;;
        *)
            print_error "Unknown command: $1"
            usage
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
