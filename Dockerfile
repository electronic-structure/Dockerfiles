FROM ubuntu:21.10

ENV DEBIAN_FRONTEND noninteractive
#
#ENV FORCE_UNSAFE_CONFIGURE 1
#
RUN apt-get -y update

RUN apt-get install -y apt-utils

# install basic tools
RUN apt-get install -y gcc g++ gfortran git make cmake unzip \
  vim wget pkg-config python3-pip curl tcl m4 cpio hwloc automake \
  apt-transport-https ca-certificates gnupg software-properties-common

# get latest version of spack
RUN git clone https://github.com/spack/spack.git

RUN echo "source /spack/share/spack/setup-env.sh" >> /etc/profile.d/spack.sh

RUN /spack/bin/spack compiler find
RUN /spack/bin/spack external find

ENV SPEC="sirius@develop %gcc build_type=Release +scalapack +fortran +tests ^intel-mkl@2017: threads=openmp ^mpich@3.3.2 ^spfft+single_precision target=x86_64"

RUN /spack/bin/spack env create --with-view /root/spack-sirius-install -d /root/spack-sirius-env

RUN /spack/bin/spack -e /root/spack-sirius-env install --only=dependencies $SPEC

WORKDIR /root

ENTRYPOINT ["bash", "-l"]
