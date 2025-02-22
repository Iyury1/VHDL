FROM ubuntu:24.04

# Set environment variables to non-interactive (this will prevent some prompts)
ENV DEBIAN_FRONTEND=non-interactive


# Declare a build argument. Set a default value if desired.
ARG CLONE=true


RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    ca-certificates \
    make \
    git \
    tar \
    gnat

WORKDIR /home/dev/

# Use the argument inside a RUN command
RUN if [ "$CLONE" = "true" ]; then \
      echo "CLONE is true, installing extra package..."; \
      curl -L -O https://github.com/ghdl/ghdl/releases/download/v4.1.0/ghdl-gha-ubuntu-22.04-gcc.tgz ; \
      mkdir /opt/ghdl/; \
      tar -xf ghdl-gha-ubuntu-22.04-gcc.tgz -C /opt/ghdl/; \
    else \
      echo "CLONE is false, skipping extra package installation."; \
    fi

# RUN curl -L -O https://gtkwave.sourceforge.net/gtkwave-gtk3-3.3.121.tar.gz &&\
#     tar -xf gtkwave-gtk3-3.3.121.tar.gz

# Packages needded for GTKWave
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    meson \
    gperf \
    flex \
    desktop-file-utils \
    libgtk-3-dev \
    libgtk-4-dev \
    libbz2-dev \
    libjudy-dev \
    libgirepository1.0-dev

RUN git clone https://github.com/ghdl/ghdl.git && \
    cd ghdl && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

RUN cd /opt && \
    git clone "https://github.com/gtkwave/gtkwave.git" && \
    cd gtkwave && \
    meson setup build && \
    cd build && \
    meson install

RUN echo "export PATH=$PATH:/opt/ghdl/bin" >> ~/.bashrc

# RUN ls -la && \
#     pwd && \
#     echo "hello" && \
#     cd /opt/ghdl && \
#     mkdir build && \
#     cd build && \
#     ../configure --prefix=/usr/local && \
#     cd .. && \
#     make ghdllib && \
#     make install