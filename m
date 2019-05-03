From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/11] perf/urgent fixes
Date: Fri, 3 May 2019 07:49:00 +0200
Message-ID: <20190503054900.GA95556@gmail.com>
References: <20190503002533.29359-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Bo YU <tsu.yubo@gmail.com>, Leo Yan <leo.yan@linaro.org>, Robert Walker <robert.walker@arm.com>, Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, Thomas Backlund <tmb@mageia.org>, Thomas Richter <tmricht@linux.ibm.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	This took a bit more time than I expected as I'm traveling,
> LSF/MM + BPF, and also some of the fixes I worked on and off while on my
> way here needed tweaks,
> 
> Thanks,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 1804569d87de903b4d746ba71512c3ed0a890d65:
> 
>   MAINTAINERS: Include vendor specific files under arch/*/events/* (2019-05-02 18:28:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190502
> 
> for you to fetch changes up to 7e221b811f1472d0c58c7d4e0fe84fcacd22580a:
> 
>   perf tools: Remove needless asm/unistd.h include fixing build in some places (2019-05-02 16:00:20 -0400)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> tools UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync x86's vmx.h with the kernel.
> 
>   - Copy missing unistd.h headers for arc, hexagon and riscv, fixing
>     a reported build regression on the ARC 32-bit architecture.
> 
> perf bench numa:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add define for RUSAGE_THREAD if not present, fixing the build on the
>     ARC architecture when only zlib and libnuma are present.
> 
> perf BPF:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - The disassembler-four-args feature test needs -ldl on distros such as
>     Mageia 7.
> 
>   Bo YU:
> 
>   - Fix unlocking on success in perf_env__find_btf(), detected with
>     the coverity tool.
> 
> libtraceevent:
> 
>   Leo Yan:
> 
>   - Change misleading hard coded 'trace-cmd' string in error messages.
> 
> ARM hardware tracing:
> 
>   Leo Yan:
> 
>   - Always allocate memory for cs_etm_queue::prev_packet, fixing a segfault
>     when processing CoreSight perf data.
> 
> perf annotate:
> 
>   Thadeu Lima de Souza Cascardo:
> 
>   - Fix build on 32 bit for BPF.
> 
> perf report:
> 
>   Thomas Richter:
> 
>   - Report OOM in status line in the GTK UI.
> 
> core libs:
> 
>   - Remove needless asm/unistd.h that, used with sys/syscall.h ended
>     up redefining the syscalls defines in environments such as the
>     ARC arch when using uClibc.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools uapi x86: Sync vmx.h with the kernel
>       perf bench numa: Add define for RUSAGE_THREAD if not present
>       tools build: Add -ldl to the disassembler-four-args feature test
>       tools arch uapi: Copy missing unistd.h headers for arc, hexagon and riscv
>       perf tools: Remove needless asm/unistd.h include fixing build in some places
> 
> Bo YU (1):
>       perf bpf: Return value with unlocking in perf_env__find_btf()
> 
> Leo Yan (3):
>       tools lib traceevent: Change tag string for error
>       perf cs-etm: Don't check cs_etm_queue::prev_packet validity
>       perf cs-etm: Always allocate memory for cs_etm_queue::prev_packet
> 
> Thadeu Lima de Souza Cascardo (1):
>       perf annotate: Fix build on 32 bit for BPF annotation
> 
> Thomas Richter (1):
>       perf report: Report OOM in status line in the GTK UI
> 
>  tools/arch/arc/include/uapi/asm/unistd.h     | 51 ++++++++++++++++++++++++++++
>  tools/arch/hexagon/include/uapi/asm/unistd.h | 40 ++++++++++++++++++++++
>  tools/arch/riscv/include/uapi/asm/unistd.h   | 42 +++++++++++++++++++++++
>  tools/arch/x86/include/uapi/asm/vmx.h        |  1 +
>  tools/lib/traceevent/parse-utils.c           |  2 +-
>  tools/perf/Makefile.config                   |  2 +-
>  tools/perf/bench/numa.c                      |  4 +++
>  tools/perf/util/annotate.c                   |  8 ++---
>  tools/perf/util/cloexec.c                    |  1 -
>  tools/perf/util/cs-etm.c                     | 14 +++-----
>  tools/perf/util/env.c                        |  2 +-
>  tools/perf/util/session.c                    |  8 +++--
>  12 files changed, 154 insertions(+), 21 deletions(-)
>  create mode 100644 tools/arch/arc/include/uapi/asm/unistd.h
>  create mode 100644 tools/arch/hexagon/include/uapi/asm/unistd.h
>  create mode 100644 tools/arch/riscv/include/uapi/asm/unistd.h

Pulled, thanks a lot Arnaldo!

	Ingo
