FROM centos:7

RUN yum -y install \
    autoconf \
    automake \
    cmake \
    git \
    make \
    rpm-build \
    rpmdevtools \
    which \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN rpmdev-setuptree

ARG EXTRA_PACKAGES=""

RUN  [ -z "$EXTRA_PACKAGES" ] || \
    (yum -y install $EXTRA_PACKAGES \
    && yum clean all \
    && rm -rf /var/cache/yum)

COPY docker-entrypoint.sh /

VOLUME /root/rpmbuild

ENTRYPOINT ["/docker-entrypoint.sh"]
