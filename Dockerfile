FROM debian:buster-slim

MAINTAINER Cedric Roijakkers <cedric@roijakkers.be>

ENV OMNIDB_VERSION 2.11.0
ENV EXTERNAL_WEBSOCKET_PORT=25482

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get install -y --no-install-recommends python3-pip python3-setuptools curl unzip \
&& pip3 install pip --upgrade && rm -rf /var/lib/apt/lists/*
	
RUN curl -Lo /tmp/OmniDB.zip https://github.com/OmniDB/OmniDB/archive/${OMNIDB_VERSION}.zip \
&& unzip /tmp/OmniDB.zip -d /opt/ && rm -f /tmp/OmniDB.zip && mkdir /etc/omnidb
	  
RUN cd /opt/OmniDB-${OMNIDB_VERSION} && pip3 install -r requirements.txt

EXPOSE 8080 25482

WORKDIR /opt/OmniDB-${OMNIDB_VERSION}/OmniDB

HEALTHCHECK --start-period=5s --interval=30s --timeout=5s --retries=3 CMD curl --fail http://localhost:8080/ >/dev/null 2>&1 || exit 1

COPY docker-entrypoint.sh /
RUN chmod a+rx /docker-entrypoint.sh 
CMD ["/bin/bash", "/docker-entrypoint.sh"]