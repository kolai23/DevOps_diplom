FROM tomcat:latest
EXPOSE 8080
COPY target/*.war /opt/tomcat/webapps