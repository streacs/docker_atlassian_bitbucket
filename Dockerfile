##############################################################################
# Dockerfile to build Atlassian Bitbucket container images
# Based on Debian (https://hub.docker.com/r/_/debian/)
##############################################################################

FROM debian:stretch-slim

MAINTAINER Oliver Wolf <root@streacs.com>

ARG APPLICATION_RELEASE

ENV APPLICATION_INST /opt/atlassian/bitbucket
ENV APPLICATION_HOME /var/opt/atlassian/application-data/bitbucket

ENV SYSTEM_USER bitbucket
ENV SYSTEM_GROUP bitbucket
ENV SYSTEM_HOME /home/bitbucket

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
  && mkdir /usr/share/man/man1

RUN set -x \
  && apt-get update \
  && apt-get -y --no-install-recommends install wget git perl ca-certificates ruby-rspec ssh openjdk-8-jdk-headless \
  && gem install serverspec

RUN set -x \
  && addgroup --system ${SYSTEM_GROUP} \
  && adduser --system --home ${SYSTEM_HOME} --ingroup ${SYSTEM_GROUP} ${SYSTEM_USER}

RUN set -x \
  && mkdir -p ${APPLICATION_INST} \
  && mkdir -p ${APPLICATION_HOME} \
  && wget --no-check-certificate -nv -O /tmp/atlassian-bitbucket-${APPLICATION_RELEASE}.tar.gz https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${APPLICATION_RELEASE}.tar.gz \
  && tar xfz /tmp/atlassian-bitbucket-${APPLICATION_RELEASE}.tar.gz --strip-components=1 -C ${APPLICATION_INST} \
  && chown -R ${SYSTEM_USER}:${SYSTEM_GROUP} ${APPLICATION_INST} \
  && chown -R ${SYSTEM_USER}:${SYSTEM_GROUP} ${APPLICATION_HOME} \
  && rm /tmp/atlassian-bitbucket-${APPLICATION_RELEASE}.tar.gz

RUN set -x \
  && apt-get clean \
  && rm -rf /var/cache/* \
  && rm -rf /tmp/*

RUN set -x \
  && touch -d "@0" "${APPLICATION_INST}/bin/set-bitbucket-home.sh" \
  && touch -d "@0" "${APPLICATION_INST}/bin/_start-webapp.sh"

ADD files/service /usr/local/bin/service
ADD files/entrypoint /usr/local/bin/entrypoint
ADD files/healthcheck /usr/local/bin/healthcheck
ADD rspec-specs ${SYSTEM_HOME}/

VOLUME ${APPLICATION_HOME}

EXPOSE 7990 7999

ENTRYPOINT ["/usr/local/bin/entrypoint"]

USER ${SYSTEM_USER}

WORKDIR ${SYSTEM_HOME}

HEALTHCHECK --interval=5s --timeout=3s CMD /usr/local/bin/healthcheck

CMD ["/usr/local/bin/service"]
