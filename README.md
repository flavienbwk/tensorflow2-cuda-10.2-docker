# TensorFlow 2 - CUDA 10.2 - Docker

Tensorflow 2.3, CUDA 10.2, CUDNN 7, Ubuntu 18.04, Docker compatible image to run with your CUDA 10.2 GPU through Python 3.7

- This image was compiled on a 46-cores, 240G of RAM server in 3979 seconds (**66 minutes**)  
  :information_source: This build cost 2.80€ and is provided to you for free !

## Use

Enjoy my pre-compiled image

```bash
docker pull flavienb/tensorflow-cuda:10.2-cudnn7-devel-ubuntu18.04
```

## Build

```bash
docker build -t flavienb/tensorflow-cuda:10.2-cudnn7-devel-ubuntu18.04-build -f Dockerfile.build . # 18Gb of Docker image
docker build -t flavienb/tensorflow-cuda:10.2-cudnn7-devel-ubuntu18.04 . # ~6Gb Docker image
```
