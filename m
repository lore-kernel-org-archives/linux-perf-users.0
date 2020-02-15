From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Date: Sat, 15 Feb 2020 09:36:43 +0100
Message-ID: <20200215083643.GA59911@gmail.com>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Kim Phillips <kim.phillips@amd.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200214
> 
> for you to fetch changes up to 62765941155e487b351a72479078bd6fec973563:
> 
>   perf llvm: Fix script used to obtain kernel make directives to work with new kbuild (2020-02-14 10:06:00 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> BPF:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix script used to obtain kernel make directives to work with new kbuild
>     used for building BPF programs.
> 
> maps:
> 
>   Jiri Olsa:
> 
>   - Fixup kmap->kmaps backpointer in kernel maps.
> 
> arm64:
> 
>   John Garry:
> 
>   - Add arm64 version of get_cpuid() to get proper, arm64 specific output from
>     'perf list' and other tools.
> 
> perf top:
> 
>   Kim Phillips:
> 
>   - Update kernel idle symbols so that output in AMD systems is in line with
>     other systems.
> 
> perf stat:
> 
>   Kim Phillips:
> 
>   - Don't report a null stalled cycles per insn metric.
> 
> tools headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync tools/ headers with the kernel sources to get things like syscall
>     numbers and new arguments so that 'perf trace' can decode and use them in
>     tracepoint filters, e.g. prctl's new PR_{G,S}ET_IO_FLUSHER options.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (15):
>       tools include UAPI: Sync x86's syscalls_64.tbl, generic unistd.h and fcntl.h to pick up openat2 and pidfd_getfd
>       tools headers UAPI: Sync copy of arm64's asm/unistd.h with the kernel sources
>       tools headers UAPI: Sync prctl.h with the kernel sources
>       perf beauty prctl: Export the 'options' strarray
>       perf trace: Resolve prctl's 'option' arg strings to numbers
>       tools headers UAPI: Sync sched.h with the kernel
>       tools headers uapi: Sync linux/fscrypt.h with the kernel sources
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>       tools headers UAPI: Sync asm-generic/mman-common.h with the kernel
>       tools include UAPI: Sync sound/asound.h copy
>       tools headers x86: Sync disabled-features.h
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
>       tools headers kvm: Sync kvm headers with the kernel sources
>       tools headers kvm: Sync linux/kvm.h with the kernel sources
>       perf llvm: Fix script used to obtain kernel make directives to work with new kbuild
> 
> Jiri Olsa (4):
>       perf maps: Mark module DSOs with kernel type
>       perf maps: Mark ksymbol DSOs with kernel type
>       perf maps: Fix map__clone() for struct kmap
>       perf maps: Move kmap::kmaps setup to maps__insert()
> 
> John Garry (1):
>       perf tools: Add arm64 version of get_cpuid()
> 
> Kim Phillips (3):
>       perf stat: Don't report a null stalled cycles per insn metric
>       perf symbols: Update the list of kernel idle symbols
>       perf symbols: Convert symbol__is_idle() to use strlist
> 
>  tools/arch/arm64/include/uapi/asm/kvm.h           |  12 +-
>  tools/arch/arm64/include/uapi/asm/unistd.h        |   1 +
>  tools/arch/x86/include/asm/cpufeatures.h          |   2 +
>  tools/arch/x86/include/asm/disabled-features.h    |   8 +-
>  tools/include/uapi/asm-generic/mman-common.h      |   2 +
>  tools/include/uapi/asm-generic/unistd.h           |   7 +-
>  tools/include/uapi/drm/i915_drm.h                 |  32 +++++
>  tools/include/uapi/linux/fcntl.h                  |   2 +-
>  tools/include/uapi/linux/fscrypt.h                |  14 +-
>  tools/include/uapi/linux/kvm.h                    |   5 +
>  tools/include/uapi/linux/openat2.h                |  39 ++++++
>  tools/include/uapi/linux/prctl.h                  |   4 +
>  tools/include/uapi/linux/sched.h                  |   6 +
>  tools/include/uapi/sound/asound.h                 | 155 ++++++++++++++++++----
>  tools/perf/arch/arm64/util/header.c               |  63 ++++++---
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   2 +
>  tools/perf/builtin-trace.c                        |   4 +-
>  tools/perf/check-headers.sh                       |   1 +
>  tools/perf/trace/beauty/beauty.h                  |   2 +
>  tools/perf/trace/beauty/prctl.c                   |   3 +-
>  tools/perf/util/llvm-utils.c                      |   1 +
>  tools/perf/util/machine.c                         |  26 ++--
>  tools/perf/util/map.c                             |  17 ++-
>  tools/perf/util/stat-shadow.c                     |   6 -
>  tools/perf/util/symbol.c                          |  17 ++-
>  25 files changed, 353 insertions(+), 78 deletions(-)
>  create mode 100644 tools/include/uapi/linux/openat2.h

Pulled, thanks a lot Arnaldo!

	Ingo
