FROM limingxinleo/docker-workspace:php-8.0

ENV USER_NAME=${user_name:-"hyperf"}
ENV USER_EMAIL=${user_email:-"group@hyperf.io"}

RUN git config --global user.name ${USER_NAME} \
    && git config --global user.email ${USER_EMAIL}

WORKDIR /root/workspace

ENTRYPOINT ["/bin/zsh"]
