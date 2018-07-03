#!/bin/bash

CATALINA_BASE="/d/progammer/apache-tomcat-7.0.52"
CATALINA_HOME="/d/progammer/apache-tomcat-7.0.52"

JAVA_OPTS="";

. "$CATALINA_BASE"/bin/findAgent.sh "$CATALINA_BASE"/conf/server.xml "$CATALINA_HOME"/webapps

echo $JAVA_OPTS