FROM tomcat:9.0.19-jre8-alpine
EXPOSE 8080
COPY target/dptweb-1.0.war /usr/local/tomcat/webapps/
WORKDIR /usr/local/tomcat/webapps/
RUN mv -i dptweb-1.0.war dptweb.war 
