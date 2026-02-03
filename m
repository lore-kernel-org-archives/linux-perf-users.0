Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B18A3ACF14;
	Tue,  3 Feb 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130677; cv=none; b=BmRebbyi6k8sdpYuhr0OQ+dK1ByABEwUFRK0PfATwfg8MXs/8wGbHToXxOmiNmdi+yNq/edEU3U9lMNjsNbKXLnHN5RkYYQQnraUbm1UHOPomxqkqABK+8miMPeLFmYMvcrAkmbBEo4Rx0BvEmJfvMD9gy2UChTZegKjY0gcXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130677; c=relaxed/simple;
	bh=kgVgPusjy0X/xSfUdbnrzdkEilZYf5xj/sbLLYc0oqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lnyx6dkVihnlYn1qf7LakGezyl4MRHlT3Tc+TN7uofih9nluioqGalEFWQosvBNC9l+Qga4myVS+lrCy/gaKSondwihgib1VDhrv58zYZ3FA1EoXAbwswpfFiPBzTHtI16bAB6dhRPpIvjKJ89EPtQrztzVkCD25Ini8A+VFtLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1hPVuBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1hPVuBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B77C116D0;
	Tue,  3 Feb 2026 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770130676;
	bh=kgVgPusjy0X/xSfUdbnrzdkEilZYf5xj/sbLLYc0oqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1hPVuBmoClobd1PLDARDklNQk661/9h7N9VU7vkZ/7Ql+/Dwqb0juGbCQWJoBJEr
	 r1z3joA9Z7WGeNAWr3sxxb/Rp331IJJDHhdjJYTy2MfRo4Jb5xsdymI1ML308BRDaM
	 cUzouDjdrl3apVY2uSRegpJlVnyix4627kR1yp7CwjqjbZafP8U+gnTtt044l633qH
	 au0xsUEhnj0f7mONuwhxaEhh9kuhXquBxEs9/N2khMRZkzuPepG0ZWB9AaLppzBMHF
	 mdrMOAcsHdmB722btEhzLpf2cuVoZOLDqB3yVn9Tj72YkL8qWbzS7UagIV9OxEtTox
	 /uFvJoNaqipXw==
Date: Tue, 3 Feb 2026 11:57:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Blake Jones <blakejones@google.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] perf Cross platform KVM support
Message-ID: <aYIM8RSBHYK1suEx@x1>
References: <20260131200224.1296136-1-irogers@google.com>
 <aYIJYVp6T4ClBw0M@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYIJYVp6T4ClBw0M@x1>

On Tue, Feb 03, 2026 at 11:42:44AM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, Jan 31, 2026 at 12:02:18PM -0800, Ian Rogers wrote:
> > The existing perf kvm code is using the arch directory, which means a
> > data file can only be processed on the same machine type that it was
> > recorded. Switch to using the ELF machine of the session at runtime to
> > set up the KVM support, making it cross-architectural. So that the ELF
> > machine number is available early in initialization add it to the perf
> > data file header.
> > 
> > v2: Wire up the perf data header to have the e_machine and allow early
> >     initialization of the KVM operations based upon it.
> > v1: https://lore.kernel.org/lkml/20260128074106.788156-1-irogers@google.com/
> 
> Thanks, applied to perf-tools-next,

Removing it for now, the static build is failing, please take a look,

- Arnaldo

                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32  DESTDIR=/tmp/tmp.XNUPlEfJN3
cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32 DESTDIR=/tmp/tmp.XNUPlEfJN3
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
Makefile.config:703: Warning: Disabled BPF skeletons as libelf is required by bpftool
Makefile.config:747: Disabling post unwind, no support found.
Makefile.config:794: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:871: No 'Python.h' was found: disables Python support - please install python-devel/python-dev
Makefile.config:963: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
Makefile.config:1009: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:1022: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:1035: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1082: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1098: No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel
Makefile.config:1147: libpfm4 not found, disables libpfm4 support. Please install libpfm-devel or libpfm4-dev

