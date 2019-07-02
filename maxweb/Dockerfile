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

FROM maximo/maxwas

MAINTAINER Rosh <roshdevau@gmail.com>

ARG url=http://ibmbinaries
ARG httpport=80

RUN mkdir /work
WORKDIR /work

RUN wget -q https://raw.githubusercontent.com/wsadminlib/wsadminlib/master/bin/wsadminlib.py

ENV WAS_HOME /opt/IBM/WebSphere/AppServer
ENV PROFILE_NAME ctgWebSrv01
ENV CELL_NAME ctgNodeWSCell01
ENV NODE_NAME ctgNodeWebSrv01
ENV DMGR_HOST_NAME maxdmgr
ENV DMGR_PORT 8879
ENV DMGR_ADMIN_USER wasadmin
ENV DMGR_ADMIN_PASSWORD wasadmin
ENV WEB_SERVER_NAME webserver1
ENV WEB_SERVER_PORT ${httpport}

COPY startihs.sh /work
COPY CreateWebServer.py /work
RUN chmod +x /work/startihs.sh

EXPOSE ${httpport} 34450 7272 9353 9900 8878 9201 9202 7062 2809 11004 9629

ENTRYPOINT ["/work/startihs.sh"]
