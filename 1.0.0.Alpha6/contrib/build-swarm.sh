#!/bin/bash

# (hack) Clone and build WildFly Swarm 1.0.0.Alpha6 required for Bankplus
echo "Building WildFly Swarm"
LOCAL_SRC_DIR=${HOME}
cd ${LOCAL_SRC_DIR}
git clone https://github.com/wildfly-swarm/wildfly-swarm.git wildfly-swarm
cd wildfly-swarm
git checkout 1cb37ef2c1f36a274d1c8915d55801740c79122a
mvn -U clean install -DskipTests
ERR=$?
if [ $ERR -ne 0 ]; then
  echo "Aborting due to error code $ERR from mvn install"
  exit $ERR
fi
cp -R /root/.m2 /opt/app-root/src/
chmod -R go+rw /opt/app-root/src/.m2
