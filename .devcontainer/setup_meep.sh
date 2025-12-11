#!/usr/bin/env bash
set -e

apt-get update
apt-get install -y \
    build-essential \
    cmake \
    gfortran \
    libfftw3-dev \
    libhdf5-serial-dev \
    hdf5-tools \
    libpng-dev \
    libz-dev \
    python3-dev \
    python3-pip \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    git

# Instalar mpi
apt-get install -y mpich libmpich-dev

# Descargar e instalar MEEP
cd /opt
git clone https://github.com/NanoComp/meep.git
cd meep

# Compilar MEEP (esto tarda ~5-10 minutos)
./configure --with-python --enable-shared
make -j$(nproc)
make install
ldconfig

# Instalar PyMEEP (bindings Python)
cd python
python3 -m pip install .

# Crear script de arranque de Jupyter
cat << 'EOF' > /usr/local/bin/run_jupyter.sh
#!/bin/bash
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
EOF
chmod +x /usr/local/bin/run_jupyter.sh
