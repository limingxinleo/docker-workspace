# Default Dockerfile
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf-cloud/hyperf/blob/master/LICENSE

FROM hyperf/hyperf:7.2-alpine-v3.9-cli
LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

##
# ---------- env settings ----------
##
# --build-arg timezone=Asia/Shanghai
ARG timezone
ARG username
ARG useremail

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}
ENV USER_NAME=${username:-"hyperf"}
ENV USER_EMAIL=${useremail:-"group@hyperf.io"}

COPY ./install.sh /root

RUN set -ex \
    # update
    && apk update \
    && apk add --no-cache zsh openssh vim gcc cmake g++ make php7-dev \
    # install oh my zsh
    && sh /root/install.sh \
    # install composer
    && cd /tmp \
    && wget https://mirrors.aliyun.com/composer/composer.phar \
    && chmod u+x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer \
    # show php version and extensions
    && php -v \
    && php -m \
    && php --ri swoole \
    #  ---------- some config ----------
    && cd /etc/php7 \
    # - config PHP
    && { \
        echo "upload_max_filesize=100M"; \
        echo "post_max_size=108M"; \
        echo "memory_limit=1024M"; \
        echo "date.timezone=${TIMEZONE}"; \
    } | tee conf.d/99_overrides.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    # - config git
    && git config --global user.name ${USER_NAME} \
    && git config --global user.email ${USER_EMAIL} \
    # - phpx
    && cd /root \
    && git clone https://github.com/swoole/phpx.git \
    && cd phpx \
    && ./build.sh \
    && mv bin/phpx /usr/local/bin/ \
    && cmake . \
    && make -j 4 \
    && make install \
    # ---------- clear works ----------
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"

WORKDIR /root/workspace

VOLUME /root/.ssh

ENTRYPOINT ["/bin/zsh"]
