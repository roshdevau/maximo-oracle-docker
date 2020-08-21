# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM maximo/ibmim

MAINTAINER Rosh <roshdevau@gmail.com>


ARG url=http://ibmbinaries
ARG httpport=80
ARG skin=iot18

ENV TEMP /tmp
WORKDIR /tmp

# Install required packages
RUN apt update && apt install -y netcat inetutils-ping unzip && rm -rf /var/lib/apt/lists/*

## Install Maximo middleware and installer
RUN mkdir /Launchpad
WORKDIR /Launchpad

ENV BYPASS_PRS=True

## Install Maximo V7.6.1
ENV MAM_IMAGE MAM_7.6.1.0_LINUX64.tar.gz
ENV RSP_FILE ResponseFile_MAM_Install_Unix.xml
ENV MAM_FP MAMMTFP7611IMRepo.zip

ENV MAM_SCHED MAM_Scheduler_7.6.7.zip
ENV MAM_SCHED_RSP Scheduler_Silent_ResponseFile.xml
ENV MAM_SCHED_RSP_POST Scheduler/post-install.xml
ENV MAM_SCHED_RSP_INST Scheduler/install.xml

ENV MAM_HSE_761 Max_HSEM_V761.zip
ENV MAM_HSE_761_RSP HSE_Silent_ResponseFile.xml
ENV MAM_HSE_761_RSP_POST HSE/post-install.xml
ENV MAM_HSE_761_RSP_INST HSE/install.xml
ENV MAM_HSE_FP HSE7610_ifixes.20190201-1457.zip

ENV MAM_LIN MAX_LNEAR_ASET_MGR_7.6_MP_ML.zip
ENV MAM_LIN_RSP Linear_Silent_ResponseFile.xml

ENV MIF_FP MIF_7610_IFIX.20190201-1103.im.zip
ENV TPAE_FP TPAE_7610_IFIX.20190130-0928.im.zip
ENV WC_FP WRKCTR_7604_IFIX.20181219_for_TPAE_7610.im.zip

## Remove z from tar command because file is not gzipped despite having gz extension
RUN wget -q $url/$MAM_IMAGE && tar xpf $MAM_IMAGE && wget -q $url/$RSP_FILE \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl  -input $RSP_FILE  -acceptLicense -log /tmp/MAM_Install_Unix.xml 


RUN  mkdir /Launchpad/addons
WORKDIR /Launchpad/addons
RUN wget -q $url/$MIF_FP && wget -q $url/$TPAE_FP && wget -q $url/$WC_FP \ 
 && wget -q $url/$MAM_SCHED && wget -q $url/$MAM_HSE_761 && wget -q $url/$MAM_HSE_FP && wget -q $url/$MAM_LIN && wget -q $url/$MIF_FP \
 && wget -q $url/$TPAE_FP && wget -q $url/$WC_FP \
 && wget -q $url/$MAM_FP \
 && unzip -u $MAM_SCHED -d MAM_Scheduler_7.6.7 \
 && unzip -u $MAM_LIN -d MAX_LNEAR_ASET_MGR_7.6_MP_ML \
 && unzip -u $MAM_HSE_761 -d Max_HSEM_V761 \
 && unzip -u $MAM_HSE_FP -d HSE7610_ifixes.20190201-1457 \
 && unzip -u Max_HSEM_V761/hse_7.6.1_launchpad.zip -d Max_HSEM_V761/hse_7.6.1_launchpad \
 && wget -q $url/$MAM_HSE_761_RSP -O /Launchpad/addons/Max_HSEM_V761/hse_7.6.1_launchpad/$MAM_HSE_761_RSP \
 && wget -q $url/$MAM_HSE_761_RSP_POST -O /Launchpad/addons/Max_HSEM_V761/hse_7.6.1_launchpad/post-install.xml \
 && wget -q $url/$MAM_SCHED_RSP_INST -O /Launchpad/addons/Max_HSEM_V761/hse_7.6.1_launchpad/install.xml \
 && wget -q $url/$MAM_SCHED_RSP -O  /Launchpad/addons/MAM_Scheduler_7.6.7/$MAM_SCHED_RSP \
 && wget -q $url/$MAM_SCHED_RSP_POST -O /Launchpad/addons/MAM_Scheduler_7.6.7/post-install.xml \
 && wget -q $url/$MAM_SCHED_RSP_INST -O /Launchpad/addons/MAM_Scheduler_7.6.7/install.xml \
 && wget -q $url/$MAM_LIN_RSP -O /Launchpad/addons/MAX_LNEAR_ASET_MGR_7.6_MP_ML/$MAM_LIN_RSP \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -input /Launchpad/addons/Max_HSEM_V761/hse_7.6.1_launchpad/HSE_Silent_ResponseFile.xml -log /tmp/HSE_Silent.log -acceptLicense \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -input /Launchpad/addons/MAM_Scheduler_7.6.7/Scheduler_Silent_ResponseFile.xml -log /tmp/Scheduler_Silent.log -acceptLicense \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -input /Launchpad/addons/MAX_LNEAR_ASET_MGR_7.6_MP_ML/Linear_Silent_ResponseFile.xml -log /tmp/Linear_Silent.log -acceptLicense \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.tivoli.tpae.base.tpae.main.20181220-1247 -repositories /Launchpad/addons/WRKCTR_7604_IFIX.20181219_for_TPAE_7610.im.zip -installationDirectory /opt/IBM/SMP -log /tmp/MaximoWRKCTRIFix001.txt -acceptLicense \
 && cp -a /Launchpad/addons/HSE7610_ifixes.20190201-1457/applications/* /opt/IBM/SMP/maximo/applications \
 && cp -a /Launchpad/addons/HSE7610_ifixes.20190201-1457/tools/* /opt/IBM/SMP/maximo/tools \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.tivoli.tpae.base.tpae.main.20190201-1103 -repositories /Launchpad/addons/MIF_7610_IFIX.20190201-1103.im.zip -installationDirectory /opt/IBM/SMP  -log /tmp/MaximoMIFIFix001.txt -acceptLicense \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.tivoli.tpae.base.tpae.main.20190130-0928 -repositories /Launchpad/addons/TPAE_7610_IFIX.20190130-0928.im.zip -installationDirectory /opt/IBM/SMP  -log /tmp/MaximoTPAEIFix006.txt -acceptLicense \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.tivoli.tpae.base.tpae.main -repositories /Launchpad/addons/$MAM_FP -installationDirectory /opt/IBM/SMP -log /tmp/MAM_FP_Install_Unix.xml -acceptLicense \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.tivoli.tpae.base.mam.main -repositories /Launchpad/addons/$MAM_FP -installationDirectory /opt/IBM/SMP -log /tmp/TPAEFP_Install_Unix.xml -acceptLicense \
 && rm -rf /Launchpad

RUN mkdir /work
WORKDIR /work

ENV MAXADMIN_PASSWORD maxadmin
ENV MAXREG_PASSWORD maxreg
ENV MXINTADM_PASSWORD mxintadm
ENV BASE_LANG en
ENV ADMIN_EMAIL_ADDRESS root@localhost
ENV SMTP_SERVER_HOST_NAME localhost
ENV MAXDB MAXDB761
ENV DB_HOST_NAME oracle
ENV DB_PORT 1521
ENV DB_MAXIMO_PASSWORD Hello123#
ENV DMGR_ADMIN_USER wasadmin
ENV DMGR_ADMIN_PASSWORD wasadmin
ENV DMGR_HOST_NAME maxdmgr
ENV DMGR_PORT 8879
ENV WAS_DM_PROFILE_NAME ctgDmgr01
ENV WAS_DM_NODE_NAME ctgCellManager01
ENV WAS_NODE_NAME ctgNode01
ENV WEB_SERVER_NAME webserver1
ENV WEB_SERVER_HOST_NAME maxweb
ENV WEB_SERVER_PORT ${httpport}
ENV APP_SERVER_HOST_NAME maxapps
ENV APP_SERVER_PORT 8878
ENV UPDATE_APPS_ON_REBOOT yes

RUN wget -q https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
    && mv wait-for-it.sh /usr/local/bin && chmod +x /usr/local/bin/wait-for-it.sh

RUN wget -q https://raw.githubusercontent.com/wsadminlib/wsadminlib/master/bin/wsadminlib.py

COPY StopAllServers.py /work
COPY StartAllServers.py /work
COPY AddVirtualHosts.py /work
COPY SetAutoRestart.py /work

ENV SKIN=${skin}

COPY startinstall.sh /work
RUN chmod +x /work/startinstall.sh
ENTRYPOINT ["/work/startinstall.sh"]
