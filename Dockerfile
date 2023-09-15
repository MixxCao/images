FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# 更新并安装必要的软件包
RUN apt-get update && apt-get install -y python3.9 python3.9-dev python3-pip build-essential wget flex bison unzip libglib2.0-dev


# 使用清华镜像源安装Python依赖包
# RUN mkdir ~/.pip && echo "[global]" > ~/.pip/pip.conf && \
#     echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> ~/.pip/pip.conf
RUN mkdir ~/.pip && echo "[global]" > ~/.pip/pip.conf && \
    echo "index-url = https://mirrors.aliyun.com/pypi/simple" >> ~/.pip/pip.conf && \
    pip3 install --upgrade pip &&\
    pip3 install conan==1.59.0 numpy==1.24.2

# 下载并安装bazel 5.3.0
RUN wget -q https://github.com/bazelbuild/bazel/releases/download/5.3.0/bazel-5.3.0-installer-linux-x86_64.sh && \
    chmod +x bazel-5.3.0-installer-linux-x86_64.sh && \
    ./bazel-5.3.0-installer-linux-x86_64.sh && \
    rm bazel-5.3.0-installer-linux-x86_64.sh

# 安装gcc和g++
RUN apt-get install -y gcc-9 g++-9 &&\
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100 && \
    wget -q https://github.com/Kitware/CMake/releases/download/v3.22.2/cmake-3.22.2-linux-x86_64.sh  && \
    chmod +x cmake-3.22.2-linux-x86_64.sh  && \
    ./cmake-3.22.2-linux-x86_64.sh --skip-license --prefix=/usr/local  && \
    rm cmake-3.22.2-linux-x86_64.sh


