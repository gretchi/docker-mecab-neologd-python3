# docker-mecab-neologd-python3

MeCab and NEologd dictionary and Python3 on Docker environment for AppleSilicon and Intel CPU

AppleSilicon と Intel CPU に対応した Mecab と NEologd 辞書と Python3 Docker 環境


## centos8 version

It works.

Base image: [centos:8](https://hub.docker.com/_/centos)


## alpine3.13 (drafts) version

Maybe it doesn't work with Apple Silicon
The build of "mecab-python3" will fail.

Base image: [python:3.9.5-alpine3.13](https://hub.docker.com/_/python)


## Environment

| key | discriptyion | default value |
| :-- | :-- | :-- |
| LANG | locale | "C.UTF-8" |
| TZ | timezone | "Asia/Tokyo" |
| PYTHON_VERSION | install python version (only centos8 version) | "3.9.5" |

## About this Dockerfile

https://qiita.com/syamamura/items/a53fcbf162fadd352bde
