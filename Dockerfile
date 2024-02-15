FROM tomcat:9.0.19-jre8-alpine
EXPOSE 8080
WORKDIR /usr/local/tomcat/webapps/
COPY target/dptweb-1.0.war /usr/local/tomcat/webapps/dptweb.war 
