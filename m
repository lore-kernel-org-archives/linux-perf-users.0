From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: cross compiling perf
Date: Thu, 4 Aug 2016 15:36:05 -0300
Message-ID: <20160804183605.GJ14639@kernel.org>
References: <16135005.c00Xa53Rc9@milian-kdab2>
 <5791976.t4kYR0rFfJ@agathebauer>
 <20160804132225.GI14639@kernel.org>
 <3173583.b0RsRJyeV2@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34800 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758758AbcHDSgP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Aug 2016 14:36:15 -0400
Content-Disposition: inline
In-Reply-To: <3173583.b0RsRJyeV2@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: wangnan0@huawei.com, jiri@infradead.org, hekuang@huawei.com, linux-perf-users@vger.kernel.org

Em Thu, Aug 04, 2016 at 05:02:01PM +0200, Milian Wolff escreveu:
> On Thursday, August 4, 2016 10:22:25 AM CEST Arnaldo Carvalho de Melo wrote:
> > Em Wed, Aug 03, 2016 at 10:56:20PM +0200, Milian Wolff escreveu:
> > > I hope this helps others. I finally have a working up2date perf on my
> > > aarch64 platform and it seems to work form my simple 5min tests so far.
> > 
> > Ok, that should help people, but it is way convoluted :-\
> > 
> > How did you obtained your cross compiler environment? Some ready made
> > tarball or set of distro packages? I have an ever growing set of perf
> > build cointainers that includes a few cross compilers:
> 
> The environment was provided to us as a tarball from a customer of ours, who 
> probably got that from another subcontractor.
> 
> <snip>
> 
>     export INSTALLDIR=/usr/${TARGET} && \
> 
> ^-- is that path potentially special cased in the build file? I mean you don't 

Huh? Not that I am aware, no, I just looked at where the existing cross
build packages were located, so that I used the same place for the cross
built versions of libelf and zlib:

[root@jouet x-arm64]# docker run --entrypoint=/bin/bash -v /home/acme/git:/git:Z --rm -ti docker.io/acmel/linux-perf-tools-build-ubuntu:16.04-x-arm64 
perfbuilder@122a2cb948d6:/$
perfbuilder@122a2cb948d6:/$ dpkg -L libc6-dev-arm64-cross | tail
/usr/aarch64-linux-gnu/lib/libnss_nis.so
/usr/aarch64-linux-gnu/lib/libnss_nisplus.so
/usr/aarch64-linux-gnu/lib/libnss_files.so
/usr/aarch64-linux-gnu/lib/libdl.so
/usr/aarch64-linux-gnu/lib/libcidn.so
/usr/aarch64-linux-gnu/lib/libthread_db.so
/usr/aarch64-linux-gnu/lib/librt.so
/usr/aarch64-linux-gnu/lib/libnss_compat.so
/usr/aarch64-linux-gnu/lib/libanl.so
/usr/aarch64-linux-gnu/lib/libnss_dns.so
perfbuilder@122a2cb948d6:/$

That is the same as all the other devel packages with the arm64-cross on ubuntu
16.04:

perfbuilder@122a2cb948d6:/$ dpkg -l | grep arm64-cross
ii  libasan2-arm64-cross          5.4.0-6ubuntu1~16.04.1cross1   all  AddressSanitizer -- a fast memory error detector
ii  libatomic1-arm64-cross        5.4.0-6ubuntu1~16.04.1cross1   all  support library providing __atomic built-in functions
ii  libc6-arm64-cross             2.23-0ubuntu3cross1            all  GNU C Library: Shared libraries (for cross-compiling)
ii  libc6-dev-arm64-cross         2.23-0ubuntu3cross1            all  GNU C Library: Development Libraries and Header Files (for cross-compiling)
ii  libgcc-5-dev-arm64-cross      5.4.0-6ubuntu1~16.04.1cross1   all  GCC support library (development files)
ii  libgcc1-arm64-cross           1:5.4.0-6ubuntu1~16.04.1cross1 all  GCC support library
ii  libgomp1-arm64-cross          5.4.0-6ubuntu1~16.04.1cross1   all  GCC OpenMP (GOMP) support library
ii  libitm1-arm64-cross           5.4.0-6ubuntu1~16.04.1cross1   all  GNU Transactional Memory Library
ii  libstdc++6-arm64-cross        5.4.0-6ubuntu1~16.04.1cross1   all  GNU Standard C++ Library v3
ii  libubsan0-arm64-cross         5.4.0-6ubuntu1~16.04.1cross1   all  UBSan -- undefined behaviour sanitizer (runtime)
ii  linux-libc-dev-arm64-cross    4.4.0-18.34cross1              all  Linux Kernel Headers for development (for cross-compiling)
perfbuilder@122a2cb948d6:/$

perfbuilder@122a2cb948d6:/$ dpkg -L libasan2-arm64-cross | grep \.so\.[0-9]
/usr/aarch64-linux-gnu/lib/libasan.so.2.0.0
/usr/aarch64-linux-gnu/lib/libasan.so.2
perfbuilder@122a2cb948d6:/$

