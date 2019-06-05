+++ 
draft = false
date = 2017-01-03T00:09:12+02:00
title = "Installing caffe in Ubuntu 16.04"
description = ""
slug = "installing-caffe-in-ubuntu-16-04" 
tags = []
categories = []
externalLink = ""
series = []
+++



<a href="http://caffe.berkeleyvision.org">Caffe</a> is a library used in deep learning and specific to computer vision.
They provide an installation guide, which is quite nice. But I experienced problems during the install.
You can download the source code in <a href="https://github.com/BVLC/caffe">https://github.com/BVLC/caffe</a>

First follow the <a href="http://caffe.berkeleyvision.org/installation.html">installation instructions</a>.

I had installed cuda 8 library directly from Nvidia and not from ubuntu default repos.

 Then install the following packages:
<pre class="lang:sh decode:true " >sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev</pre> 

And the BLAS library of your choice, I selected by default ATLAS:
 
<pre class="lang:sh decode:true " >sudo apt-get install libatlas-base-dev </pre> 

As I'm going to work with python, I prepared a virtual environment. This is also because I work with tensorflow and I don't want to mix both.
Assuming you have installed <a href="https://virtualenv.pypa.io/en/stable/">virtualenv</a>:

 
<pre class="lang:c# decode:true " >virtualenv caffe_gpu
source ~/caffe_gpu/bin/activate</pre> 
Assuming your code is in ~/caffe:

 
<pre class="lang:c# decode:true " >cd python
for req in $(cat requirements.txt); do pip install $req; done</pre> 

Then, I had to adapt the make file:

 
<pre class="lang:sh decode:true " >cp Makefile.config.example Makefile.config
#adjust:
USE_CUDNN := 1
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial/
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu/hdf5/serial/</pre> 

finally do a symbolic link:

 
<pre class="lang:sh decode:true " >sudo ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial_hl.so /usr/lib/x86_64-linux-gnu/libhdf5_hl.so
sudo ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial.so /usr/lib/x86_64-linux-gnu/libhdf5.so</pre> 

Now we can compile as in the instructions:
 
<pre class="lang:sh decode:true " >make all
make test
make runtest</pre> 

Thanks for reading!

