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

ENV TEMP /tmp
WORKDIR /tmp

RUN apt update && apt install -y tar bc net-tools netcat psmisc \
 && rm -rf /var/lib/apt/lists/*

RUN wget -q https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
    && mv wait-for-it.sh /usr/local/bin && chmod +x /usr/local/bin/wait-for-it.sh

RUN echo "root soft nofile 8192" >> /etc/security/limits.d/99-maximo.conf
RUN echo "root hard nofile 8192" >> /etc/security/limits.d/99-maximo.conf
RUN echo "root soft fsize -1" >> /etc/security/limits.d/99-maximo.conf
RUN echo "root hard fsize -1" >> /etc/security/limits.d/99-maximo.conf
RUN ulimit -f unlimited
RUN ulimit -n 8192
RUN echo "fs.file-max = 1232457" >> /etc/sysctl.d/99-maximo.conf

ENV MAX_ZIP MAM_7.6.1.0_LINUX64.tar.gz
ENV MIDDLWARE_ZIP1 Middl_Inst_WAS_90_1of3_Unix.tar.gz
ENV MIDDLWARE_ZIP2 Middl_Inst_WAS_90_2of3_Unix.tar.gz
ENV MIDDLWARE_ZIP3 Middl_Inst_WAS_90_3of3_Unix.tar.gz
ENV RSP_TPAE ResponseFile_TPAE_WAS_Install_Unix.xml

RUN mkdir /Launchpad  && wget -q ${url}/${MAX_ZIP}  && wget -q ${url}/${MIDDLWARE_ZIP1} \
 && wget -q ${url}/${MIDDLWARE_ZIP2}  && wget -q ${url}/${MIDDLWARE_ZIP3} && wget -q ${url}/${RSP_TPAE} \
 && tar -xf ${MAX_ZIP} -C /Launchpad  && tar -xf ${MIDDLWARE_ZIP1} -C /Launchpad/Install \
 && tar -xf ${MIDDLWARE_ZIP2} -C /Launchpad/Install  && tar -xf ${MIDDLWARE_ZIP3} -C /Launchpad/Install \
 && mv /Launchpad/Install/Install/* /Launchpad/Install/ \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -input /tmp/$RSP_TPAE -log /tmp/TPAE_Install.log -acceptLicense \
 && rm -rf /Launchpad  && rm -rf ${MAX_ZIP}  && rm -rf ${MIDDLWARE_ZIP1}  && rm -rf ${MIDDLWARE_ZIP2}  && rm -rf ${MIDDLWARE_ZIP3} && rm ${RSP_TPAE}

