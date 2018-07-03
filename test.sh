#!/bin/bash

CATALINA_BASE="/d/progammer/apache-tomcat-7.0.52"
CATALINA_HOME="/d/progammer/apache-tomcat-7.0.52"

JAVA_OPTS="";

if [ -r "$CATALINA_BASE"/conf/findAgent.sh ]; then
    AGENT_OPTS=. "$CATALINA_BASE"/conf/findAgent.sh "$CATALINA_BASE"/conf/server.xml "$CATALINA_HOME"/webapps
    if [ "$AGENT_OPTS" != "" ]; then {
      AGENT_OPTS=$(echo $AGENT_OPTS | awk -F\!\!\!\!\! '{print $NF}')
      echo $AGENT_OPTS
      if [ "$AGENT_OPTS" != "" ]; then {
        JAVA_OPTS="$JAVA_OPTS $AGENT_OPTS"
      }
      else {
          echo "Can't find AGENT_OPTS"
          echo "ignore"
      }
      fi
    }
    fi
else
    echo "Cannot find $CATALINA_BASE/conf/findAgent.sh"
    echo "ignore"
fi