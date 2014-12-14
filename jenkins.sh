#! /bin/bash

copy_reference_file() {
  f=${1%/}
  echo "$f"
    rel=${f:23}
    dir=$(dirname ${f})
    echo " $f -> $rel"
  if [[ ! -e /var/jenkins_home/${rel} ]]
  then
    echo "copy $rel to JENKINS_HOME"
    mkdir -p /var/jenkins_home/${dir:23}
    cp -r /usr/share/jenkins/ref/${rel} /var/jenkins_home/${rel};
  fi;
}
export -f copy_reference_file
find /usr/share/jenkins/ref/ -type f -exec bash -c 'copy_reference_file {}' \;

exec java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS
