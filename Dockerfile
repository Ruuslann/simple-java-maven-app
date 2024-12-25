# Use Maven image for building the application
FROM maven:3.9.5-eclipse-temurin-21 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY pom.xml .
COPY src ./src

# Build the Maven project
RUN mvn clean package -DskipTests

# Use a minimal JRE image for running the application
FROM eclipse-temurin:21-jre-alpine

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Define the entry point for the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
