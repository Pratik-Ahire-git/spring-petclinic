# building the java code
FROM maven:3.9.7-eclipse-temurin-17 AS build

RUN cd spring-petclinic && mvn clean package

# running the application
FROM amazoncorretto:17-alpine-jdk
# add metadata for the information
LABEL author="practice"
LABEL project="Run the spring-prtclinic application"
LABEL project="practice spring-petclinic"
RUN mkdir /spc && chown nobody /spc
USER nobody
WORKDIR /spc
COPY --from=build --chown=nobody /spring-petclinic/target/*.jar /spc/spring-petclinic.jar

EXPOSE 8080
CMD ["java", "-jar", "spring-petclinic.jar"]