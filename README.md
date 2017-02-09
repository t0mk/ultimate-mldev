# Ultimate Machine Learning development Docker image (GPU-aware)

This repo cointains resources to build image that can be used to run cotnainers for Machine Learning prototyping and development. If you run it with `nvidia-docker` you can take advantage of your GPUs! It contains

- https://github.com/Theano/Theanoo (0.9.0b1)
- tensorflow-gpu (1.0.0rc1)
- python 3.5
- jupyter (1.0.0)
- https://github.com/fchollet/keras (1.2.1)
- https://github.com/blei-lab/edward (1.2.1)

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

It will print an authentication URL. It will be something like `http://localhost:8888/?token=a1ddfbd012cf36e2f85025281810cd5f245825fd7db567f0`. Paste in your browser and you can start writing notebooks at http://localhost:8888/tree?.



## Run it remotely

I actually don't run this container on my laptop, but I have a desktop machine (a "dev node") on LAN, with Docker and sshd (it's ubuntu 16.04 but CoreOS would work too I guess). I run the ultimate-mldev container with `-p 127.0.0.1:8888:8888` (it exposes the container ports to localhost), so I technically can't see the jupyer from my laptop straight away.

I then open ssh tunnel from my localhost:8888 to the devnode:localhost:8888, i.e.:

```
ssh -f -L 8888:localhost:8888 devnode -N
```

That way I don't have to care about security of the jupyter, I just rely on sshd. I can even access it from the outer Internet the same way, if I expose the sshd over (for instance) ngrok (https://ngrok.com/).


### Why not just run jupyter from docker command

If I do it that way, Python3 kernels crash on first executed statement.


## Refs

I took the best parts from https://github.com/senbon/dockerfiles


- 
