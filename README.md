# docker-mecab-neologd-python3

MeCab and NEologd dictionary and Python3 on Docker environment for AppleSilicon and Intel CPU

AppleSilicon と Intel CPU に対応した Mecab と NEologd 辞書と Python3 Docker 環境


## centos8 version

It works.


## alpine3.13 version

Maybe it doesn't work with Apple Silicon
The build of "mecab-python3" will fail.


## Environment

| key | discriptyion | default value |
| :-- | :-- | :-- |
| LANG | locale | "C.UTF-8" |
| TZ | timezone | "Asia/Tokyo" |
| PYTHON_VERSION | install python version (only centos8 version) | "3.9.4" |


