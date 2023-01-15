# alpine-pkg-glibc-arm
## package apk

#Let’s run an alpine container in interactive mode to build our package. The tmp host directory is mapped to the packager user home directory.

<code data-enlighter-language="raw" class="EnlighterJSRAW">podman run --rm -it -v "$(pwd)/tmp:/home/packager" alpine:3.15 sh</code>

 then open an sh as packager user

<code data-enlighter-language="raw" class="EnlighterJSRAW">sudo -u packager sh</code>

Now generate a pair of keys. Follow this step only for the first package as we can reuse the same keys for all other packages we need to build.

<code data-enlighter-language="raw" class="EnlighterJSRAW">abuild-keygen -a -i</code>

    ~/.abuild $ pwd
    /home/packager/.abuild
    ~/.abuild $ ls -l
    total 12
    -rw-r--r--    1 packager packager        64 Jan 15 04:57 abuild.conf
    -rw-------    1 packager packager      1679 Jan 15 04:57 packager-63c387b1.rsa
    -rw-r--r--    1 packager packager       451 Jan 15 04:57 packager-63c387b1.rsa.pub

Now need something to build, so let’s quickly create a APKBUILD file to build reposerve :
/home/packager/glibc/main/glibc/APKBUILD

<code data-enlighter-language="raw" class="EnlighterJSRAW">cd /home/packager/glibc/main/glibc</code>

REPODEST is set to add an additional level
in package directories to represent alpine version

<code data-enlighter-language="raw" class="EnlighterJSRAW">REPODEST=~/packages/3.16 abuild -r</code>

and after a few minutes you should have the reposerve binary packaged in /home/packager/packages/3.16/main/aarch64/.apk

## Build docker
    FROM alpine:3.15
    # you should change this line to match the keys' filenames generated on previous step
    COPY .abuild/packager-63c387b1.rsa.pub a.abuild/packager-63c387b1.rsa /etc/apk/keys/
    COPY packages/3.16/main/aarch64/glibc-2.35-r0.apk /tmp/
    RUN apk add  /tmp/glibc-2.35-r0.apk

## Releases

See the [releases page](https://github.com/zhanglt/alpine-pkg-glibc-arm/releases) for the latest download links. If you are using tools like `localedef` you will need the `glibc-bin` and `glibc-i18n` packages in addition to the `glibc` package.

## Installing

The current installation method for these packages is to pull them in using `wget` or `curl` and install the local file with `apk`:

    cp /home/packager/.abuild/*.rsa.pub /etc/apk/keys/
    wget https://github.com/zhanglt/alpine-pkg-glibc-arm/releases/download/2.35-r0/glibc-2.35-r0.apk
    apk add glibc-2.35-r0.apk

## Locales

You will need to generate your locale if you would like to use a specific one for your glibc application. You can do this by installing the `glibc-i18n` package and generating a locale using the `localedef` binary. An example for en_US.UTF-8 would be:

    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-bin-2.35-r0.apk
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-i18n-2.35-r0.apk
    apk add glibc-bin-2.35-r0.apk glibc-i18n-2.35-r0.apk
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8
