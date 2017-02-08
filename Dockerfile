FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

LABEL maintainer "tom.to.the.k@gmail.com"

# Install basic programs and dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        byobu \
        cmake \
        curl \
        g++ \
        gcc \
        gfortran \
        git \
        make \
        nano \
        pkg-config \
        rsync \
        unzip \
        wget

# Install basic packages and miscellaneous dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    liblapack-dev \
    libopenblas-dev \
    libzmq3-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-tk


# Install Pillow (PIL) dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libfreetype6-dev \
    libjpeg-dev \
    liblcms2-dev \
    libopenjpeg-dev \
    libpng12-dev \
    libtiff5-dev \
    libwebp-dev \
    zlib1g-dev


# Upgrade pip and setuptools
RUN pip3 install --upgrade \
    setuptools \
    pip


# Install basic Python packages (some of these may already be installed)
RUN pip3 install \
    wheel \
    six \
    ipython \
    jupyter \
    ipdb \
    numpy \
    Pillow \
    scipy \
    matplotlib

# Install development files for HDF5
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libhdf5-dev



# Install general-purpose libraries useful for machine learning in Python
RUN pip3 install \
    h5py \
    PyYAML \
    pandas \
    scikit-learn

# Specify TensorFlow version
ARG TF_VERSION=1.0.0rc1

# Install TensorFlow
RUN pip3 install --upgrade \
    https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-${TF_VERSION}-cp35-cp35m-linux_x86_64.whl


# Install Theano
RUN pip3 install \
    git+git://github.com/Theano/Theano.git@master


# Set up .theanorc configuration file
RUN echo "[global]\ndevice=gpu0\nfloatX=float32 \
          \n\n[dnn.conv]\nalgo_fwd=time_once\nalgo_bwd_data=time_once\nalgo_bwd_filter=time_once \
          \n\n[lib]\ncnmem=0.1" \
    > /root/.theanorc


# Set default working directory and image startup command


# Prepare matplotlib font cache
RUN python3 -c "import matplotlib.pyplot"


# Add alias to `.bash_aliases` so that `python` runs `python3`
RUN echo "alias python=python3" \
    >> /root/.bash_aliases

# Cleanup apt-get
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/blei-lab/edward /edward && \
    sed -i 's/tensorflow>/tensorflow-gpu>/' /edward/setup.py && \
    pip3 install -e /edward

RUN pip3 install keras

WORKDIR "/root"
CMD ["/usr/local/bin/jupyter","notebook"]
