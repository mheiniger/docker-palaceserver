FROM ubuntu:14.04.4

# Enable 32Bit programs
RUN dpkg --add-architecture i386 && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install libc6:i386 -yq

COPY app /app/
COPY entrypoint.sh /app/

EXPOSE 9998 9990

CMD ["/app/entrypoint.sh"]
