From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: cross compiling perf
Date: Thu, 4 Aug 2016 10:22:25 -0300
Message-ID: <20160804132225.GI14639@kernel.org>
References: <16135005.c00Xa53Rc9@milian-kdab2>
 <57674D39.1000104@huawei.com>
 <3763103.tiqVXQm4JX@milian-kdab2>
 <5791976.t4kYR0rFfJ@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50134 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932363AbcHDNWc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Aug 2016 09:22:32 -0400
Content-Disposition: inline
In-Reply-To: <5791976.t4kYR0rFfJ@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: wangnan0@huawei.com, jiri@infradead.org, hekuang@huawei.com, linux-perf-users@vger.kernel.org

Em Wed, Aug 03, 2016 at 10:56:20PM +0200, Milian Wolff escreveu:
> I hope this helps others. I finally have a working up2date perf on my aarch64 
> platform and it seems to work form my simple 5min tests so far.

Ok, that should help people, but it is way convoluted :-\

How did you obtained your cross compiler environment? Some ready made
tarball or set of distro packages? I have an ever growing set of perf
build cointainers that includes a few cross compilers:

[root@jouet tmp]# time dm
1: alpine:3.4: Ok
2: android-ndk:r12b: Ok
3: archlinux:latest: Ok
4: centos:5: Ok
5: centos:6: Ok
6: centos:7: Ok
7: debian:7: Ok
8: debian:8: Ok
9: debian:experimental: Ok
10: fedora:20: Ok
11: fedora:21: Ok
12: fedora:22: Ok
13: fedora:23: Ok
14: fedora:24: Ok
15: fedora:rawhide: Ok
16: mageia:5: Ok
17: opensuse:13.2: Ok
18: opensuse:42.1: Ok
19: ubuntu:14.04.4: Ok
20: ubuntu:15.10: Ok
21: ubuntu:16.04: Ok
22: ubuntu:16.04-x-arm64: Ok
23: ubuntu:16.04-x-armhf: Ok
24: ubuntu:16.04-x-powerpc64: Ok
25: ubuntu:16.04-x-powerpc64el: Ok
26: ubuntu:16.04-x-s390: Ok
real	15m53.494s
user	0m1.258s
sys	0m0.928s
[root@jouet tmp]# 

The android-ndk:r12b and the ubuntu:16.04-x-* ones are all cross compiler
environments, some need first cross building zlib and libelf, since those are
not pre-packaged, just the base libc, etc ones are, for instance, the one that
generates an aarch64 perf is:

[root@jouet x-arm64]# cat /root/perf/ubuntu/16.04/x-arm64/Dockerfile 
# docker.io/acmel/linux-perf-tools-build-ubuntu:16.04-x-arm64
FROM docker.io/ubuntu:16.04
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
#ENV DEBIAN_FRONTEND noninteractive
# ubuntu doesn't have the other devel packages for arm64, so build just the basic tool
# libelf-dev is needed to build objtool, which is a host tool, not being cross compiled.
# It will check the cross compiled kernel objects
# It will not be used tho, as there is no support to check aarch64 binaries yet
RUN apt-get -y update && \
    apt-get install -y make gcc-aarch64-linux-gnu flex bison && \
    apt-get clean && \
    rm -rf /usr/share/doc /usr/share/gtk-doc && \
    mkdir -m 777 -p /tmp/build/perf /tmp/build/objtool && \
    groupadd -r perfbuilder && \
    useradd -r -g perfbuilder perfbuilder
RUN apt-get -y install wget bzip2 && \
    export TARGET=aarch64-linux-gnu && \
    export INSTALLDIR=/usr/${TARGET} && \
    export PATH=$INSTALLDIR/bin:$PATH && \
    export TARGETMACH=${TARGET} && \
    export CROSS=${TARGET}- && \
    export CC=${CROSS}gcc && \
    export LD=${CROSS}ld && \
    export AS=${CROSS}as && \
    wget -q http://zlib.net/zlib-1.2.8.tar.gz && \
    wget -q https://fedorahosted.org/releases/e/l/elfutils/0.166/elfutils-0.166.tar.bz2 && \
    tar xf zlib-1.2.8.tar.gz && \
    cd zlib-1.2.8 && \
    ./configure --prefix=${INSTALLDIR} && \
    make && \
    make install && \
    cd .. && \
    rm -rf zlib-1.2.8 && \
    rm -f zlib-1.2.8.tar.gz && \
    tar xf elfutils-0.166.tar.bz2 && \
    cd elfutils-0.166 && \
    ./configure --host=${TARGET} --prefix=${INSTALLDIR} && \
    make && \
    make install && \
    cd .. && \
    rm -rf elfutils-0.166 && \
    apt-get -y remove wget bzip2 && \
    apt-get clean && \
    unset TARGET INSTALLDIR TARGETMACH CROSS CC LD AS
USER perfbuilder
ENTRYPOINT make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C /git/linux/tools/perf O=/tmp/build/perf
# There is no support yet for checking aarch64 binaries, only x86_64 ones
#          make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C /git/linux/tools/objtool O=/tmp/build/objtool
[root@jouet x-arm64]#

- Arnaldo
