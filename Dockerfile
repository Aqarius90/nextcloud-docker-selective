# must be ubuntu because of RUN args
FROM ubuntu:latest
LABEL maintainer="https://github.com/Aqarius90/nextcloud-docker-selective"

ENV SLEEP=300\
    USER=""\
    PASS=""\
    URL="wrong.domain.provided"\
    MUTE=true \
#docker build --env-file ./.env
    IN=""\
    OUT=""

# avoids software-properties-common input lockup
ARG DEBIAN_FRONTEND=noninteractive 

# yakshaving to get to nextcloudcmd
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:nextcloud-devs/client && apt update \
    && apt -y install nextcloud-client

# run loop
ADD init.sh /init.sh
CMD /init.sh