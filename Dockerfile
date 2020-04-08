FROM juliocesarmidia/ubuntu_base:v18.04 as confd
LABEL maintainer="Julio Cesar <julio@blackdevs.com.br>"

# install mysql-client
RUN apt-get update -y && apt-get install -y mysql-client && rm -rf /var/lib/apt/lists/*

# download CONFD
ARG CONFD_VERSION=0.16.0
RUN wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64
RUN chmod +x /usr/local/bin/confd

# copy template files
COPY templates/ /etc/confd/templates/
COPY conf.d/ /etc/confd/conf.d/

# copy entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
