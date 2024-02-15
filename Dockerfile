FROM tomcat:8.0-alpine
EXPOSE 8080
WORKDIR /usr/local/tomcat/webapps/
COPY target/*.war /usr/local/tomcat/webapps/
