FROM alpine:3.16
# install essentials apk package
RUN apk add sudo build-base alpine-sdk
# create a packager user and add him to sudo list
RUN adduser -D packager && addgroup packager abuild
RUN echo 'packager ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/packager
