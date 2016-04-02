FROM ubuntu:14.04.4

# Enable 32Bit programs
RUN dpkg --add-architecture i386 && apt-get update && apt-get install libc6:i386 -y

COPY app /app/
COPY entrypoint.sh /app/

EXPOSE 9998 9990

CMD ["/app/entrypoint.sh"]
