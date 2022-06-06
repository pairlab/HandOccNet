FROM nvidia/cudagl:11.3.0-devel-ubuntu18.04

# install basic libs
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    wget \
    freeglut3-dev

WORKDIR /HandOccNet

# COPY . .

# set up conda
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O ./anaconda.sh &&\
  /bin/bash ./anaconda.sh -b -p /opt/conda &&\
  /opt/conda/bin/conda init bash &&\
  rm ./anaconda.sh

RUN /opt/conda/bin/conda create -n handoccnet python=3.8
RUN /opt/conda/bin/conda run -n handoccnet pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113 
RUN /opt/conda/bin/conda run -n handoccnet pip install einops chumpy opencv-python pycocotools pyrender tqdm
# RUN /opt/conda/bin/conda run -n handoccnet python demo.py --gpu 0

COPY . .
