FROM openjdk:18-jdk-alpine
EXPOSE 80:80

RUN mkdir -p /app
COPY app/ /app/

WORKDIR /app

ENTRYPOINT ["java","-jar","com.example.ktor-sample-0.0.1.jar"]
