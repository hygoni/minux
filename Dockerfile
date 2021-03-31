FROM ubuntu:latest
MAINTAINER hyeyoo@student.42seoul.kr

SHELL ["/bin/bash", "-c"]

# make directory for lfs system

ENV LFS /mnt/lfs
RUN mkdir -pv $LFS
RUN mkdir -v $LFS/sources

# anyone can read/write, only owner can delete

RUN chmod -v a+wt $LFS/sources

RUN mkdir /srcs
COPY ./srcs/wget-list /srcs/wget-list
COPY ./srcs/md5sums /srcs/md5sums

# download sources

RUN apt-get update
RUN apt-get install -y wget
RUN wget --input-file=/srcs/wget-list --continue --directory-prefix=$LFS/sources

# add lfs user (password: lfs)

RUN groupadd lfs
RUN useradd -s /bin/bash -g lfs -m -k /dev/null lfs
RUN echo lfs:lfs | chpasswd

# set environment for lfs

USER lfs
RUN echo "exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash" > ~/.bash_profile

# copy bashrc

COPY ./srcs/bashrc /home/lfs/.bashrc

# ensure download files are correct files

RUN pushd $LFS/sources; \
	md5sum -c /srcs/md5sums; \
	popd;

USER root

# create directory hierarchy

RUN mkdir -pv $LFS/{bin,etc,lib,sbin,usr,var}
RUN case $(uname -m) in \
	x86_64) mkdir -pv $LFS/lib64 ;; \
	esac
RUN mkdir -pv $LFS/tools

# give permission to lfs

RUN chown -v lfs $LFS/{usr,lib,var,etc,bin,sbin,tools}
RUN case $(uname -m) in \
	x86_64) chown -v lfs $LFS/lib64 ;; \
	esac
RUN chown -v lfs $LFS/sources

# Host Requirements

RUN chown -R lfs:lfs $LFS
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y patch python3 texinfo xz-utils make m4 g++ gcc gawk binutils bison
COPY ./srcs/version-check.sh /srcs/version-check.sh
RUN ln -sf bash /bin/sh
RUN bash /srcs/version-check.sh

# Build Cross Toolchain
# for building utilities

USER lfs
ENV JOBS 6
COPY ./srcs/build_cross/version.sh /srcs/build_cross/version.sh

# binutils

COPY ./srcs/build_cross/binutils-pass-1.sh /srcs/build_cross/binutils-pass-1.sh
RUN bash /srcs/build_cross/binutils-pass-1.sh

# gcc

COPY ./srcs/build_cross/gcc-pass-1.sh /srcs/build_cross/gcc-pass-1.sh
RUN bash /srcs/build_cross/gcc-pass-1.sh

# linux API headers

COPY ./srcs/build_cross/linux.sh /srcs/build_cross/linux.sh
RUN bash /srcs/build_cross/linux.sh

# glibc

COPY ./srcs/build_cross/glibc.sh /srcs/build_cross/glibc.sh
RUN bash /srcs/build_cross/glibc.sh

# libstdc++

COPY ./srcs/build_cross/libstdc++-pass-1.sh /srcs/build_cross/libstdc++-pass-1.sh
RUN bash /srcs/build_cross/libstdc++-pass-1.sh

# m4

COPY ./srcs/build_cross/m4.sh /srcs/build_cross/m4.sh
RUN bash /srcs/build_cross/m4.sh

# ncurses

COPY ./srcs/build_cross/ncurses.sh /srcs/build_cross/ncurses.sh
RUN bash /srcs/build_cross/ncurses.sh

# bash

COPY ./srcs/build_cross/bash.sh /srcs/build_cross/bash.sh
RUN bash /srcs/build_cross/bash.sh

# coreutils

COPY ./srcs/build_cross/coreutils.sh /srcs/build_cross/coreutils.sh
RUN bash /srcs/build_cross/coreutils.sh

# diffutils

COPY ./srcs/build_cross/diffutils.sh /srcs/build_cross/diffutils.sh
RUN bash /srcs/build_cross/diffutils.sh

# file

COPY ./srcs/build_cross/file.sh /srcs/build_cross/file.sh
RUN bash /srcs/build_cross/file.sh

# findutils

COPY ./srcs/build_cross/findutils.sh /srcs/build_cross/findutils.sh
RUN bash /srcs/build_cross/findutils.sh

# gawk

COPY ./srcs/build_cross/gawk.sh /srcs/build_cross/gawk.sh
RUN bash /srcs/build_cross/gawk.sh

# grep

COPY ./srcs/build_cross/grep.sh /srcs/build_cross/grep.sh
RUN bash /srcs/build_cross/grep.sh

# gzip

COPY ./srcs/build_cross/gzip.sh /srcs/build_cross/gzip.sh
RUN bash /srcs/build_cross/gzip.sh

# make

COPY ./srcs/build_cross/make.sh /srcs/build_cross/make.sh
RUN bash /srcs/build_cross/make.sh

# patch

COPY ./srcs/build_cross/patch.sh /srcs/build_cross/patch.sh
RUN bash /srcs/build_cross/patch.sh

# sed

COPY ./srcs/build_cross/sed.sh /srcs/build_cross/sed.sh
RUN bash /srcs/build_cross/sed.sh

# tar

COPY ./srcs/build_cross/tar.sh /srcs/build_cross/tar.sh
RUN bash /srcs/build_cross/tar.sh

# xz

COPY ./srcs/build_cross/xz.sh /srcs/build_cross/xz.sh
RUN bash /srcs/build_cross/xz.sh

# binutils-pass-2

COPY ./srcs/build_cross/binutils-pass-2.sh /srcs/build_cross/binutils-pass-2.sh
RUN bash /srcs/build_cross/binutils-pass-2.sh

# gcc-pass-2

COPY ./srcs/build_cross/gcc-pass-2.sh /srcs/build_cross/gcc-pass-2.sh
RUN bash /srcs/build_cross/gcc-pass-2.sh

