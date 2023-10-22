FROM eclipse-temurin:17-jdk-alpine
RUN mkdir -p /app
WORKDIR /app
COPY ./springboot-graphql-server/springboot-graphql-server-0.0.1-SNAPSHOT.jar springboot-graphql-server-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","springboot-graphql-server-0.0.1-SNAPSHOT.jar"]