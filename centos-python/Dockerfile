FROM centos:7.2.1511

LABEL name="centos-python"
LABEL version="2.7.12.1557050764"

# Install yum dependencies
RUN yum -y update && \
    yum groupinstall -y development && \
    yum install -y \
    bzip2-devel \
    freetype-devel \
    libjpeg-turbo-devel \
    git \
    hostname \
    openssl \
    openssl-devel \
    sqlite-devel \
    sudo \
    tar \
    curl \
    zlib-dev \
    python-devel \
    mysql-devel

RUN yum clean all

ENV LANG zh_CN.UTF-8

# gpg: key 18ADD4FF: public key "Benjamin Peterson <benjamin@python.org>" imported
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF

ENV PYTHON_VERSION 2.7.12

RUN set -x \
    && mkdir -p /usr/src/python \
    && curl -SL "http://sep-protected.oss-cn-beijing.aliyuncs.com/rd/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
    && curl -SL "http://sep-protected.oss-cn-beijing.aliyuncs.com/rd/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc \
    && gpg --verify python.tar.xz.asc \
    && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
    && rm python.tar.xz* \
    && cd /usr/src/python \
    && ./configure --prefix=/usr/local/python$PYTHON_VERSION --sysconfdir=/etc/python$PYTHON_VERSION --libdir=/usr/local/python$PYTHON_VERSION/lib \
    && make -j$(nproc) \
    && make install \
    && ldconfig

RUN mv /usr/bin/python /usr/bin/python2.7.5
RUN ln -s /usr/local/python$PYTHON_VERSION/bin/python /usr/bin/python
RUN sed -i 's/python/python2.7.5/g' /usr/bin/yum
RUN sed -i 's/python/python2.7.5/g' /usr/libexec/urlgrabber-ext-down
RUN curl -SL 'http://sep-protected.oss-cn-beijing.aliyuncs.com/rd/get-pip.py' | python \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && rm -rf /usr/src/python

RUN ln -s /usr/local/python$PYTHON_VERSION/bin/pip /usr/bin/pip
# Add ustc pypi mirror
ADD etc/pip.conf /root/.pip/pip.conf

# install "virtualenv", since the vast majority of users of this image will want it
RUN pip install --no-cache-dir virtualenv
RUN ln -s /usr/local/python$PYTHON_VERSION/bin/virtualenv /usr/bin/virtualenv

CMD ["python"]
