FROM centos:8

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ARG PYTHON_VERSION="3.9.4"
ARG CONFIGURE_BUILD="arm-unknown-linux-gnu"
ARG CONFIGURE_HOST="arm-unknown-linux-gnu"
ARG CONFIGURE_TARGET="arm-unknown-linux-gnu"

RUN yum update -y
RUN yum groupinstall -y "Development Tools"
RUN yum install -y wget openssl-devel libffi-devel bzip2-devel
RUN yum install -y swig


# Install the python
RUN cd /tmp \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make install

RUN ln -s /usr/local/bin/pip3 /usr/local/bin/pip

# mecab-ipadic-neologd
RUN cd /tmp \
    && git clone --depth 1 https://github.com/taku910/mecab.git \
    && cd ./mecab/mecab \
    && if [ `uname -m` =  "aarch64" ]; then \
        ./configure --enable-utf8-only --with-charset=utf8 --build=${CONFIGURE_BUILD} --host=${CONFIGURE_HOST} --target=${CONFIGURE_TARGET}; \
    else \
        ./configure --enable-utf8-only --with-charset=utf8; \
    fi \
    && make \
    && make install \
    && cd ../mecab-ipadic \
    && if [ `uname -m` =  "aarch64" ]; then \
        ./configure --with-charset=utf8 --build=${CONFIGURE_BUILD} --host=${CONFIGURE_HOST} --target=${CONFIGURE_TARGET}; \
    else \
        ./configure --with-charset=utf8; \
    fi \
    && make \
    && make install


# mecab-ipadic-neologd
RUN cd /tmp \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && cd ./mecab-ipadic-neologd \
    && ./bin/install-mecab-ipadic-neologd -n -y


# python package
RUN pip install --no-binary :all: mecab-python3

COPY requirements.txt /tmp
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt


RUN rm -rf /tmp/*

WORKDIR /root/app
