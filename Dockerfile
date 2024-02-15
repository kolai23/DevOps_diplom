FROM tomcat:9.0-alpine
EXPOSE 8080
WORKDIR /usr/local/tomcat/webapps/
COPY target/dptweb-1.0.war /usr/local/tomcat/webapps/dptweb.war 
RUN mv /usr/local/tomcat/webapps/dptweb-1.0.war /usr/local/tomcat/webapps/dptweb.war