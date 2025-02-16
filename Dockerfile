FROM ubuntu:22.04

# Set environment variables to non-interactive (this will prevent some prompts)
ENV DEBIAN_FRONTEND=non-interactive


# Declare a build argument. Set a default value if desired.
ARG CLONE=false


RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    make \
    gnat

# Use the argument inside a RUN command
RUN if [ "$CLONE" = "true" ]; then \
      echo "CLONE is true, installing extra package..."; \
      curl https://github.com/gcc-mirror/gcc/archive/refs/tags/releases/gcc-11.5.0.tar.gz
      tar -xf gcc-11.5.0.tar.gz
      git clone https://github.com/ghdl/ghdl.git
    else \
      echo "CLONE is false, skipping extra package installation."; \
    fi


RUN mkdir build && \
    cd build && \
    ../configure --with-gcc=gcc-releases-gcc-11.5.0/ --prefix=/usr/local && \
    make copy-sources && \
    mkdir gcc-objs; cd gcc-objs && \
    gcc-releases-gcc-11.5.0/configure --prefix=/usr/local --enable-languages=c,vhdl \
    --disable-bootstrap --disable-lto --disable-multilib --disable-libssp \
    --disable-libgomp --disable-libquadmath && \
    make -j2 && make install && \
    cd /path/to/ghdl/source/dir/build && \
    make ghdllib && \
    make install