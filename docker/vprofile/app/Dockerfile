FROM maven:3.9.9-eclipse-temurin-21-jammy AS build_image
RUN git clone https://github.com/hkhcoder/vprofile-project.git
RUN cd vprofile-project && git checkout containers && mvn install
# For multistage docker app


# Two images to make it more modular
# Below is a service image
FROM tomcat:10-jdk21
LABEL "Project"="vprofile"
LABEL "Author"="Jace"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_image vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]