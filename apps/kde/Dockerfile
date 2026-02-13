ARG BASE_IMAGE=ghcr.io/cryptic-stack/octal-neko/base:latest
FROM $BASE_IMAGE

#
# install kde
RUN set -eux; apt-get update; \
    apt-get install -y --no-install-recommends kde-full kwin-x11 sudo; \
    #
    # add user to sudoers
    usermod -aG sudo octal; \
    echo "octal:octal" | chpasswd; \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers; \
    # clean up
    apt remove xserver-xorg-legacy -y; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#
# disable autolock
RUN kwriteconfig5 --file /home/octal/.config/kscreenlockerrc --group Daemon --key Autolock false; \
    chown octal:octal /home/octal/.config/kscreenlockerrc

#
# copy configuation files
COPY supervisord.conf /etc/neko/supervisord/kde.conf


