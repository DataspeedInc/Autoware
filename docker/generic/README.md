# Autoware Docker
To use the Autoware Docker, first make sure the NVIDIA drivers, Docker and nvidia-docker (v2) are properly installed.

[Docker installation](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
[nvidia-docker installation](https://github.com/NVIDIA/nvidia-docker)

## How to Build
```
$ cd Autoware/docker/generic/

# Ubuntu 14.04 (Indigo)
$ sh build.sh indigo nvidia # leave out the 'nvidia' argument if you want to build and intel or nvidia-docker v1 version

# Ubuntu 16.04 (Kinetic)
$ sh build.sh kinetic nvidia # leave out the 'nvidia' argument if you want to build and intel or nvidia-docker v1 version
```

## How to Run
```

# Ubuntu 16.04 (Kinetic)
$ ./run.sh -t latest-kinetic
```

|Option|Default|Description|
|---|---|---|
|-h||Show `Usage: $0 [-t <tag>] [-r <repo>] [-s <Shared directory>]`|
|-t|latest-kinetic|Specify tag|
|-r|autoware/autoware|Specify repo|
|-s|/home/$USER/shared_dir|Specify shared dir|
