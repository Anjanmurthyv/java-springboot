FROM openjdk:11-jdk-slim
WORKDIR /app
COPY ./target/javawebapp-0.0.1-SNAPSHOT.war /app/javawebapp-0.0.1-SNAPSHOT.war
EXPOSE 8080
CMD ["java", "-jar", "javawebapp-0.0.1-SNAPSHOT.war"]
