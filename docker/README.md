# Docker Images for iMoCo Recon (python version)

## CPU container
```
docker build docker/imoco-cpu -t imoco-docker-cpu
docker container run -it -v <data_location>:/data imoco-docker-cpu sh
```

## GPU container
```
docker build docker/imoco-gpu -t imoco-docker-gpu
docker container run --gpus all -it -v <data_location>:/data imoco-docker-gpu sh
```

follow imoco_py/README.md to run imoco reconstruction
