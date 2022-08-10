FROM jboss/wildfly
RUN /opt/jboss/wildfly/bin/add-user.sh admin welcome1 --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

FROM jboss/wildfly

# Deploy JavaEEDemo Application
ADD SMG_PARKING.war /opt/jboss/wildfly/standalone/deployments/

##  Change file WAR ownership to jboss:jboss
USER root
RUN chown jboss:jboss /opt/jboss/wildfly/standalone/deployments/SMG_PARKING.war
##  back to jboss user for subsequent commands
USER jboss

# Create a log directory to store log files
RUN mkdir /opt/jboss/wildfly/standalone/log

# Explicitly expose port 8080 (explicit is required by Elastic Beanstalk)
EXPOSE 8080