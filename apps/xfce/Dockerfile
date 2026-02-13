ARG BASE_IMAGE=ghcr.io/cryptic-stack/octal-neko/base:latest
FROM $BASE_IMAGE

#
# install xfce
RUN set -eux; apt-get update; \
    apt-get install -y --no-install-recommends xfce4 xfce4-terminal sudo; \
    #
    # add user to sudoers
    usermod -aG sudo octal; \
    echo "octal:octal" | chpasswd; \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers; \
    # clean up
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#
# copy configuation files
COPY supervisord.conf /etc/neko/supervisord/xfce.conf


