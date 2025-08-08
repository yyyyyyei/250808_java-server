# Maven 빌드 단계
FROM maven:3.10.3-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn -B package -DskipTests

# Tomcat 런타임 단계
FROM tomcat:10.1.44-jdk17-temurin
ENV TZ=Asia/Seoul
EXPOSE 8080
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh", "run"]