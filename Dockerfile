FROM ubuntu

USER root

RUN apt-get update && \
    apt-get install -y \
    sudo \
    python \
    dh-autoreconf \
    build-essential \
    git \
    libarchive-dev \
    libglu1-mesa-dev freeglut3-dev mesa-common-dev mesa-utils

RUN git clone https://github.com/sylabs/singularity.git && \
    cd singularity && \
    git fetch --all && \
    git checkout 2.5.0 && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd - && \
    rm -rf singularity

RUN useradd --create-home docker && \
    passwd -d docker && \
    usermod -aG sudo docker

RUN echo "Europe/Geneva" > /etc/localtime
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY README /usr/local/share/README
COPY WELCOME /usr/local/share/WELCOME

USER docker
ENV HOME /home/docker
ENV USER docker
WORKDIR /home/docker

ENTRYPOINT ["entrypoint.sh"]

CMD [""]