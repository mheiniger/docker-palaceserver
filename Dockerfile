FROM ubuntu:14.04

LABEL org.opencontainers.image.source=https://github.com/mheiniger/docker-palaceserver

# Enable 32Bit programs
RUN dpkg --add-architecture i386 && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install libc6:i386 -yq

COPY app /app/
COPY entrypoint.sh /app/
COPY entrypoint-plugin.sh /app/

EXPOSE 9998 9990

RUN groupadd --gid 1000 palace \
    && useradd --uid 1000 --gid palace --shell /bin/bash --create-home palace

RUN chown -R palace:palace app/palace/logs/
RUN chown -R palace:palace app/palace/avatars

CMD ["/app/entrypoint.sh"]
