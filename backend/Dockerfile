# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim as builder

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw .
COPY mvnw.cmd .
COPY pom.xml .
COPY .mvn .mvn

# Make mvnw executable
RUN chmod +x ./mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Use OpenJDK 17 for the runtime
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Create uploads directory
RUN mkdir -p /app/uploads/user/profile

# Copy the JAR file from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Create a non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Change ownership of the app directory
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/spendwise/actuator/health || exit 1

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
