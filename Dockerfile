FROM flavienb/tensorflow-cuda:10.2-cudnn7-devel-ubuntu18.04-build

RUN rm -rf /root/.cache
RUN ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

# Install TF
RUN python3.7 -m pip install /tmp/tensorflow_pkg/tensorflow-2.3.2-cp37-cp37m-linux_x86_64.whl
