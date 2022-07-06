---
toc: true
layout: post
description: Guide to install Caffe in ubuntu
categories: [linux ubuntu]
title:  Installing caffe in Ubuntu 16.04
---

[Caffe](http://caffe.berkeleyvision.org) is a library used in deep learning and specific to computer vision.
They provide an installation guide, which is quite nice. But I experienced problems during the install.
You can [download the source code here](https://github.com/BVLC/caffe)

First follow the [installation instructions](http://caffe.berkeleyvision.org/installation.html).

I had installed cuda 8 library directly from Nvidia and not from ubuntu default repos.

 Then install the following packages:
```shell
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
```

And the BLAS library of your choice, I selected by default ATLAS:
 
```shell
sudo apt-get install libatlas-base-dev
```

As I'm going to work with python, I prepared a virtual environment. This is also because I work with tensorflow and I don't want to mix both.
Assuming you [have installed virtualenv](https://virtualenv.pypa.io/en/stable/):

```ssh 
virtualenv caffe_gpu
source ~/caffe_gpu/bin/activate
```

Assuming your code is in ~/caffe:

```shell 
cd python
for req in $(cat requirements.txt); do pip install $req; done
```

Then, I had to adapt the make file:

```shell 
cp Makefile.config.example Makefile.config
```

adjust:
```init
USE_CUDNN := 1
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial/
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu/hdf5/serial/
```
finally do a symbolic link:

```shell 
sudo ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial_hl.so /usr/lib/x86_64-linux-gnu/libhdf5_hl.so
sudo ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial.so /usr/lib/x86_64-linux-gnu/libhdf5.so
```

Now we can compile as in the instructions:
 
```shell
make all
make test
make runtest
```

Thanks for reading!

