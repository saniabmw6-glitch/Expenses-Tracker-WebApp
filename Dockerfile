#———stage1 - jar builder ————-

# Stage 1 - JAR Builder

FROM maven:3.9-eclipse-temurin-17-alpine AS builder

# Set working directory
WORKDIR /app

# Copy source code
COPY . /app

# Build application and skip tests
RUN mvn clean install -DskipTests=true


# Stage 2 - Application

FROM eclipse-temurin:17-jre-alpine

# Set working directory
WORKDIR /app

# Copy JAR from builder stage
COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

# Application port
EXPOSE 8080

# Start application
ENTRYPOINT ["java", "-jar", "/app/target/expenseapp.jar"]
