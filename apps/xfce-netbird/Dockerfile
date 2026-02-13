ARG BASE_IMAGE=ghcr.io/cryptic-stack/octal-neko/base:latest
FROM $BASE_IMAGE

#
# install xfce + netbird
RUN set -eux; apt-get update; \
    apt-get install -y --no-install-recommends xfce4 xfce4-terminal sudo; \
    #
    # install netbird from official package repository
    curl -fsSL https://pkgs.netbird.io/install.sh | bash; \
    apt-get update; \
    apt-get install -y --no-install-recommends netbird; \
    #
    # add user to sudoers
    usermod -aG sudo neko; \
    echo "neko:neko" | chpasswd; \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers; \
    # clean up
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#
# copy configuation files
COPY supervisord.conf /etc/neko/supervisord/xfce.conf


