FROM preghenella/eicenv

USER root

RUN apt-get update && \
    apt-get install -y \
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

RUN git clone https://github.com/sPHENIX-Collaboration/Singularity.git && \
    cd Singularity && \
    ./updatebuild.sh

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

USER ${username}

ENTRYPOINT ["entrypoint.sh"]
