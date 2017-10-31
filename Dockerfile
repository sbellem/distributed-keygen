FROM python:2.7.14

RUN apt-get update && apt-get -y install bison flex libgmp-dev libmpc-dev
RUN apt-get update && apt-get -y install libffi-dev libyaml-cpp-dev

RUN wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz
RUN tar -xvf pbc-0.5.14.tar.gz
RUN cd pbc-0.5.14 && ./configure && make && make install

RUN apt-get -y install libgnutls28-dev tmux curl libgcrypt20-dev

RUN mkdir /usr/local/src/dkg
WORKDIR /usr/local/src/dkg

ENV LIBRARY_PATH /usr/local/lib
ENV LD_LIBRARY_PATH /usr/local/lib

COPY DKG-Executable DKG-Executable
COPY PBC PBC
COPY src src

WORKDIR /usr/local/src/dkg/PBC
RUN make clean && make

WORKDIR /usr/local/src/dkg/src
RUN make clean && make && cp node /usr/local/bin/node

# network node config
ARG nodename
#ARG nodeid
#RUN mkdir -p network/$nodename/certs
RUN mkdir -p /etc/khgdkg/pub_certs
WORKDIR /etc/khgdkg
COPY lab/pub_certs pub_certs
COPY lab/$nodename/priv.pem priv.pem
COPY lab/$nodename/pub.pem pub.pem
COPY lab/$nodename/priv.pem priv.pem
COPY lab/$nodename/pub.pem pub.pem
COPY lab/ss512.docker.contlist contlist
COPY DKG-Executable/ss512.system.param system.param
COPY DKG-Executable/ss512.pairing.param pairing.param
