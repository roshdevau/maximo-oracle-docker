#!/bin/bash

################################################
#    Script : To build Maximo images           #
#    Author : roshdevau                        #
#    Usage  : ./buildMaximoImages.sh           #
#    Created: 29 June 2019                     #
################################################

checkAndExitIfPrevFailed () {

if [[ $1 -ne 0 ]];
then
        exit $1
fi
}

FILE_PATH=$(cd `dirname $0` && pwd)
echo $FILE_PATH/binaries

# Copy the Oracle Installer to the right folder
if [[ ! -f ./oracle/12.2.0.1/linuxx64_12201_database.zip ]];
then
	mv ./binaries/linuxx64_12201_database.zip oracle/12.2.0.1
	checkAndExitIfPrevFailed $?
fi

# Create a network build for transfer of installers
docker network rm build
docker network create build
checkAndExitIfPrevFailed $?

# Create container to access installers over a web url
docker run -d --name ibmbinaries -h ibmbinaries --network build -v $FILE_PATH/binaries:/usr/local/apache2/htdocs/ --restart always httpd:2.4
checkAndExitIfPrevFailed $?

# Create an IBM IM image
docker build -t maximo/ibmim:1.8.8 -t maximo/ibmim --network build ibmim
checkAndExitIfPrevFailed $?

# Create an Oracle 12c Images
oracle/buildDockerImage.sh -v 12.2.0.1 -e
checkAndExitIfPrevFailed $?

# Create WebSphere Application Server image
docker build -t maximo/maxwas:9.0.0.7 -t maximo/maxwas:latest --network build maxwas
checkAndExitIfPrevFailed $?

# Create a DMGR Image
docker build -t maximo/maxdmgr:9.0.0.7 -t maximo/maxdmgr:latest --network build maxdmgr
checkAndExitIfPrevFailed $?

# Create an Application Server Image
docker build -t maximo/maxapps:9.0.0.7 -t maximo/maxapps:latest --network build maxapps
checkAndExitIfPrevFailed $?

# Create a IHS WebServer Image
docker build -t maximo/maxweb:9.0.0.7 -t maximo/maxweb:latest --network build maxweb
checkAndExitIfPrevFailed $?

# Create a Maximo Image
docker build -t maximo/maximo:7.6.1.1 -t maximo/maximo:latest --network build maximo
checkAndExitIfPrevFailed $?

