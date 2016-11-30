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

executable="./bin/swagger-codegen-cli-2.2.1.jar"

if [ ! -f "$executable" ]
then
  echo "Missing Swagger Codegen client."
  exit 1;
fi

export JAVA_OPTS="${JAVA_OPTS} -Xmx1024M -DloggerPath=conf/log4j.properties"
ags="$@ generate -i api/felix.yaml -l ruby -t templates -c api/felix.json -o client/felix"

java $JAVA_OPTS -jar $executable $ags
