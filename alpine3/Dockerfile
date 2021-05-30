FROM python:3.9.5-alpine3.13

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ARG _ARM_ARCH="arm-unknown-linux-gnu"

RUN apk add --update bash git curl swig gfortran openssl perl
RUN apk add gcc g++ build-base linux-headers


# mecab
RUN cd /tmp \
    && git clone --depth 1 https://github.com/taku910/mecab.git \
    && cd ./mecab/mecab \
    && if [ `uname -m` =  "aarch64" ]; then \
        ./configure --enable-utf8-only --with-charset=utf8 --build=${_ARM_ARCH} --host=${_ARM_ARCH} --target=${_ARM_ARCH}; \
    else \
        ./configure --enable-utf8-only --with-charset=utf8; \
    fi \
    && make \
    && make install \
    && cd ../mecab-ipadic \
    && if [ `uname -m` =  "aarch64" ]; then \
        ./configure --with-charset=utf8 --build=${_ARM_ARCH} --host=${_ARM_ARCH} --target=${_ARM_ARCH}; \
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
