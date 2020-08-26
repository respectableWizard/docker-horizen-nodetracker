FROM ubuntu:xenial
MAINTAINER respectableWizard

ARG USER_ID
ARG GROUP_ID
ARG VERSION

ENV USER horizen
ENV COMPONENT ${USER}
ENV HOME /home/${USER}

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} ${USER} \
    && useradd -u ${USER_ID} -g ${USER} -s /bin/bash -m -d ${HOME} ${USER}

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates npm git \
    && npm install -g n \
    && n 10.12.0 \
    && git clone https://github.com/respectableWizard/nodetracker.git /opt/nodetracker \
    && cd /opt/nodetracker \
    && npm install /opt/nodetracker \
    && apt-get remove software-properties-common build-essential apt-transport-https lsb-release dirmngr pwgen git jq ufw curl aria2 -y \
    && apt-get autoremove -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chown -R ${USER} ${HOME} /opt/nodetracker /usr/local

VOLUME ["/opt/nodetracker"]
WORKDIR "/opt/nodetracker"
ADD ./bin /usr/local/bin
USER horizen
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/local/bin/start-unprivileged.sh"]