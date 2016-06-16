From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: cross compiling perf
Date: Thu, 16 Jun 2016 13:11:11 -0300
Message-ID: <20160616161111.GA13337@kernel.org>
References: <16135005.c00Xa53Rc9@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57262 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbcFPQLS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Jun 2016 12:11:18 -0400
Content-Disposition: inline
In-Reply-To: <16135005.c00Xa53Rc9@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Jun 15, 2016 at 04:24:52PM +0200, Milian Wolff escreveu:
> I'm trying to compile a more modern version of the user-space perf tools for 
> an arm64 embedded target. So far, no cigar.
 
> Neither tools/build/Documentation nor tools/perf/Documentation/Build.txt 
> explain how this should be done. Right now, I'm trying the following from an 
> SDK with an environment that already sets up CC, CFLAGS etc. pp.
 
> [SDK] ~/milian/linux/tools/perf$ make ARCH=arm64 CROSS_COMPILE=/home/sdk/
> sysroots/x86_64-oesdk-linux/usr/bin/aarch64-gnu-linux/aarch64-gnu-linux- 
> CFLAGS="--sysroot=/home/sdk/sysroots/aarch64-gnu-linux -I/home/milian/target-
> prefix/include -L/home/milian/target-prefix/lib $CFLAGS" 
>   BUILD:   Doing 'make -j8' parallel build
 
