#
# Pyrit Dockerfile
#
# https://github.com/
#

# Pull base image, further modified by Gyfer Lim to incorperate Cuda11-4, Ubuntu20.04.
FROM nvidia/cuda:11.4.0-devel-ubuntu20.04



ENV PYRIT_VERSION v0.5.0

# Update & install packages for Pyrit
RUN apt-get update && 
    apt-get install -y python2.7 && \          # Pyrit need to run compile with pythong2.7 or else will break
    ln -s /usr/bin/python2 /usr/bin/python     # create Sympbolic link to "lock into" python2.7
    apt-get install -y curl unzip python2 python2-dev  python-is-python2 libssl-dev libpcap-dev zlib1g-dev

# Pyrit v0.5.0 does not work with scapy 2.4
# pip is no longer availabe for python 2.7, but available externally
WORKDIR /opt/pip2                              # pip is no longer availabe for python 2.7
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
RUN python /opt/pip2/get-pip.py                # this will compile and install pip in Ubuntu 20.04 with python 2.7
RUN pip install scapy==2.3.3 \
    psycopg2-binary                            # will install just psycopg2-binary file         

#Get Pyrit
WORKDIR /build
ADD https://github.com/JPaulMora/Pyrit/releases/download/${PYRIT_VERSION}/Pyrit-${PYRIT_VERSION}.zip Pyrit-${PYRIT_VERSION}.zip
RUN unzip Pyrit-${PYRIT_VERSION}.zip

#ENV PATH /build:$PATH
ENV PYTHONPATH /usr/local/lib/python2.7/dist-packages

#Cuda fix                                      # Cuda11-4 does seem to require this fix 
#RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
#ENV LD_LIBRARY_PATH /usr/local/cuda/lib64/stubs/:$LD_LIBRARY_PATH

#Define AESNI suggested by Grezzo
RUN sed -i "s/COMPILE_AESNI/COMPILE_AESNIX/" cpyrit/_cpyrit_cpu.c    # if not will have aesni error when compiling

#All setup.py need to manually corrected or else the build will fail. 
#Weirdly just with () and {}
#copy over updated setup.py
COPY setup.py .
COPY modules/cpyrit_cuda/setup.py modules/cpyrit_cuda/setup.py
COPY modules/cpyrit_opencl/setup.py modules/cpyrit_opencl/setup.py

# Compiling pyrit
RUN python setup.py build && \
    python setup.py install

#Compiling Pyrit-cuda
RUN cd modules/cpyrit_cuda && \
    python setup.py build && \                ##Compiling Pyrit-Cuda for CUDA capable CPU
    python setup.py install

#Compiling Pyrit-OpenCL , utilizing 
RUN cd /build/modules/cpyrit_opencl && \
    python setup.py build && \                ##Compiling Pyrit-OpenCL to take advanctage of Intel CPU/GPU OpenCL runtime. AMD too.
    python setup.py install

WORKDIR /root

CMD ["/bin/bash"]
