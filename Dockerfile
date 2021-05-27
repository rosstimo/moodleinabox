# currently the latest LTS version
From ubuntu:20.04


# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL \
    org.opencontainers.image.authors="timrossiter91@gmail.com" \
    org.opencontainers.image.title="moodleinabox" \
    org.opencontainers.image.description="Test deployment of Moodle server in docker continer" \
    org.opencontainers.image.documentation="https://github.com/rosstimo/moodleinabox.git" \
    org.opencontainers.image.source="https://github.com/rosstimo/moodleinabox.git"

# define argument variables
#time zone info
ARG TZ=America/Denver
#Moodle version to install
#Run git branch -a to see more
ARG MOODLE_VERSION=MOODLE_39_STABLE

# set environment variables
#ENV

# copy files to container
#COPY


    # set timezone
RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone &&

    # update/upgrade
RUN apt -y update && \
    apt -y upgrade &&

	# install git
RUN apt install \
    git \
    git-core \
    git-doc &&

	# install apache
RUN apt install \
    apache2 \
    libapache2-mod-php &&

	# install php
RUN apt install \
    php \
    php-curl \
    php-gd \
    php-intl \
    php-json \
    php-mbstring \
    php-mysql \
    php-soap \
    php-xml \
    php-xmlrpc \
    php-zip &&

    # clean up
RUN apt -y autoremove --purge && \
    apt -y clean
    # install Moodle
RUN
   cd /opt \
   git clone git://git.moodle.org/moodle.git && \
   cd moodle && \
   git branch --track "$MOODLE_VERSION" origin/"$MOODLE_VERSION" && \
   git checkout "$MOODLE_VERSION" &&



# listening server port
EXPOSE 80

# WORKDIR

# disable any healthcheck inherited from the base image
HEALTHCHECK NONE

# start server
   #CMD
