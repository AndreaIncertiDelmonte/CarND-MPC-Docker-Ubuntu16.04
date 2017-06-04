##################################################################################
#
# Docker image to run Udacity SDC-ND Term 2 Project 5 MPC Model Predictive control
#
# Original image https://github.com/udacity/CarND-MPC-Quizzes/blob/master/Dockerfile
#
##################################################################################

FROM ubuntu:16.04

LABEL maintainer https://github.com/AndreaIncertiDelmonte

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    gfortran \
    cmake \
    make \
    pkg-config \
    unzip \
    git \
    ca-certificates \
    wget \
    cppad \
    libssl-dev \
    libuv1-dev \
    cppad \
    python-matplotlib \
    python-tk \
    python2.7-dev \
    && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src

# IPOPT
COPY install_ipopt.sh .
RUN wget --no-check-certificate https://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.7.zip && unzip Ipopt-3.12.7.zip && rm Ipopt-3.12.7.zip
RUN bash install_ipopt.sh Ipopt-3.12.7

# UWEBSOCKETS
COPY uWebSockets/ ./uWebSockets
RUN cd uWebSockets && \ 
    git checkout e94b6e1 && \ 
    mkdir build && \ 
    cd build && \
    cmake .. && \ 
    make && \ 
    make install && \
    ln -s /usr/lib64/libuWS.so /usr/lib/libuWS.so

ENV MPLBACKEND "agg"

WORKDIR /src/second_term


