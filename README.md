# Ultimate Machine Learning development Docker image (GPU-aware)

This repo cointains resources to build image that can be used to run cotnainers for Machine Learning prototyping and development. If you run it with `nvidia-docker` you can take advantage of your GPUs! It contains

- TensorFlow 1.0.0rc1
- tensorflow-gpu (1.0.0rc1)
- python 3.5
- jupyter (1.0.0)
- Keras (1.2.1)
- edward (1.2.1)

## Get it or build it

I will push to `t0mk/ultimate-mldev` from time to time but it's probably best if you build/customize yourself.

## GPUs Yeah!!1

If you want to use GPU with TF or Theano, you must install nvidia-docker and all its prerequisities. Best place to start is probably this: https://github.com/NVIDIA/nvidia-docker/wiki/Installation.

## Run it

You can run it for example like

```
nvidia-docker run -it \
    --restart=always \
    --name=mldev \
    -p 127.0.0.1:8888:8888 \
    -v /home/tomk/notebooks:/notebooks/tomk \
    -v /home/tomk/.ipython:/root/.ipython \
    -v /home/tomk/.jupyter:/root/.jupyter \
    -v /home/tomk/.jupytercrap:/root/.local/share/jupyter \
    t0mk/ultimate-mldev /bin/bash
```

And then in the container:

```
root@94f93087f483:~# jupyter notebook
```

It will print an authentication URL. It will be something like `http://localhost:8888/?token=a1ddfbd012cf36e2f85025281810cd5f245825fd7db567f0`. Paste in your browser and you can start writing notebooks.

### Why not just run jupyter from docker command

If I do it that way, Python3 kernels crash on first executed statement.


## Refs

I took the best parts from https://github.com/senbon/dockerfiles


- 
