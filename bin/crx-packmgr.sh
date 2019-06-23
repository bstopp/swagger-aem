#!/usr/bin/env bash

SCRIPT="$0"

while [ -h "$SCRIPT" ] ; do
  ls=`ls -ld "$SCRIPT"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    SCRIPT="$link"
  else
    SCRIPT=`dirname "$SCRIPT"`/"$link"
  fi
done

if [ ! -d "${APP_DIR}" ]; then
  APP_DIR=`dirname "$SCRIPT"`/..
  APP_DIR=`cd "${APP_DIR}"; pwd`
fi

executable="./bin/swagger-codegen-cli-2.4.5.jar"

if [ ! -f "$executable" ]
then
  echo "Missing Swagger Codegen client."
  exit 1;
fi

export JAVA_OPTS="${JAVA_OPTS} -Xmx1024M -DloggerPath=conf/log4j.properties"
ags="$@ generate -i api/crx-packmgr.yaml -l ruby -t templates -c api/crx-packmgr.json -o clients/crx-packmgr"

java $JAVA_OPTS -jar $executable $ags
