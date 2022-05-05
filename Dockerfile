FROM mcr.microsoft.com/dotnet/sdk:6.0
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

ARG GAME_PORT=25555
ARG K8=False

# Set some Variables
ENV ADDITIONAL_OPTS ""
ENV TZ "America/New_York"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
                curl \
				wget \
                unzip \
                tzdata \
                && rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    rimuser && \
    usermod -G tty rimuser \
        && mkdir -p /rimworld \
                && mkdir -p /scripts \
                && chown rimuser:rimuser /scripts

USER rimuser

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $GAME_PORT/udp
EXPOSE $GAME_PORT/tcp

# Make a volume
# contains configs and world saves
VOLUME /rimworld

CMD ["/scripts/start.sh"]
