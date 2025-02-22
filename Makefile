CONTAINER_NAME=iany/vhdl:latest

.PHONY: docker_build docker_run docker_run_hostv

docker_build:
		docker build \
    -t $(CONTAINER_NAME) .

docker_run:
		docker run --rm -it --privileged $(CONTAINER_NAME) bash

docker_run_hostv:
		docker run --rm -it --privileged \
		-v "$$(pwd):/home/app" \
		$(CONTAINER_NAME) bash