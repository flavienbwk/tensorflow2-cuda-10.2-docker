FROM flavienb/tensorflow-cuda:10.2-cudnn7-devel-ubuntu18.04-build

WORKDIR /app/tensorflow
RUN bash /app/tensorflow/bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
RUN rm -rf /root/.cache

# Install TF
RUN python3.7 -m pip install /tmp/tensorflow_pkg/tensorflow-2.3.2-cp37-cp37m-linux_x86_64.whl
WORKDIR /app
