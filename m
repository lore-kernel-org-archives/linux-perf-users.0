From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Thu, 16 Apr 2020 12:07:38 +0200
Message-ID: <20200416100738.GC18982@gmail.com>
References: <20200414164854.26026-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.7-20200414
> 
> for you to fetch changes up to e3698b23ecb8c099b4b523e7d5c8c042e93ef15d:
> 
>   tools headers: Synchronize linux/bits.h with the kernel sources (2020-04-14 11:40:05 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf stat:
> 
>   Jin Yao:
> 
>   - Fix no metric header if --per-socket and --metric-only set
> 
> build system:
> 
>   - Fix python building when built with clang, that was failing if the clang
>     version doesn't support -fno-semantic-interposition.
> 
> tools UAPI headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Update various copies of kernel headers, some ended up automatically
>     updating build-time generated tables to enable tools such as 'perf trace'
>     to decode syscalls and tracepoints arguments.
> 
>     Now the tools/perf build is free of UAPI drift warnings.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (14):
>       tools arch x86: Sync the msr-index.h copy with the kernel sources
>       perf python: Check if clang supports -fno-semantic-interposition
>       tools headers: Update linux/vdso.h and grab a copy of vdso/const.h
>       tools headers UAPI: Sync sched.h with the kernel
>       tools headers UAPI: Sync linux/mman.h with the kernel
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
>       tools include UAPI: Sync linux/vhost.h with the kernel sources
>       tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
>       tools headers kvm: Sync linux/kvm.h with the kernel sources
>       tools headers UAPI: Update tools's copy of drm.h headers
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>       tools headers: Update x86's syscall_64.tbl with the kernel sources
>       tools headers: Adopt verbatim copy of compiletime_assert() from kernel sources
>       tools headers: Synchronize linux/bits.h with the kernel sources
> 
> Jin Yao (1):
>       perf stat: Fix no metric header if --per-socket and --metric-only set
> 
>  tools/arch/x86/include/asm/cpufeatures.h          |   5 +-
>  tools/arch/x86/include/asm/msr-index.h            |   9 +
>  tools/include/linux/bits.h                        |  24 +-
>  tools/include/linux/build_bug.h                   |  82 +++
>  tools/include/linux/compiler.h                    |  26 +
>  tools/include/linux/const.h                       |   5 +-
>  tools/include/linux/kernel.h                      |   4 +-
>  tools/include/uapi/drm/drm.h                      |   2 +
>  tools/include/uapi/drm/i915_drm.h                 |  21 +
>  tools/include/uapi/linux/fscrypt.h                |   1 +
>  tools/include/uapi/linux/kvm.h                    |  47 +-
>  tools/include/uapi/linux/mman.h                   |   5 +-
>  tools/include/uapi/linux/sched.h                  |   5 +
>  tools/include/uapi/linux/vhost.h                  |  24 +
>  tools/include/vdso/bits.h                         |   9 +
>  tools/include/vdso/const.h                        |  10 +
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 740 +++++++++++-----------
>  tools/perf/check-headers.sh                       |   3 +
>  tools/perf/trace/beauty/clone.c                   |   1 +
>  tools/perf/trace/beauty/mmap.c                    |   1 +
>  tools/perf/util/setup.py                          |   2 +
>  tools/perf/util/stat-shadow.c                     |   7 +-
>  22 files changed, 646 insertions(+), 387 deletions(-)
>  create mode 100644 tools/include/linux/build_bug.h
>  create mode 100644 tools/include/vdso/bits.h
>  create mode 100644 tools/include/vdso/const.h

Pulled into tip:perf/urgent, thanks a lot Arnaldo!

	Ingo
