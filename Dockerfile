FROM nvidia/cuda:8.0-cudnn7-devel

MAINTAINER Michael Wright <mkwright@gmail.com> 

RUN apt-get update && \
    apt-get install -y curl build-essential libpng12-dev libffi-dev  && \
    apt-get clean && \
    rm -rf /var/tmp /tmp /var/lib/apt/lists/*

RUN curl -sSL -o installer.sh https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    bash /installer.sh -b -f && \
    rm /installer.sh

ENV PATH "$PATH:/root/anaconda3/bin"

EXPOSE 8888 6006
VOLUME /notebooks
WORKDIR "/notebooks"

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]

ADD environment.yml /environment.yml
RUN conda env update -f /environment.yml
