FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

RUN apt-get update && apt-get install python3.7 python3-dev libpython3.7-dev python3-pip cmake git g++ gnupg curl -y

ENV DEBIAN_FRONTEND noninteractive
ENV CI_BUILD_PYTHON=python
ENV TF_NEED_CUDA=1
ENV TF_CUDA_VERSION=10.2
ENV TF_CUDNN_VERSION=7
# TensorRT was checked, but challenge of getting the ScanComplete code to work on this was to large for the remaining project time - - > could be a future approach
ENV TF_NEED_TENSORRT=0
# Compute capability - look up on https://developer.nvidia.com/cuda-gpus
ENV TF_CUDA_COMPUTE_CAPABILITIES=6.1

RUN apt install locales -y
RUN sed -i -e 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
        LANGUAGE=en_US:en \
        LC_ALL=en_US.UTF-8

## Further install

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES video,compute,utility
ENV CUDA_VISIBLE_DEVICES 0

# TF install for CUDA 10.2
## Bazel install
RUN python3.7 -m pip install numpy wheel
RUN python3.7 -m pip install keras_preprocessing --no-deps
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
RUN mv bazel.gpg /etc/apt/trusted.gpg.d/
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt update && apt install bazel bazel-3.1.0 -y

WORKDIR /app
RUN git clone https://github.com/tensorflow/tensorflow.git

WORKDIR /app/tensorflow
RUN git checkout r2.3
RUN ./configure
RUN bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package
