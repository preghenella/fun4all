#! /usr/bin/env bash

### chech if a command has been supplied
if [ ! -z "$1" ]; then
    exec $@
    exit 0
fi

### check that we have the /app directory mounted volume
if [ ! -d "/app" ]; then
    cat /usr/local/share/README
    exit 1
fi

### install sPHENIX software on new volume
if [ ! -f /app/.installed ]; then
    echo " INFO: new volume detected, start installing sPHENIX software"
    sudo -- bash -c \
	"git clone https://github.com/sPHENIX-Collaboration/Singularity.git /app/Singularity && \
    	cd /app/Singularity && \
	./updatebuild.sh && \
	touch /app/.installed"
fi

cat /usr/local/share/WELCOME
exec /usr/local/bin/singularity shell -B /app/Singularity/cvmfs:/cvmfs /app/Singularity/cvmfs/sphenix.sdcc.bnl.gov/singularity/rhic_sl7_ext.simg
