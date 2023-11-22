FROM almalinux:latest
RUN mkdir lab1
COPY script.sh /lab1/script.sh
COPY 1.txt /lab1/1.txt
WORKDIR /lab1/
CMD ["/lab1/script.sh"]
