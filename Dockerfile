##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/pr21feb
WORKDIR /opt/pr21feb
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/pr21feb/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
