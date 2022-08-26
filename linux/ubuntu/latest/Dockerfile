FROM ubuntu:latest

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex \
    && apt-get update \
    && apt-get install -y tzdata curl wget sudo \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata
