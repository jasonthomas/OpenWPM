FROM ubuntu:16.04

COPY . /app


WORKDIR /app
RUN apt-get update && apt-get install sudo
RUN ./install.sh --flash
CMD python demo.py
