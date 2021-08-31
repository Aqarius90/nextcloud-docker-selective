# must be ubuntu because of RUN args
FROM alpine:latest
LABEL maintainer="https://github.com/Aqarius90/nextcloud-docker-selective"

ENV SLEEP=300\
    USER=""\
    PASS=""\
    URL="wrong.domain.provided"\
    MUTE=false \
    FORCE_REMOVE=false \
    IN=""\
    OUT=""

# avoids software-properties-common input lockup
ARG DEBIAN_FRONTEND=noninteractive 

# yakshaving to get to nextcloudcmd
RUN apk update && apk add nextcloud-client && apk add rsync && apk add bash
#    && rm -rf /var/lib/apt/lists/*

# run loop
ADD init.sh /init.sh
CMD /init.sh