# Dockerizing Mule CE
# Version:  3.5
# Based on:  dockerfile/java (Trusted Java from http://java.com)
# Original author: Eugene Ciurana <muledocker@eugeneciurana.com>

FROM                    dockerfile/java:openjdk-7-jre

# Mule installation:

ADD                     https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.5.0/mule-standalone-3.5.0.tar.gz /opt/
WORKDIR                 /opt
RUN                     tar -xzvf /opt/mule-standalone-3.5.0.tar.gz
RUN                     ln -s mule-standalone-3.5.0 mule
# Remove things that we don't need in production:
RUN                     rm -f mule-standalone-3.5.0.tar.gz
RUN                     rm -Rf mule/apps/default*
RUN                     rm -Rf mule/examples

# Configure external access:

# Mule remote debugger
EXPOSE  5000

# Mule JMX port (must match Mule config file)
EXPOSE  1098

# Default port for HTTP endpoints in AnypointStudio
EXPOSE  8081    


# Environment and execution:

ENV             MULE_BASE /opt/mule
WORKDIR         /opt/mule-standalone-3.5.0

CMD             /opt/mule/bin/mule