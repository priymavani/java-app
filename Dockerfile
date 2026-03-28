# STAGE 1: Build the application using Maven
FROM maven:3.8.5-openjdk-11 AS builder
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Package the application, skipping tests to save time
RUN mvn clean package -DskipTests

# STAGE 2: Run the application on Tomcat
FROM tomcat:9.0-jdk17-corretto

# Clean out default Tomcat apps to prevent conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the compiled WAR file from the builder stage into Tomcat
COPY --from=builder /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]