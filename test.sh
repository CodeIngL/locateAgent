#!/bin/bash

CATALINA_BASE="/d/progammer/apache-tomcat-7.0.52"
CATALINA_HOME="/d/progammer/apache-tomcat-7.0.52"

JAVA_OPTS="";

. findAgent.sh "$CATALINA_BASE"/conf/server.xml "$CATALINA_HOME"/webapps

echo $JAVA_OPTS

JAVA_OPTS=""

echo "------------------------------------------"

. findAgentForAspectj.sh "$CATALINA_BASE"/conf/server.xml "$CATALINA_HOME"/webapps

echo $JAVA_OPTS