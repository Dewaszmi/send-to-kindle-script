FROM linuxserver/calibre:latest

WORKDIR /app

COPY ./bin/send-to-kindle /app/send-to-kindle
RUN chmod +x /app/send-to-kindle

ENTRYPOINT [ "/app/send-to-kindle" ]