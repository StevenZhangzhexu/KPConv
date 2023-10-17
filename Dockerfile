# FROM nvidia/cuda:10.2-devel-ubuntu18.04
#FROM nvidia/cuda:11.0.3-devel-ubuntu18.04
# FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
# FROM nvidia/cuda:10.2-cudnn8-runtime-ubuntu18.04



# RUN rm /etc/apt/sources.list.d/cuda.list
# RUN rm /etc/apt/sources.list.d/nvidia-ml.list
# RUN apt-key del 7fa2af80
# RUN apt-get update && apt-get install -y --no-install-recommends wget
# RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb
# RUN dpkg -i cuda-keyring_1.0-1_all.deb
# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

#FROM nvidia/cuda:11.1.1-devel-ubuntu20.04

# FROM ubuntu:20.04
# LABEL description="Base docker image with CUDA 10.1 and cuDNN 7.6 for developing and performing compute in containers on NVIDIA GPU."
# LABEL maintainer="Vlad Klim, vladsklim@gmail.com"

# # Packages versions
# ENV CUDA_VERSION=10.1.243 \ 
#     CUDA_PKG_VERSION=10-1=10.1.243-1 \
#     NCCL_VERSION=2.4.8 \
#     CUDNN_VERSION=7.6.5.32

# # BASE
# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends gnupg2 curl ca-certificates && \
#     curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
#     echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
#     echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
#     apt-get purge --autoremove -y curl && \
#     rm -rf /var/lib/apt/lists/*


# # RUN \
# #     # Update nvidia GPG key
# #     rm /etc/apt/sources.list.d/cuda.list && \
# #     rm /etc/apt/sources.list.d/nvidia-ml.list && \
# #     apt-key del 7fa2af80 && \
# #     apt-get update && apt-get install -y --no-install-recommends wget && \
# #     wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb && \
# #     dpkg -i cuda-keyring_1.0-1_all.deb && \
# #     apt-get update

# # RUNTIME AND DEVEL CUDA
# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends cuda-cudart-$CUDA_PKG_VERSION cuda-compat-10-1 \
#                                                cuda-libraries-$CUDA_PKG_VERSION cuda-nvtx-$CUDA_PKG_VERSION libcublas10=10.2.1.243-1 \
#                                                libnccl2=$NCCL_VERSION-1+cuda10.1 \
#                                                cuda-nvml-dev-$CUDA_PKG_VERSION cuda-command-line-tools-$CUDA_PKG_VERSION \
#                                                cuda-libraries-dev-$CUDA_PKG_VERSION cuda-minimal-build-$CUDA_PKG_VERSION \
#                                                libnccl-dev=$NCCL_VERSION-1+cuda10.1 libcublas-dev=10.2.1.243-1 && \
#     ln -s cuda-10.1 /usr/local/cuda && \
#     apt-mark hold libnccl2 && \
#     rm -rf /var/lib/apt/lists/*

# ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs

# # RUNTIME AND DEVEL CUDNN7
# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends libcudnn7=$CUDNN_VERSION-1+cuda10.1 libcudnn7-dev=$CUDNN_VERSION-1+cuda10.1 && \
#     apt-mark hold libcudnn7 && \
#     rm -rf /var/lib/apt/lists/*

# # Required for nvidia-docker v1
# RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
#     echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

# ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH} \
#     LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

# # nvidia-container-runtime
# ENV NVIDIA_VISIBLE_DEVICES=all \
#     NVIDIA_DRIVER_CAPABILITIES=compute,utility \
#     NVIDIA_REQUIRE_CUDA="cuda>=10.1 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=410,driver<411 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=439,driver<441"

# CMD ["bash"]



# RUN : \
#     && apt-get update \
#     && apt-get install -y --no-install-recommends software-properties-common \
#     && add-apt-repository -y ppa:deadsnakes \
#     && apt-get install -y --no-install-recommends python3.8-venv  python3.8-dev \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/* \
#     && :

# # RUN python3.8 -m venv /venv
# ENV PATH=/venv/bin:$PATH

# ENV FORCE_CUDA 1
# ENV TORCH_CUDA_ARCH_LIST "3.5 5.2 6.0 6.1 7.0+PTX"

# COPY docker/install_system.sh install_system.sh
# RUN bash install_system.sh

# COPY docker/install_python.sh install_python.sh
# RUN bash install_python.sh gpu && rm -rf /root/.cache

# ENV WORKDIR=/tp3d
# WORKDIR $WORKDIR

# # COPY pyproject.toml pyproject.toml
# # COPY torch_points3d/__init__.py torch_points3d/__init__.py
# # COPY README.md README.md

# RUN pip3 install . && rm -rf /root/.cache

# COPY . .




FROM nvidia/cuda:11.1.1-devel-ubuntu20.04

# Set Debian frontend to non interactive
ARG DEBIAN_FRONTEND=noninteractive

# Start from clean distro with proper Timezone
RUN apt-get update 
RUN apt-get dist-upgrade -y 
RUN apt-get autoremove
    
RUN apt-get install -y --no-install-recommends tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Singapore /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata


# RUN apt-get update
# RUN apt-get install -y nvidia-container-toolkit
# General packages needed by the other build steps
RUN apt-get update 
RUN apt-get install -y --no-install-recommends apt-utils debconf-utils bash lsb-release
RUN apt-get update 
RUN apt-get install -y --no-install-recommends git openssh-client ca-certificates gnupg curl wget file

# Python Python and python extensions
RUN apt-get clean 
RUN apt-get update 
RUN apt-get install -y apt-transport-https
RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
    gcc \
    ninja-build \
    python3-dev \
    python3-matplotlib \
    python3-numpy \
    python3-packaging \
    python3-pandas \
    python3-pip \
    python3-tk \
    python3-venv \
    sshfs \
    tcpreplay

# Set bash the default shell
SHELL ["/bin/bash", "-c"]

# RUN pip3 install numpy
# RUN pip3 install -U scikit-learn
RUN pip3 install configparser pandas tqdm
RUN pip3 install torch==1.8.0+cu111 torchvision==0.9.0+cu111 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html

RUN pip3 install numpy==1.19.5 
RUN pip3 install scikit-learn==0.24.0
RUN pip3 install PyYAML 
RUN pip3 install matplotlib 
RUN pip3 install mayavi
RUN pip3 install laspy[lazrs,laszip]
# RUN pip3 install open3d

# Install Open3D system dependencies and pip
RUN apt-get update && apt-get install --no-install-recommends -y \
    libegl1 \
    libgl1 \
    libgomp1 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Open3D from the PyPI repositories
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir --upgrade open3d

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get update && apt-get install libgl1
RUN pip3 install pyqt5

