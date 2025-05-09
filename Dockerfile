# Use Maven image to build the app
FROM maven:3.9.5-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Use tomcat base image to run the app
FROM tomcat:9.0.104-jdk8-temurin-jammy

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/*.war

EXPOSE 8080
CMD ["catalina.sh","run"]
