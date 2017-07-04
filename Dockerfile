FROM mhart/alpine-node:8.1
MAINTAINER Paul Allen paulallen87555@gmail.com
USER root
WORKDIR /

COPY yarn.lock \
     bower.json \
     index.html \
     index.js \
     manifest.json \
     package.json \
     polymer.json \
     service-worker.js \
     sw-precache-config.js \
     bin/ \
     src/ \
     /app/
COPY bin/ /app/bin/
COPY src/ /app/src/

ENV NODE_ENV="production" \
    FRONTEND_BUNDLE="es6-bundled" \
    ACL_ENABLED="0" \
    DEBUG="chaturbate:*" \
    LIGHTHOUSE_CHROMIUM_PATH="/usr/bin/chromium-browser" \
    DEBIAN_FRONTEND="noninteractive" \
    DEBCONF_NONINTERACTIVE_SEEN="true" \
    DISPLAY=":99.0" \
    SCREEN_WIDTH="750" \
    SCREEN_HEIGHT="1334" \
    SCREEN_DEPTH="24" \
    PATH="/app/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN echo "http://dl-2.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories && \
    echo "http://dl-2.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update --no-cache && \
    apk add --no-cache \
        zlib-dev \
        chromium \
        xvfb \
        xorg-server \
        dbus \
        ttf-freefont \
        mesa-dri-swrast \
        git \
        grep \
        && \
    sh /app/bin/build-prod.sh && \
    mv /app/build /build

RUN apk del --purge --force \
        curl \
        make \
        gcc \
        g++ \
        python \
        linux-headers \
        binutils-gold \
        gnupg \
        git \
        zlib-dev \
        apk-tools \
        libc-utils \
        && \
    rm -rf /app && \
    rm -rf /var/lib/apt/lists/* \
        /root/.cache \
        /var/cache/apk/* \
        /usr/local/share/.cache \
        /usr/share/man \
        /tmp/* \
        /usr/lib/node_modules/npm/man \
        /usr/lib/node_modules/npm/doc \
        /usr/lib/node_modules/npm/html \
        /usr/lib/node_modules/npm/scripts

EXPOSE 8080
EXPOSE 9090
VOLUME /build/certs
VOLUME /build/config
WORKDIR /build
CMD ["yarn", "start"]