Auto-detecting system features:
...                                   libdw: [ OFF ]
...                                   glibc: [ on  ]
...                                  libelf: [ OFF ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                               libpython: [ OFF ]
...                             libcapstone: [ OFF ]
...                               llvm-perf: [ OFF ]
...                                    zlib: [ OFF ]
...                                    lzma: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ OFF ]
...                              libopenssl: [ OFF ]

  CC      dlfilters/dlfilter-test-api-v0.o
  CC      dlfilters/dlfilter-test-api-v2.o
  CC      dlfilters/dlfilter-show-cycles.o
  GEN     /home/acme/git/perf-tools-next/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/help.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/pager.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/parse-options.h
  PERF_VERSION = 6.19.rc7.gd0144158c595
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/run-command.h
  GEN     perf-archive
  GEN     perf-iostat
  INSTALL libsubcmd_headers
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/core.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/bpf_perf.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/threadmap.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/cpumap.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/evlist.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/core.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/cpumap.o
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/evsel.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/event.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/mmap.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/schedstat-v15.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/schedstat-v16.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/threadmap.o
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/schedstat-v17.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/evsel.o
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/cpumap.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libsymbol/include/symbol/kallsyms.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/evlist.o
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/evlist.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/evsel.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libsymbol/kallsyms.o
  MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fd/
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/lib.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/cpu.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/debug.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/mmap.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/io.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libapi/cpu.o
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/io_dir.h
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/rc_check.h
  MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fs/
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/fd/array.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/mmap.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fd/array.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libapi/debug.o
  INSTALL libsymbol_headers
  MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fs/
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/threadmap.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libapi/str_error_r.o
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/fs/fs.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/zalloc.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/fs.o
  MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fs/
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/fs/tracing_path.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/xyarray.o
  INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/xyarray.h
  CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/tracing_path.o
  LINK    dlfilters/dlfilter-show-cycles.so
  CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/cgroup.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/lib.o
  INSTALL libperf_headers
  INSTALL libapi_headers
  LINK    dlfilters/dlfilter-test-api-v0.so
  LINK    dlfilters/dlfilter-test-api-v2.so
  LD      /home/acme/git/perf-tools-next/tools/perf/libapi/fd/libapi-in.o
  LD      /home/acme/git/perf-tools-next/tools/perf/libsymbol/libsymbol-in.o
  AR      /home/acme/git/perf-tools-next/tools/perf/libsymbol/libsymbol.a
  LD      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/libapi-in.o
  LD      /home/acme/git/perf-tools-next/tools/perf/libapi/libapi-in.o
  AR      /home/acme/git/perf-tools-next/tools/perf/libapi/libapi.a
  CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/exec-cmd.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/help.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/pager.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/parse-options.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/run-command.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/sigchain.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/subcmd-config.o
  LD      /home/acme/git/perf-tools-next/tools/perf/libperf/libperf-in.o
  AR      /home/acme/git/perf-tools-next/tools/perf/libperf/libperf.a
  LD      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/libsubcmd-in.o
  AR      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/libsubcmd.a
  CC      builtin-bench.o
  CC      builtin-annotate.o
  CC      bench/sched-messaging.o
  CC      ui/setup.o
  CC      bench/sched-pipe.o
  CC      ui/helpline.o
  CC      tests/builtin-test.o
  CC      builtin-check.o
  CC      bench/sched-seccomp-notify.o
  CC      tests/tests-scripts.o
  CC      builtin-config.o
  CC      ui/progress.o
  CC      bench/syscall.o
  CC      builtin-diff.o
  CC      tests/parse-events.o
  LD      scripts/perf-util-in.o
  CC      arch/common.o
  CC      bench/mem-functions.o
  CC      ui/util.o
  CC      tests/dso-data.o
  CC      builtin-evlist.o
  CC      builtin-ftrace.o
  CC      tests/vmlinux-kallsyms.o
  CC      bench/futex.o
  CC      ui/hist.o
  CC      bench/futex-hash.o
  CC      builtin-help.o
  CC      bench/futex-wake.o
  CC      arch/x86/tests/arch-tests.o
  CC      arch/x86/util/header.o
  CC      arch/x86/tests/hybrid.o
  CC      ui/stdio/hist.o
  CC      util/annotate-arch/annotate-arc.o
  CC      util/annotate-arch/annotate-arm.o
  CC      bench/futex-wake-parallel.o
  CC      arch/x86/tests/intel-pt-test.o
  CC      arch/x86/tests/bp-modify.o
  CC      arch/x86/tests/amd-ibs-via-core-pmu.o
  CC      arch/x86/util/tsc.o
  CC      arch/x86/util/pmu.o
  CC      tests/openat-syscall.o
  CC      tests/openat-syscall-all-cpus.o
  CC      tests/mmap-basic.o
  CC      tests/perf-record.o
  GEN     pmu-events/arch/x86/amdzen1/extra-metrics.json
  CC      util/annotate-arch/annotate-arm64.o
  CC      util/annotate-arch/annotate-csky.o
  GEN     pmu-events/arch/x86/amdzen2/extra-metrics.json
  CC      tests/evsel-roundtrip-name.o
  GEN     pmu-events/arch/x86/amdzen3/extra-metrics.json
  CC      util/annotate-arch/annotate-loongarch.o
  CC      arch/x86/tests/amd-ibs-period.o
  CC      util/perf-regs-arch/perf_regs_aarch64.o
  CC      builtin-buildid-list.o
  CC      arch/x86/tests/topdown.o
  CC      tests/fdarray.o
  GEN     pmu-events/arch/x86/amdzen4/extra-metrics.json
  CC      arch/x86/util/perf_regs.o
  LD      util/kvm-stat-arch/perf-util-in.o
  GEN     pmu-events/arch/x86/amdzen5/extra-metrics.json
  CC      util/perf-regs-arch/perf_regs_arm.o
  CC      bench/futex-requeue.o
  CC      util/annotate-arch/annotate-mips.o
  CC      util/annotate-arch/annotate-powerpc.o
  CC      util/annotate-arch/annotate-x86.o
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN     pmu-events/arch/x86/amdzen6/extra-metrics.json
  CC      arch/x86/util/topdown.o
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC      util/perf-regs-arch/perf_regs_csky.o
  CC      util/perf-regs-arch/perf_regs_loongarch.o
  CC      util/perf-regs-arch/perf_regs_mips.o
  CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
  CC      arch/x86/util/machine.o
  GEN     pmu-events/arch/x86/amdzen1/extra-metricgroups.json
  CC      bench/futex-lock-pi.o
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  CC      builtin-buildid-cache.o
  GEN     pmu-events/arch/x86/amdzen2/extra-metricgroups.json
  CC      util/perf-regs-arch/perf_regs_powerpc.o
  CC      bench/epoll-wait.o
  CC      util/perf-regs-arch/perf_regs_riscv.o
  LD      util/scripting-engines/perf-util-in.o
  GEN     pmu-events/arch/x86/amdzen3/extra-metricgroups.json
  CC      util/annotate-arch/annotate-riscv64.o
  CC      util/perf-regs-arch/perf_regs_s390.o
  CC      arch/x86/util/event.o
  CC      util/annotate-arch/annotate-s390.o
  CC      tests/pmu.o
  LD      util/hisi-ptt-decoder/perf-util-in.o
  CC      tests/pmu-events.o
  CC      util/arm64-frame-pointer-unwind-support.o
  CC      tests/hists_common.o
  CC      util/perf-regs-arch/perf_regs_x86.o
  GEN     pmu-events/arch/x86/amdzen4/extra-metricgroups.json
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC      util/intel-pt-decoder/intel-pt-log.o
  CC      bench/epoll-ctl.o
  CC      util/addr2line.o
  CC      util/addr_location.o
  CC      tests/hists_link.o
  LD      util/perf-regs-arch/perf-util-in.o
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  GEN     util/intel-pt-decoder/inat-tables.c
  CC      arch/x86/util/evlist.o
  GEN     pmu-events/arch/x86/amdzen5/extra-metricgroups.json
  GEN     pmu-events/arch/x86/amdzen6/extra-metricgroups.json
  CC      bench/synthesize.o
  LD      util/arm-spe-decoder/perf-util-in.o
  CC      bench/kallsyms-parse.o
  CC      tests/hists_filter.o
  CC      util/annotate-arch/annotate-sparc.o
  CC      tests/hists_output.o
  CC      arch/x86/util/mem-events.o
  LD      arch/x86/tests/perf-test-in.o
  CC      arch/x86/util/evsel.o
  LD      arch/x86/perf-test-in.o
  CC      bench/find-bit-bench.o
  CC      builtin-kallsyms.o
  LD      arch/perf-test-in.o
  CC      builtin-list.o
  CC      builtin-record.o
  GEN     pmu-events/arch/arm64/arm/cortex-a34/extra-metrics.json
  CC      util/intel-pt-decoder/insn.o
  CC      util/intel-pt-decoder/inat.o
  CC      util/annotate.o
  CC      bench/inject-buildid.o
  CC      tests/hists_cumulate.o
  LD      util/annotate-arch/perf-util-in.o
  CC      tests/bp_signal.o
  CC      builtin-report.o
  CC      builtin-stat.o
  CC      bench/evlist-open-close.o
  CC      bench/breakpoint.o
  CC      bench/pmu-scan.o
  CC      util/blake2s.o
  GEN     pmu-events/arch/arm64/arm/cortex-a35/extra-metrics.json
  CC      bench/uprobe.o
  CC      tests/bp_signal_overflow.o
  CC      arch/x86/util/iostat.o
  CC      builtin-top.o
  CC      util/block-info.o
  CC      util/block-range.o
  GEN     pmu-events/arch/arm64/arm/cortex-a510/extra-metrics.json
  CC      bench/mem-memcpy-x86-64-asm.o
  GEN     pmu-events/arch/arm64/arm/cortex-a53/extra-metrics.json
  CC      builtin-script.o
  CC      arch/x86/util/auxtrace.o
  CC      util/build-id.o
  CC      builtin-kvm.o
  CC      bench/mem-memset-x86-64-asm.o
  CC      builtin-inject.o
  CC      tests/bp_account.o
  CC      arch/x86/util/intel-pt.o
  CC      util/cacheline.o
  CC      builtin-mem.o
  GEN     pmu-events/arch/arm64/arm/cortex-a55/extra-metrics.json
  CC      tests/wp.o
  CC      arch/x86/util/intel-bts.o
  CC      tests/task-exit.o
  CC      builtin-data.o
  LD      bench/perf-bench-in.o
  CC      builtin-version.o
  LD      perf-bench-in.o
  CC      builtin-c2c.o
  GEN     pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metrics.json
  CC      builtin-daemon.o
  AR      libperf-bench.a
  CC      util/config.o
  CC      util/copyfile.o
  CC      perf.o
  GEN     pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metrics.json
  LD      arch/perf-in.o
  CC      tests/sw-clock.o
  CC      tests/mmap-thread-lookup.o
  GEN     pmu-events/arch/arm64/arm/cortex-a710/extra-metrics.json
  CC      tests/thread-maps-share.o
  CC      tests/keep-tracking.o
  CC      util/ctype.o
  CC      util/db-export.o
  GEN     pmu-events/arch/arm64/arm/cortex-a73/extra-metrics.json
  CC      util/disasm.o
  CC      tests/code-reading.o
  CC      tests/sample-parsing.o
  CC      tests/parse-no-sample-id-all.o
  GEN     pmu-events/arch/arm64/arm/cortex-a75/extra-metrics.json
  CC      tests/kmod-path.o
  CC      util/env.o
  CC      tests/thread-map.o
  GEN     pmu-events/arch/arm64/arm/cortex-a76/extra-metrics.json
  CC      util/event.o
  CC      util/evlist.o
  CC      util/sideband_evlist.o
  CC      tests/topology.o
  GEN     pmu-events/arch/arm64/arm/cortex-a77/extra-metrics.json
  CC      util/evsel.o
  CC      tests/mem.o
  CC      util/evsel_fprintf.o
  CC      util/perf_event_attr_fprintf.o
  CC      util/evswitch.o
  CC      util/find_bit.o
  GEN     pmu-events/arch/arm64/arm/cortex-a78/extra-metrics.json
  CC      tests/cpumap.o
  CC      util/levenshtein.o
  CC      tests/stat.o
  GEN     pmu-events/arch/arm64/arm/cortex-x1/extra-metrics.json
  CC      util/llvm.o
  CXX     util/llvm-c-helpers.o
  GEN     pmu-events/arch/arm64/arm/cortex-x2/extra-metrics.json
  CC      util/mmap.o
  CC      tests/event_update.o
  CC      tests/event-times.o
  CC      tests/expr.o
  CC      util/memswap.o
  BISON   util/parse-events-bison.c
  LD      arch/x86/util/perf-util-in.o
  LD      arch/x86/perf-util-in.o
  GEN     pmu-events/arch/arm64/arm/neoverse-n1/extra-metrics.json
  LD      arch/perf-util-in.o
  CC      tests/backward-ring-buffer.o
  CC      tests/sdt.o
  CC      tests/is_printable_array.o
  CC      util/print-events.o
  CC      tests/bitmap.o
  GEN     pmu-events/arch/arm64/arm/neoverse-n2-v2/extra-metrics.json
  CC      tests/perf-hooks.o
  CC      util/tracepoint.o
  CC      tests/unit_number__scnprintf.o
  CC      util/perf_regs.o
  CC      util/path.o
  CC      util/print_binary.o
  GEN     pmu-events/arch/arm64/arm/neoverse-n3/extra-metrics.json
  CC      tests/mem2node.o
  CC      tests/maps.o
  CC      tests/time-utils-test.o
  CC      util/print_insn.o
  CC      tests/genelf.o
  CC      tests/api-io.o
  CC      util/rlimit.o
  CC      util/argv_split.o
  CC      tests/demangle-java-test.o
  GEN     pmu-events/arch/arm64/arm/neoverse-v1/extra-metrics.json
  GEN     pmu-events/arch/arm64/arm/neoverse-v3/extra-metrics.json
  CC      util/rbtree.o
  CC      util/libstring.o
  CC      tests/demangle-ocaml-test.o
  CC      tests/demangle-rust-v0-test.o
  CC      tests/pfm.o
  CC      tests/parse-metric.o
  CC      tests/pe-file-parsing.o
  CC      util/bitmap.o
  CC      tests/expand-cgroup.o
  GEN     pmu-events/arch/arm64/arm/cortex-a34/extra-metricgroups.json
  CC      util/hweight.o
  CC      tests/perf-time-to-tsc.o
  GEN     pmu-events/arch/arm64/arm/cortex-a35/extra-metricgroups.json
  CC      util/smt.o
  CC      tests/dlfilter-test.o
  CC      tests/sigtrap.o
  GEN     pmu-events/arch/arm64/arm/cortex-a510/extra-metricgroups.json
  CC      util/strbuf.o
  CC      tests/event_groups.o
  CC      tests/symbols.o
  CC      tests/util.o
  GEN     pmu-events/arch/arm64/arm/cortex-a53/extra-metricgroups.json
  CC      tests/hwmon_pmu.o
  CC      util/string.o
  GEN     pmu-events/arch/arm64/arm/cortex-a55/extra-metricgroups.json
  CC      tests/tool_pmu.o
  CC      util/strlist.o
  CC      util/strfilter.o
  GEN     pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metricgroups.json
  CC      util/top.o
  GEN     pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metricgroups.json
  CC      util/usage.o
  CC      util/dso.o
  CC      tests/subcmd-help.o
  CC      tests/kallsyms-split.o
  GEN     pmu-events/arch/arm64/arm/cortex-a710/extra-metricgroups.json
  CC      tests/workloads/noploop.o
  CC      util/dsos.o
  CC      util/symbol.o
  GEN     pmu-events/arch/arm64/arm/cortex-a73/extra-metricgroups.json
  CC      util/symbol_fprintf.o
  CC      util/map_symbol.o
  CC      tests/workloads/thloop.o
  CC      tests/workloads/leafloop.o
  GEN     pmu-events/arch/arm64/arm/cortex-a75/extra-metricgroups.json
  CC      util/color.o
  CC      util/color_config.o
  LD      util/intel-pt-decoder/perf-util-in.o
  CC      tests/workloads/sqrtloop.o
  GEN     pmu-events/arch/arm64/arm/cortex-a76/extra-metricgroups.json
  CC      tests/workloads/brstack.o
  CC      tests/workloads/datasym.o
  CC      tests/workloads/landlock.o
  CC      tests/workloads/traploop.o
  CC      tests/workloads/inlineloop.o
  GEN     pmu-events/arch/arm64/arm/cortex-a77/extra-metricgroups.json
  CC      util/metricgroup.o
  CC      util/header.o
  CC      util/callchain.o
  CC      util/values.o
  GEN     pmu-events/arch/arm64/arm/cortex-a78/extra-metricgroups.json
  CC      util/fncache.o
  CC      util/debug.o
  CC      util/machine.o
  CC      util/map.o
  GEN     pmu-events/arch/arm64/arm/cortex-x1/extra-metricgroups.json
  CC      util/maps.o
  CC      util/pstack.o
  GEN     pmu-events/arch/arm64/arm/cortex-x2/extra-metricgroups.json
  CC      util/session.o
  CC      util/tool.o
  CC      util/sample.o
  CC      util/sample-raw.o
  GEN     pmu-events/arch/arm64/arm/neoverse-n1/extra-metricgroups.json
  CC      util/s390-sample-raw.o
  CC      util/amd-sample-raw.o
  LD      tests/workloads/perf-test-in.o
  LD      tests/perf-test-in.o
  GEN     pmu-events/arch/arm64/arm/neoverse-n2-v2/extra-metricgroups.json
  LD      perf-test-in.o
  CC      util/ordered-events.o
  GEN     pmu-events/arch/arm64/arm/neoverse-n3/extra-metricgroups.json
  CC      util/namespaces.o
  CC      util/comm.o
  AR      libperf-test.a
  GEN     pmu-events/arch/arm64/arm/neoverse-v1/extra-metricgroups.json
  CC      util/thread.o
  CC      util/threads.o
  CC      util/thread_map.o
  CC      util/parse-events-bison.o
  GEN     pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
  BISON   util/pmu-bison.c
  GEN     pmu-events/arch/x86/alderlake/extra-metrics.json
  CC      util/pmus.o
  CC      util/drm_pmu.o
  GEN     pmu-events/arch/x86/alderlaken/extra-metrics.json
  GEN     pmu-events/arch/x86/arrowlake/extra-metrics.json
  CC      util/hwmon_pmu.o
  GEN     pmu-events/arch/x86/bonnell/extra-metrics.json
  CC      util/tool_pmu.o
  GEN     pmu-events/arch/x86/broadwell/extra-metrics.json
  CC      util/tp_pmu.o
  GEN     pmu-events/arch/x86/broadwellde/extra-metrics.json
  GEN     pmu-events/arch/x86/broadwellx/extra-metrics.json
  GEN     pmu-events/arch/x86/cascadelakex/extra-metrics.json
  CC      util/svghelper.o
  CC      util/trace-event-info.o
  GEN     pmu-events/arch/x86/clearwaterforest/extra-metrics.json
  CC      util/trace-event-scripting.o
  GEN     pmu-events/arch/x86/elkhartlake/extra-metrics.json
  LD      ui/perf-ui-in.o
  LD      perf-ui-in.o
  GEN     pmu-events/arch/x86/emeraldrapids/extra-metrics.json
  CC      util/sort.o
  GEN     pmu-events/arch/x86/goldmont/extra-metrics.json
  GEN     pmu-events/arch/x86/goldmontplus/extra-metrics.json
  AR      libperf-ui.a
  CC      util/hist.o
  GEN     pmu-events/arch/x86/grandridge/extra-metrics.json
  CC      util/util.o
  CC      util/cpumap.o
  CC      util/affinity.o
  CC      util/cputopo.o
  GEN     pmu-events/arch/x86/graniterapids/extra-metrics.json
  GEN     pmu-events/arch/x86/haswell/extra-metrics.json
  CC      util/cgroup.o
  GEN     pmu-events/arch/x86/haswellx/extra-metrics.json
  CC      util/target.o
  GEN     pmu-events/arch/x86/icelake/extra-metrics.json
  CC      util/rblist.o
  CC      util/intlist.o
  CC      util/vdso.o
  GEN     pmu-events/arch/x86/icelakex/extra-metrics.json
  CC      util/counts.o
  CC      util/stat.o
  GEN     pmu-events/arch/x86/ivybridge/extra-metrics.json
  CC      util/stat-shadow.o
  GEN     pmu-events/arch/x86/ivytown/extra-metrics.json
  GEN     pmu-events/arch/x86/jaketown/extra-metrics.json
  GEN     pmu-events/arch/x86/knightslanding/extra-metrics.json
  CC      util/stat-display.o
  GEN     pmu-events/arch/x86/lunarlake/extra-metrics.json
  CC      util/perf_api_probe.o
  CC      util/record.o
  CC      util/srcline.o
  CC      util/srccode.o
  GEN     pmu-events/arch/x86/meteorlake/extra-metrics.json
  CC      util/synthetic-events.o
  CC      util/data.o
  CC      util/tsc.o
  GEN     pmu-events/arch/x86/nehalemep/extra-metrics.json
  GEN     pmu-events/arch/x86/nehalemex/extra-metrics.json
  GEN     pmu-events/arch/x86/pantherlake/extra-metrics.json
  CC      util/cloexec.o
  GEN     pmu-events/arch/x86/rocketlake/extra-metrics.json
  CC      util/call-path.o
  CC      util/rwsem.o
  CC      util/thread-stack.o
  GEN     pmu-events/arch/x86/sandybridge/extra-metrics.json
  CC      util/spark.o
  GEN     pmu-events/arch/x86/sapphirerapids/extra-metrics.json
  GEN     pmu-events/arch/x86/sierraforest/extra-metrics.json
  CC      util/topdown.o
  CC      util/iostat.o
  GEN     pmu-events/arch/x86/silvermont/extra-metrics.json
  CC      util/stream.o
  GEN     pmu-events/arch/x86/skylake/extra-metrics.json
  CC      util/lock-contention.o
  CC      util/auxtrace.o
  GEN     pmu-events/arch/x86/skylakex/extra-metrics.json
  CC      util/intel-pt.o
  GEN     pmu-events/arch/x86/snowridgex/extra-metrics.json
  CC      util/intel-bts.o
  GEN     pmu-events/arch/x86/tigerlake/extra-metrics.json
  CC      util/arm-spe.o
  CC      util/hisi-ptt.o
  CC      util/s390-cpumsf.o
  CC      util/powerpc-vpadtl.o
  GEN     pmu-events/arch/x86/westmereep-dp/extra-metrics.json
  LD      perf-in.o
  GEN     pmu-events/arch/x86/westmereep-sp/extra-metrics.json
  CC      util/cs-etm-base.o
  CC      util/parse-branch-options.o
  CC      util/dump-insn.o
  GEN     pmu-events/arch/x86/westmereex/extra-metrics.json
  GEN     pmu-events/arch/x86/alderlake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/alderlaken/extra-metricgroups.json
  CC      util/parse-regs-options.o
  CC      util/parse-sublevel-options.o
  CC      util/term.o
  CC      util/help-unknown-cmd.o
  CC      util/dlfilter.o
  CC      util/mem-events.o
  GEN     pmu-events/arch/x86/arrowlake/extra-metricgroups.json
  CC      util/mem-info.o
  GEN     pmu-events/arch/x86/bonnell/extra-metricgroups.json
  CC      util/vsprintf.o
  CC      util/units.o
  GEN     pmu-events/arch/x86/broadwell/extra-metricgroups.json
  CC      util/time-utils.o
  BISON   util/expr-bison.c
  CC      util/branch.o
  CC      util/mem2node.o
  GEN     pmu-events/arch/x86/broadwellde/extra-metricgroups.json
  CC      util/clockid.o
  CC      util/list_sort.o
  GEN     pmu-events/arch/x86/broadwellx/extra-metricgroups.json
  CC      util/mutex.o
  GEN     pmu-events/arch/x86/cascadelakex/extra-metricgroups.json
  CC      util/sharded_mutex.o
  CC      util/intel-tpebs.o
  CC      util/hashmap.o
  GEN     pmu-events/arch/x86/clearwaterforest/extra-metricgroups.json
  CC      util/symbol-minimal.o
  CC      util/data-convert-json.o
  CC      util/cap.o
  CC      util/demangle-ocaml.o
  CC      util/demangle-java.o
  GEN     pmu-events/arch/x86/elkhartlake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/emeraldrapids/extra-metricgroups.json
  CC      util/demangle-rust-v0.o
  CC      util/perf-hooks.o
  GEN     pmu-events/arch/x86/goldmont/extra-metricgroups.json
  FLEX    util/parse-events-flex.c
  FLEX    util/pmu-flex.c
  CC      util/pmu-bison.o
  FLEX    util/expr-flex.c
  CC      util/expr-bison.o
  CC      util/parse-events.o
  GEN     pmu-events/arch/x86/goldmontplus/extra-metricgroups.json
  CC      util/parse-events-flex.o
  GEN     pmu-events/arch/x86/grandridge/extra-metricgroups.json
  GEN     pmu-events/arch/x86/graniterapids/extra-metricgroups.json
  CC      util/pmu.o
  GEN     pmu-events/arch/x86/haswell/extra-metricgroups.json
  CC      util/pmu-flex.o
  GEN     pmu-events/arch/x86/haswellx/extra-metricgroups.json
  CC      util/expr-flex.o
  CC      util/expr.o
  GEN     pmu-events/arch/x86/icelake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/icelakex/extra-metricgroups.json
  GEN     pmu-events/arch/x86/ivybridge/extra-metricgroups.json
  GEN     pmu-events/arch/x86/ivytown/extra-metricgroups.json
  GEN     pmu-events/arch/x86/jaketown/extra-metricgroups.json
  GEN     pmu-events/arch/x86/knightslanding/extra-metricgroups.json
  GEN     pmu-events/arch/x86/lunarlake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/meteorlake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/nehalemep/extra-metricgroups.json
  GEN     pmu-events/arch/x86/nehalemex/extra-metricgroups.json
  GEN     pmu-events/arch/x86/pantherlake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/rocketlake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/sandybridge/extra-metricgroups.json
  GEN     pmu-events/arch/x86/sapphirerapids/extra-metricgroups.json
  GEN     pmu-events/arch/x86/sierraforest/extra-metricgroups.json
  GEN     pmu-events/arch/x86/silvermont/extra-metricgroups.json
  GEN     pmu-events/arch/x86/skylake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/skylakex/extra-metricgroups.json
  GEN     pmu-events/arch/x86/snowridgex/extra-metricgroups.json
  GEN     pmu-events/arch/x86/tigerlake/extra-metricgroups.json
  GEN     pmu-events/arch/x86/westmereep-dp/extra-metricgroups.json
  GEN     pmu-events/arch/x86/westmereep-sp/extra-metricgroups.json
  GEN     pmu-events/arch/x86/westmereex/extra-metricgroups.json
  TEST    pmu-events/metric_test.log
  GEN     pmu-events/test-empty-pmu-events.c
  TEST    pmu-events/empty-pmu-events.log
  GEN     pmu-events/pmu-events.c
  LD      util/perf-util-in.o
  LD      perf-util-in.o
  AR      libperf-util.a
  CC      pmu-events/pmu-events.o
  LD      pmu-events/pmu-events-in.o
  AR      libpmu-events.a
  LINK    perf
/usr/bin/ld: libperf-util.a(perf-util-in.o): in function `symbol__disassemble_llvm':
(.text+0x30712): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: libperf-util.a(perf-util-in.o): in function `parse_uid':
(.text+0xb4cd5): warning: Using 'getpwnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: (.text+0xb4d3a): warning: Using 'getpwuid_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: perf-in.o: in function `cmd_kvm':
(.text+0x37078): undefined reference to `kvm_add_default_arch_event'
/usr/bin/ld: (.text+0x3719c): undefined reference to `kvm_add_default_arch_event'
/usr/bin/ld: (.text+0x3735a): undefined reference to `kvm_add_default_arch_event'
/usr/bin/ld: (.text+0x373bb): undefined reference to `kvm_add_default_arch_event'
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:806: perf] Error 1
make[3]: *** [Makefile.perf:286: sub-make] Error 2
make[2]: *** [Makefile:76: all] Error 2
  test: test -x ./perf
make[1]: *** [tests/make:337: make_static] Error 1
make: *** [Makefile:109: build-test] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

real	0m21.807s
user	2m35.853s
sys	0m17.941s
⬢ [acme@toolbx perf-tools-next]$


