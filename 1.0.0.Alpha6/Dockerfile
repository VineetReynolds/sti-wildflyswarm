# This image provides a base for building and running WildFly Swarm
# applications.  It builds using maven and runs the resulting swarm
# artifact.

FROM openshift/base-centos7

MAINTAINER Ben Browning <bbrownin@redhat.com>

EXPOSE 8080 8888

ENV MAVEN_VERSION 3.3.3

LABEL io.k8s.description="Platform for building and running JEE applications on WildFly Swarm" \
      io.k8s.display-name="WildFly Swarm" \
      io.openshift.expose-services="8080:http,8888:ping" \
      io.openshift.tags="builder,wildflyswarm" \
      io.openshift.s2i.destination="/opt/s2i/destination"

# Install Maven
RUN yum install -y --enablerepo=centosplus \
    tar unzip bc which lsof iproute java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    yum clean all -y && \
    (curl -0 http://www.us.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | \
    tar -zx -C /usr/local) && \
    ln -sf /usr/local/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn && \
    mkdir -p /opt/app-root/source && \
    mkdir -p /opt/s2i/destination

# Copy the S2I scripts from the specific language image to /usr/local/sti
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

# Add the WildFly Swarm build script and produce a build
ADD ./contrib/build-swarm.sh /tmp/build-swarm.sh
RUN /tmp/build-swarm.sh

# Create wildfly swarm group and user, set file ownership to that user.
RUN chmod -R go+rw /opt/s2i/destination

USER 1001

CMD $STI_SCRIPTS_PATH/usage
