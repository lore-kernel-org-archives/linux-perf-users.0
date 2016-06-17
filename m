From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: cross compiling perf
Date: Fri, 17 Jun 2016 08:00:56 -0300
Message-ID: <20160617110056.GJ13337@kernel.org>
References: <16135005.c00Xa53Rc9@milian-kdab2>
 <20160616161111.GA13337@kernel.org>
 <29350352.ftQorT9lcR@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43740 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbcFQLBD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jun 2016 07:01:03 -0400
Content-Disposition: inline
In-Reply-To: <29350352.ftQorT9lcR@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, jiri@infradead.org, Wang Nan <wangnan0@huawei.com>, He Kuang <hekuang@huawei.com>
Cc: linux-perf-users@vger.kernel.org

Adding some folks to the CC list, that either worked on the make
infrastructure or that I know works with cross compiling environments,
maybe they can help.

More below.

Em Fri, Jun 17, 2016 at 11:49:28AM +0200, Milian Wolff escreveu:
> On Donnerstag, 16. Juni 2016 13:11:11 CEST Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 15, 2016 at 04:24:52PM +0200, Milian Wolff escreveu:
> > > I'm trying to compile a more modern version of the user-space perf tools
> > > for an arm64 embedded target. So far, no cigar.
> > > 
> > > Neither tools/build/Documentation nor tools/perf/Documentation/Build.txt
> > > explain how this should be done. Right now, I'm trying the following from
> > > an SDK with an environment that already sets up CC, CFLAGS etc. pp.
> > > 
> > > [SDK] ~/milian/linux/tools/perf$ make ARCH=arm64 CROSS_COMPILE=/home/sdk/
> > > sysroots/x86_64-oesdk-linux/usr/bin/aarch64-gnu-linux/aarch64-gnu-linux-
> > > CFLAGS="--sysroot=/home/sdk/sysroots/aarch64-gnu-linux
> > > -I/home/milian/target- prefix/include -L/home/milian/target-prefix/lib
> > > $CFLAGS"
> > > 
> > >   BUILD:   Doing 'make -j8' parallel build
> > > 
> > > Auto-detecting system features:
> > > ...                         dwarf: [ OFF ]
> > > ...            dwarf_getlocations: [ OFF ]
> > > ...                         glibc: [ OFF ]
> > > ...                          gtk2: [ OFF ]
> > > ...                      libaudit: [ OFF ]
> > > ...                        libbfd: [ OFF ]
> > > ...                        libelf: [ OFF ]
> > > ...                       libnuma: [ OFF ]
> > > ...        numa_num_possible_cpus: [ OFF ]
> > > ...                       libperl: [ OFF ]
> > > ...                     libpython: [ OFF ]
> > > ...                      libslang: [ OFF ]
> > > ...                     libcrypto: [ OFF ]
> > > ...                     libunwind: [ OFF ]
> > > ...            libdw-dwarf-unwind: [ OFF ]
> > > ...                          zlib: [ OFF ]
> > > ...                          lzma: [ OFF ]
> > > ...                     get_cpuid: [ OFF ]
> > > ...                           bpf: [ OFF ]
> > > 
> > > config/Makefile:272: *** No gnu/libc-version.h found, please install
> > > glibc-
> > > dev[el].  Stop
> > > 
> > > How can I figure out where perf's buildsystem is looking for the
> > > dependencies? How can I configure it to look into both, my sysroot as
> > > well as a secondary path that contains some additional software I
> > > compiled manually?
> > 
> > So, I have these cross build images here:
> > 
> > [root@jouet ~]# docker images | grep -- -x-
> > perf-build-minimal-debian-experimental-x-mips64    latest  53b5bb082ace  11
> > weeks ago  595.3 MB perf-build-minimal-debian-experimental-x-mips64el 
> > latest  427fa4c1ad0a  11 weeks ago  595.4 MB
> > perf-build-minimal-debian-experimental-x-mipsel    latest  1247b61110bf  11
> > weeks ago  589.4 MB perf-build-minimal-ubuntu-x-arm                   
> > latest  cb739975a1f0  11 weeks ago  380.5 MB
> > perf-build-minimal-ubuntu-x-arm64                  latest  83fa1b24c6b6  11
> > weeks ago  357.2 MB perf-build-minimal-ubuntu-x-ppc64                 
> > latest  b759a1866191  11 weeks ago  384.3 MB
> > perf-build-minimal-ubuntu-x-ppc64el                latest  a3f1e718196a  11
> > weeks ago  372.3 MB [root@jouet ~]#
> > 
> > But those are minimal builds, without that many devel packages, have
> > to go back looking for multiarch libs in debian, anyway, it works
> > a bit better than what you have experienced:
> > 
> > [root@jouet ubuntu-x-arm64]# cat Dockerfile
> > FROM docker.io/ubuntu
> > MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
> > #ENV DEBIAN_FRONTEND noninteractive
> > RUN apt-get update -y
> > RUN apt-get upgrade -y
> > RUN apt-get install -y make gcc-aarch64-linux-gnu flex bison
> > # buildable!
> > # ubuntu doesn't have the other devel packages for arm64, so build just the
> > basic tool RUN mkdir -p /tmp/build/perf
> > ENTRYPOINT make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C
> > /git/linux/tools/perf O=/tmp/build/perf [root@jouet ubuntu-x-arm64]#
> > [root@jouet ubuntu-x-arm64]# docker run -v /home/acme/git:/git:Z --rm=true
> > -t -i perf-build-minimal-ubuntu-x-arm64 make: Entering directory
> > `/git/linux/tools/perf'
> >   BUILD:   Doing 'make -j4' parallel build
> > sh: 1: command: Illegal option -c
> > 
> > Auto-detecting system features:
> > ...                         dwarf: [ OFF ]
> > ...            dwarf_getlocations: [ OFF ]
> > ...                         glibc: [ on  ]
> > ...                          gtk2: [ OFF ]
> > ...                      libaudit: [ OFF ]
> > ...                        libbfd: [ OFF ]
> > ...                        libelf: [ OFF ]
> > ...                       libnuma: [ OFF ]
> > ...        numa_num_possible_cpus: [ OFF ]
> > ...                       libperl: [ OFF ]
> > ...                     libpython: [ OFF ]
> > ...                      libslang: [ OFF ]
> > ...                     libcrypto: [ OFF ]
> > ...                     libunwind: [ OFF ]
> > ...            libdw-dwarf-unwind: [ OFF ]
> > ...                          zlib: [ OFF ]
> > ...                          lzma: [ OFF ]
> > ...                     get_cpuid: [ OFF ]
> > ...                           bpf: [ on  ]
> > 
> > config/Makefile:260: No libelf found, disables 'probe' tool and BPF support
> > in 'perf record', please install elfutils-libelf-devel/libelf-dev
> > config/Makefile:413: Disabling post unwind, no support found.
> > config/Makefile:459: No libaudit.h found, disables 'trace' tool, please
> > install audit-libs-devel or libaudit-dev config/Makefile:470: No
> > libcrypto.h found, disables jitted code injection, please install
> > libssl-devel or libssl-dev config/Makefile:485: slang not found, disables
> > TUI support. Please install slang-devel or libslang-dev
> > config/Makefile:499: GTK2 not found, disables GTK2 support. Please install
> > gtk2-devel or libgtk2.0-dev config/Makefile:527: Missing perl devel files.
> > Disabling perl scripting support, please install
> > perl-ExtUtils-Embed/libperl-dev config/Makefile:553: No python interpreter
> > was found: disables Python support - please install python-devel/python-dev
> > config/Makefile:660: No liblzma found, disables xz kernel module
> > decompression, please install xz-devel/liblzma-dev config/Makefile:673: No
> > numa.h found, disables 'perf bench numa mem' benchmark, please install
> > numactl-devel/libnuma-devel/libnuma-dev config/Makefile:730: Your gcc lacks
> > the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please
> 
> <snip>
> 
> Thanks Arnaldo. Could you document how to specify the sysroot path and 
> secondary include and library paths?
> 
> Also, how can I get more input to debug what is going wrong? So far I tried to 
> strace make and edit the makefile to add debug output, but with very limited 
> success. I'm used to CMake, which has both verbose error messages and keeps a 
> log file around with even more information on what went wrong. Furthermore, 
> for these kinds of compile checks, I can easily manually reproduce what CMake 
> did to figure out what is going wrong. With perf's make files, none of this 
> seems to be easily done :(

Yeah, we're really bad at documenting things, lemme try finding what can
help here:

tools/build/Documentation/Build.txt
tools/perf/Documentation/Build.txt

And in your output dir (O= or in place, in tools/perf/)

[acme@jouet linux]$ ls -la /tmp/build/perf/feature/*.output | tail
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-libunwind.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-libunwind-x86_64.make.output
-rw-rw-r--. 1 acme acme 107 Jun 16 18:41 /tmp/build/perf/feature/test-libunwind-x86.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-lzma.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-numa_num_possible_cpus.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-pthread-attr-setaffinity-np.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-stackprotector-all.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-sync-compare-and-swap.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-timerfd.make.output
-rw-rw-r--. 1 acme acme   0 Jun 16 18:36 /tmp/build/perf/feature/test-zlib.make.output
[acme@jouet linux]$ 

So, a zero sized file means that feature was detected without a problem, lets
see one that has content:

[acme@jouet linux]$ cat /tmp/build/perf/feature/test-libunwind-x86.make.output
test-libunwind-x86.c:1:27: fatal error: libunwind-x86.h: No such file or directory
compilation terminated.
[acme@jouet linux]$ 
