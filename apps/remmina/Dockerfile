ARG BASE_IMAGE=ghcr.io/cryptic-stack/octal-neko/base:latest
FROM $BASE_IMAGE

# install remmina
RUN set -eux; apt-get update; \
    apt-get install -y --no-install-recommends \
      remmina-plugin-rdp remmina-plugin-vnc \
      # remmina-plugin-x2go # not in bullseye
      remmina-plugin-spice remmina-plugin-nx; \
    # clean up
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# copy configuation files
COPY supervisord.conf /etc/neko/supervisord/remmina.conf
COPY --chown=octal remmina.pref /home/octal/.config/remmina/remmina.pref
COPY --chown=octal rdp.remmina spice.remmina vnc.remmina /home/octal/.local/share/remmina/
COPY run-remmina.sh /usr/bin/run-remmina.sh
ENV REMMINA_URL=
ENV REMMINA_PROFILE=