perfbuilder@122a2cb948d6:/$ dpkg -L libstdc++6-arm64-cross | grep \.so\.[0-9]
/usr/share/gdb/auto-load/usr/aarch64-linux-gnu/lib/libstdc++.so.6.0.21-gdb.py
/usr/aarch64-linux-gnu/lib/libstdc++.so.6.0.21
/usr/aarch64-linux-gnu/lib/libstdc++.so.6
perfbuilder@122a2cb948d6:/$ 

etc. So I assumed the best place to install the zlib and libelf devel files was
with that path prefix.

See it running:

# docker run -v /home/acme/git:/git:Z --rm -ti docker.io/acmel/linux-perf-tools-build-ubuntu:16.04-x-arm64
make: Entering directory '/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ on  ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]

Makefile.config:349: BPF prologue is not supported by architecture arm64, missing regs_query_register_offset()
Makefile.config:360: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:406: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
Makefile.config:433: Disabling post unwind, no support found.
Makefile.config:479: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
Makefile.config:490: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
Makefile.config:505: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:519: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
Makefile.config:547: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:573: No python interpreter was found: disables Python support - please install python-devel/python-dev
Makefile.config:651: No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling
Makefile.config:680: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:693: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:750: Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc
  GEN      /tmp/build/perf/common-cmds.h
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/fd/array.o
<SNIP>

----------------------

See? The features it is finding are just the ones related to having glibc, zlib
and libelf devel packages that can be used in a cross build.

> set the sysroot anywhere, nor do you seem to pass special include paths to 
> perf. This of course works fine in a docker environment, but for "normal" 
> development machines, where you compile and install stuff somewhere in $HOME, 
> this won't work at all.

Hey, a "docker environment" should be no different than a "normal" development
machine, it should work just the same, its just the former will run inside a
container, but the packages are the same I would install in my workstation if I
wanted to pollute it with a cross compiler environment. Since I want to install
tons of cross compiler environments, I better use some sort of container,
docker being the most popular, I picked it.

> The above wouldn't directly explain the really strange behavior of the feature 
> detection though (which enables _everything_ for me).

That is strage, yes, and I haven't even tried to figure out why this
happens in your case, I was just trying to show cross compiler
environments where the cross build of perf works, perhaps that would
help you figure out your specific case.

Further example, here is the Android NDK one, that is on top of Fedora 24
instead of the previous example, that is on top of Ubuntu 16.04, and here you
may have your answer, i.e. use EXTRA_CFLAGS to set --sysroot, I got that from
tools/perf/Documentation/android.txt:

[root@jouet x-arm64]# cat /root/perf/android/r12b/arm/Dockerfile 
# docker.io/acmel/linux-perf-tools-build-android-ndk:r12b
FROM docker.io/fedora:24
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV SOURCEFILE=android-ndk-r12b-linux-x86_64.zip
RUN dnf -y install make bison flex unzip && \
    dnf -y clean all && \
    mkdir -m 777 -p /tmp/build/perf /tmp/build/objtool && \
    curl -OL http://dl.google.com/android/repository/${SOURCEFILE} && \
    unzip -d /opt ${SOURCEFILE} && \
    rm -f ${SOURCEFILE} && \
    rm -rf /opt/android-ndk-r12b/sources \
	   /opt/android-ndk-r12b/platforms/android-[19]* \
	   /opt/android-ndk-r12b/platforms/android-2[0-3]* \
	   /opt/android-ndk-r12b/platforms/android-24/arch-mips* \
	   /opt/android-ndk-r12b/platforms/android-24/arch-x86* \
	   /opt/android-ndk-r12b/toolchains/x86* \
	   /opt/android-ndk-r12b/toolchains/mips* \
	   /opt/android-ndk-r12b/toolchains/llvm* \
	   /opt/android-ndk-r12b/prebuilt/ \
	   /opt/android-ndk-r12b/python* \
	   /opt/android-ndk-r12b/shader-tools/ &&\
    groupadd -r perfbuilder && \
    useradd -r -g perfbuilder perfbuilder
USER perfbuilder
ENV NDK=/opt/android-ndk-r12b/
ENV NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
ENV NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
ENTRYPOINT make -C /git/linux/tools/perf O=/tmp/build/perf WERROR=0 ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}" && \
	   make -C /git/linux/tools/objtool O=/tmp/build/objtool WERROR=0 ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
[root@jouet x-arm64]# 

--------------------------------------------------------

This one comes with a bit more pre-built devel packages, so did not have to
cross build zlib (I'll copy the cross build of libelf to get a bit more code
tested...) instead I threw away lots of toolchains for arches I didn't want,
leaving just the ones for "arm-linux-androideabi-", running it we get:

[root@jouet ~]# docker run -v /home/acme/git:/git:Z --rm -ti docker.io/acmel/linux-perf-tools-build-android-ndk:r12b 
make: Entering directory '/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build

Auto-detecting system features:
...                         dwarf: [ OFF ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ OFF ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ OFF ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ on  ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ OFF ]

Makefile.config:260: No libelf found, disables 'probe' tool and BPF support in 'perf record', please install libelf-dev, libelf-devel or elfutils-libelf-devel
Makefile.config:360: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:433: Disabling post unwind, no support found.
Makefile.config:479: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
Makefile.config:490: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
Makefile.config:505: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:519: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev

- Arnaldo
