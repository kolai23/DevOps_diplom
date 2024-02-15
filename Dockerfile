FROM tomcat:8.0-alpine
EXPOSE 8080
COPY target/*.war /usr/local/tomcat/webapps/
CMD [“catalina.sh”, “run”]