> Auto-detecting system features:
> ...                         dwarf: [ OFF ]
> ...            dwarf_getlocations: [ OFF ]
> ...                         glibc: [ OFF ]
> ...                          gtk2: [ OFF ]
> ...                      libaudit: [ OFF ]
> ...                        libbfd: [ OFF ]
> ...                        libelf: [ OFF ]
> ...                       libnuma: [ OFF ]
> ...        numa_num_possible_cpus: [ OFF ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                      libslang: [ OFF ]
> ...                     libcrypto: [ OFF ]
> ...                     libunwind: [ OFF ]
> ...            libdw-dwarf-unwind: [ OFF ]
> ...                          zlib: [ OFF ]
> ...                          lzma: [ OFF ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ OFF ]
> 
> config/Makefile:272: *** No gnu/libc-version.h found, please install glibc-
> dev[el].  Stop
 
> How can I figure out where perf's buildsystem is looking for the dependencies? 
> How can I configure it to look into both, my sysroot as well as a secondary 
> path that contains some additional software I compiled manually?

So, I have these cross build images here:

[root@jouet ~]# docker images | grep -- -x-
perf-build-minimal-debian-experimental-x-mips64    latest  53b5bb082ace  11 weeks ago  595.3 MB
perf-build-minimal-debian-experimental-x-mips64el  latest  427fa4c1ad0a  11 weeks ago  595.4 MB
perf-build-minimal-debian-experimental-x-mipsel    latest  1247b61110bf  11 weeks ago  589.4 MB
perf-build-minimal-ubuntu-x-arm                    latest  cb739975a1f0  11 weeks ago  380.5 MB
perf-build-minimal-ubuntu-x-arm64                  latest  83fa1b24c6b6  11 weeks ago  357.2 MB
perf-build-minimal-ubuntu-x-ppc64                  latest  b759a1866191  11 weeks ago  384.3 MB
perf-build-minimal-ubuntu-x-ppc64el                latest  a3f1e718196a  11 weeks ago  372.3 MB
[root@jouet ~]# 

But those are minimal builds, without that many devel packages, have
to go back looking for multiarch libs in debian, anyway, it works
a bit better than what you have experienced:

[root@jouet ubuntu-x-arm64]# cat Dockerfile 
FROM docker.io/ubuntu
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
#ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y make gcc-aarch64-linux-gnu flex bison
# buildable!
# ubuntu doesn't have the other devel packages for arm64, so build just the basic tool
RUN mkdir -p /tmp/build/perf
ENTRYPOINT make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C /git/linux/tools/perf O=/tmp/build/perf
[root@jouet ubuntu-x-arm64]#
[root@jouet ubuntu-x-arm64]# docker run -v /home/acme/git:/git:Z --rm=true -t -i perf-build-minimal-ubuntu-x-arm64
make: Entering directory `/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
sh: 1: command: Illegal option -c

Auto-detecting system features:
...                         dwarf: [ OFF ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ on  ]
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
...                          zlib: [ OFF ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]

config/Makefile:260: No libelf found, disables 'probe' tool and BPF support in 'perf record', please install elfutils-libelf-devel/libelf-dev
config/Makefile:413: Disabling post unwind, no support found.
config/Makefile:459: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
config/Makefile:470: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
config/Makefile:485: slang not found, disables TUI support. Please install slang-devel or libslang-dev
config/Makefile:499: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
config/Makefile:527: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
config/Makefile:553: No python interpreter was found: disables Python support - please install python-devel/python-dev
config/Makefile:660: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
config/Makefile:673: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
config/Makefile:730: Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc
  GEN      /tmp/build/perf/common-cmds.h
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/fd/array.o
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/exec-cmd.o
  MKDIR    /tmp/build/perf/fd/
  LD       /tmp/build/perf/fd/libapi-in.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/fs.o
  CC       /tmp/build/perf/help.o
  PERF_VERSION = 4.7.0-rc3
  CC       /tmp/build/perf/plugin_jbd2.o
  CC       /tmp/build/perf/event-plugin.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  CC       /tmp/build/perf/plugin_hrtimer.o
  CC       /tmp/build/perf/trace-seq.o
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  CC       /tmp/build/perf/plugin_kmem.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/parse-filter.o
  LD       /tmp/build/perf/plugin_kmem-in.o
  CC       /tmp/build/perf/plugin_kvm.o
  LD       /tmp/build/perf/plugin_kvm-in.o
  CC       /tmp/build/perf/plugin_mac80211.o
  MKDIR    /tmp/build/perf/fs/
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/pager.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/parse-utils.o
  LD       /tmp/build/perf/libapi-in.o
  CC       /tmp/build/perf/kbuffer-parse.o
  AR       /tmp/build/perf/libapi.a
  GEN      perf-archive
  GEN      perf-with-kcore
  CC       /tmp/build/perf/parse-options.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/plugin_function.o
  CC       /tmp/build/perf/util/alias.o
  LD       /tmp/build/perf/libtraceevent-in.o
  LINK     /tmp/build/perf/libtraceevent.a
  CC       /tmp/build/perf/builtin-bench.o
  LD       /tmp/build/perf/plugin_function-in.o
  CC       /tmp/build/perf/plugin_xen.o
  LD       /tmp/build/perf/plugin_xen-in.o
  CC       /tmp/build/perf/plugin_scsi.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/annotate.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_jbd2.so
  CC       /tmp/build/perf/builtin-annotate.o
  LINK     /tmp/build/perf/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugin_kmem.so
  LINK     /tmp/build/perf/plugin_kvm.so
  LINK     /tmp/build/perf/plugin_mac80211.so
  LINK     /tmp/build/perf/plugin_sched_switch.so
  LINK     /tmp/build/perf/plugin_function.so
  LINK     /tmp/build/perf/plugin_xen.so
  LINK     /tmp/build/perf/plugin_scsi.so
  LINK     /tmp/build/perf/plugin_cfg80211.so
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  MKDIR    /tmp/build/perf/arch/
  CC       /tmp/build/perf/arch/common.o
  CC       /tmp/build/perf/run-command.o
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/sigchain.o
  CC       /tmp/build/perf/builtin-diff.o
  MKDIR    /tmp/build/perf/arch/arm64/util/
  LD       /tmp/build/perf/arch/arm64/util/libperf-in.o
  MKDIR    /tmp/build/perf/arch/arm64/
  LD       /tmp/build/perf/arch/arm64/libperf-in.o
  MKDIR    /tmp/build/perf/arch/
  LD       /tmp/build/perf/arch/libperf-in.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/subcmd-config.o
  LD       /tmp/build/perf/libsubcmd-in.o
  AR       /tmp/build/perf/libsubcmd.a
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/helpline.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/progress.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/util.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/hist.o
  MKDIR    /tmp/build/perf/ui/stdio/
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/builtin-help.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/config.o
  CC       /tmp/build/perf/builtin-sched.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/ctype.o
  MKDIR    /tmp/build/perf/ui/
  LD       /tmp/build/perf/ui/libperf-in.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/db-export.o
  MKDIR    /tmp/build/perf/scripts/
  LD       /tmp/build/perf/scripts/libperf-in.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/builtin-report.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/env.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/event.o
  CC       /tmp/build/perf/builtin-stat.o
  CC       /tmp/build/perf/builtin-timechart.o
  CC       /tmp/build/perf/builtin-top.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/builtin-lock.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/evsel.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/find_bit.o
  MKDIR    /tmp/build/perf/util/
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-version.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/llvm-utils.o
  MKDIR    /tmp/build/perf/util/
  BISON    /tmp/build/perf/util/parse-events-bison.c
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-messaging.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/builtin-test.o
  CC       /tmp/build/perf/perf.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-pipe.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/perf_regs.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/parse-events.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/path.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/mem-functions.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/rbtree.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/libstring.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/bitmap.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/hweight.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/futex-hash.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/futex-wake.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/quote.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/strbuf.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/string.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/strlist.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/futex-requeue.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/strfilter.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/top.o
  MKDIR    /tmp/build/perf/bench/
  LD       /tmp/build/perf/bench/perf-in.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/usage.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/dso.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/symbol.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/symbol_fprintf.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/color.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/dso-data.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/header.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/callchain.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/attr.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/values.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/debug.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/openat-syscall.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/machine.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/mmap-basic.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/perf-record.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/map.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/pstack.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/session.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/fdarray.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/ordered-events.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/pmu.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/hists_common.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/comm.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/thread.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/hists_link.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/thread_map.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/trace-event-parse.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/hists_filter.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/parse-events-bison.o
  MKDIR    /tmp/build/perf/util/
  BISON    /tmp/build/perf/util/pmu-bison.c
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/trace-event-read.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/hists_output.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/trace-event-info.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/trace-event-scripting.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/trace-event.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/svghelper.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/sort.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/hists_cumulate.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/hist.o
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/util/util.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/bp_signal.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/task-exit.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/sw-clock.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/thread-mg-share.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/switch-tracking.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/keep-tracking.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/xyarray.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/cpumap.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/code-reading.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/cgroup.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/sample-parsing.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/target.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/rblist.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/intlist.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/vdso.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/kmod-path.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/counts.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/thread-map.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/stat.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/stat-shadow.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/llvm.o
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/bpf.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/record.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/topology.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/cpumap.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/stat.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/event_update.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/srcline.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/event-times.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/backward-ring-buffer.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/data.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/llvm-src-base.o
  MKDIR    /tmp/build/perf/util/
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/cloexec.o
  MKDIR    /tmp/build/perf/tests/
  LD       /tmp/build/perf/tests/perf-in.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/call-path.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/thread-stack.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/parse-branch-options.o
  LD       /tmp/build/perf/perf-in.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/parse-regs-options.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/term.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/mem-events.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/symbol-minimal.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  LD       /tmp/build/perf/util/scripting-engines/libperf-in.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/demangle-java.o
  MKDIR    /tmp/build/perf/util/
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  MKDIR    /tmp/build/perf/util/
  FLEX     /tmp/build/perf/util/pmu-flex.c
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/pmu-bison.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/parse-events.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/parse-events-flex.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/pmu.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/pmu-flex.o
  MKDIR    /tmp/build/perf/util/
  LD       /tmp/build/perf/util/libperf-in.o
  LD       /tmp/build/perf/libperf-in.o
  AR       /tmp/build/perf/libperf.a
  LINK     /tmp/build/perf/perf
make: Leaving directory `/git/linux/tools/perf'
[root@jouet ubuntu-x-arm64]#
