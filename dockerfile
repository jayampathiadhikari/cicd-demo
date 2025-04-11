# Use Maven to build the application
FROM maven:3.9.9-eclipse-temurin-21-alpine AS build

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight Java runtime for running the application
FROM eclipse-temurin:21-alpine

# Copy the built JAR file from the build stage
COPY --from=build target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Set the default command to run the application
CMD ["java", "-jar", "/app.jar"]