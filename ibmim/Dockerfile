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

FROM ubuntu:16.04

MAINTAINER Rosh <roshdevau@gmail.com>

ARG url=http://ibmbinaries

ENV TEMP /tmp
WORKDIR /tmp

# Install required packages
RUN apt update && apt install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Install IBM Installation Manager 1.8.8
ENV IM_IMAGE MAM_7.6.1.0_LINUX64.tar.gz

RUN mkdir /Install_Mgr && wget -q $url/$IM_IMAGE  && tar -xf $IM_IMAGE -C /Install_Mgr   \
&& rm $IM_IMAGE  && /Install_Mgr/Install/IM/installer.linux.x86_64/installc -log /tmp/IM_Install_Unix.xml -acceptLicense  \
&& rm -rf /Install_Mgr
