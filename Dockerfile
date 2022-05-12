FROM ubuntu:latest

EXPOSE 8080/tcp
EXPOSE 8080/udp

RUN mkdir /home/root
RUN mkdir /home/root/app

COPY ./Artwork /home/root/app/Artwork
COPY ./Backend /home/root/app/Backend
COPY ./Frontend-Build /home/root/app/Frontend-Build

# Tensorflow, ffmpeg, libsm6, libxext6 are MTCNN dependencies
RUN apt update -y && apt upgrade -y
RUN apt install -y python3 pip
RUN apt install -y ffmpeg libsm6 libxext6
RUN python3 -m pip install tensorflow mtcnn matplotlib flask

ENV PRODUCTION-MODE=true

CMD cd /home/root/app/Backend && python3 backend.py