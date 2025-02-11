#!/bin/bash

conda create -n kpconv-pt python=3.6
conda activate kpconv-pt
#CUDA 10.1
# conda install -c anaconda cudatoolkit=10.1
# #cuDNN 7.6
# conda install -c anaconda cudnn=7.6
sudo apt update
sudo apt install python3-dev python3-pip python3-tk
#PyTorch 1.6.0
#conda install pytorch==1.4.0 torchvision==0.5.0 cudatoolkit=10.1 -c pytorch
#conda install -c pytorch==1.4.0 torchvision==0.5.0 cudatoolkit=10.1 -c pytorch -c conda-forge
# pip install torch==1.4.0 torchvision==0.5.0 -f https://download.pytorch.org/whl/cu117/torch_stable.html
# cd ..
#cd .. 
#ls
##Docker  boot  etc   init  lib32  libx32      media  opt   root  sbin  srv  tmp  var
##bin     dev   home  lib   lib64  lost+found  mnt    proc  run   snap  sys  usr
cd ~/repo/KPConv-PyTorch
pip install -r requirements.txt

cd cpp_wrappers
sh compile_wrappers.sh

#############
# Docker Env #
#############

# sudo docker build -f Dockerfile . -t kpconvpt

# sudo docker run --ipc=host -it --gpus 'all,"capabilities=compute,utility,graphics"' -v /home/steven:/container/ kpconvpt:latest /bin/bash

# cd /container/repo/KPConv-PyTorch/cpp_wrappers
# sh compile_wrappers.sh

# cd ..
# export DISPLAY=:0.0
# python3 visual.py
