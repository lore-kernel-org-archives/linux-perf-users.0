From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/43] perf/core improvements and fixes
Date: Fri, 15 Feb 2019 10:20:02 +0100
Message-ID: <20190215092002.GA76493@gmail.com>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, David Carrillo-Cisneros <davidca@fb.com>, Jin Yao <yao.jin@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Paul Clarke <pc@us.ibm.com>, Song Liu <songliubraving@fb.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit af63147c1edacfb75a28885a7cd7e6f44e626164:
> 
>   perf/x86/intel: Add counter freezing quirk for Goldmont (2019-02-11 08:00:42 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190214
> 
> for you to fetch changes up to 44ec8396e2dadf0f0806767642cfac9e04d0d5b1:
> 
>   tools build feature sched_getcpu: Undef _GNU_SOURCE at the end (2019-02-14 15:39:21 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf list:
> 
>   Jiri Olsa:
> 
>   - Display metric expressions for --details option
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Implement --affinity=node|cpu option, leftover, the other patches
>     in this kit were already applied.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix segfaults due to not properly handling negative file descriptor syscall args.
> 
>   - Fix segfault related to the 'waitid' 'options' prefix showing logic.
> 
>   - Filter out 'gnome-terminal*' if it is a parent of 'perf trace', to reduce the
>     syscall feedback loop in system wide sessions.
> 
> BPF:
> 
>   Song Liu:
> 
>   - Silence "Couldn't synthesize bpf events" warning for EPERM.
> 
> Build system:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix the test-all.c feature detection fast path that was broken for
>     quite a while leading to longer build times.
> 
> Event parsing:
> 
>   Jiri Olsa:
> 
>   - Fix legacy events symbol separator parsing
> 
> cs-etm:
> 
>   Mathieu Poirier:
> 
>   - Fix some error path return errors and plug some memory leaks.
> 
>   - Add proper header file for symbols
> 
>   - Remove unused structure fields.
> 
>   - Modularize auxtrace_buffer fetch, decoder and packet processing loop.
> 
> Vendor events:
> 
>   Paul Clarke:
> 
>   - Add assorted metrics for the Power8 and Power9 architectures.
> 
> perf report:
> 
>   Thomas Richter:
> 
>   - Add s390 diagnostic sampling descriptor size
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexey Budankov (1):
>       perf record: Implement --affinity=node|cpu option
> 
> Arnaldo Carvalho de Melo (11):
>       tools feature: Undef _GNU_SOURCE at the end of feature tests
>       perf beauty ioctl cmd: The 'fd' arg is signed
>       perf trace: Check if the 'fd' is negative when mapping it to pathname
>       perf beauty waitid options: Fix up prefix showing logic
>       tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
>       perf trace: Filter out gnome-terminal* parent
>       perf coresight: Do not test for libopencsd by default
>       perf unwind: Do not put libunwind-{x86,aarch64} in FEATURE_TESTS_BASIC
>       tools build: Add test-reallocarray.c to test-all.c to fix the build
>       perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto
>       tools build feature sched_getcpu: Undef _GNU_SOURCE at the end
> 
> Jiri Olsa (7):
>       perf tools: Compile perf with libperf-in.o instead of libperf.a
>       perf tools: Rename LIB_FILE to LIBPERF_A
>       perf tools: Rename build libperf to perf
>       perf tools: Fix legacy events symbol separator parsing
>       perf list: Display metric expressions for --details option
>       perf header: Get rid of write_it label
>       perf header: Remove unused 'cpu_nr' field  from 'struct cpu_topo'
> 
> Mathieu Poirier (14):
>       perf cs-etm: Add proper header file for symbols
>       perf cs-etm: Remove unused structure field "state"
>       perf cs-etm: Remove unused structure field "time" and "timestamp"
>       perf cs-etm: Fix wrong return values in error path
>       perf cs-etm: Introducing function cs_etm_decoder__init_dparams()
>       perf cs-etm: Fix memory leak in error path
>       perf cs-etm: Introducing function cs_etm__init_trace_params()
>       perf cs-etm: Fix erroneous comment
>       perf cs-etm: Cleaning up function cs_etm__alloc_queue()
>       perf cs-etm: Rethink kernel address initialisation
>       perf cs-etm: Make cs_etm__run_decoder() queue independent
>       perf cs-etm: Modularize main decoder function
>       perf cs-etm: Modularize main packet processing loop
>       perf cs-etm: Modularize auxtrace_buffer fetch function
> 
> Paul Clarke (8):
>       perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics
>       perf vendor events power8: Dl1_reload, instruction_misses, l2_stats, lsu_rejects, memory & pteg_reloads metrics
>       perf vendor events power8: Branch_prediction, latency, bus_stats, instruction_mix & instruction_stats metrics
>       perf vendor events power8: Translaton & general metrics
>       perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics
>       perf vendor events power9: Dl1_reloads, instruction_misses, l[23]_stats & pteg_reloads metrics
>       perf vendor events power9: Branch_prediction, instruction_stats, latency, lsu_rejects, memory, prefetch & translation metrics
>       perf vendor events power9: General metrics
> 
> Song Liu (1):
>       perf utils: Silence "Couldn't synthesize bpf events" warning for EPERM
> 
> Thomas Richter (1):
>       perf report: Add s390 diagnosic sampling descriptor size
> 
>  tools/build/Makefile.feature                       |   10 +-
>  tools/build/feature/test-all.c                     |   10 +-
>  tools/build/feature/test-get_current_dir_name.c    |    1 +
>  tools/build/feature/test-libpython.c               |    1 +
>  tools/build/feature/test-reallocarray.c            |    2 +
>  tools/build/feature/test-sched_getcpu.c            |    2 +
>  tools/build/feature/test-setns.c                   |    1 +
>  tools/perf/Build                                   |   10 +-
>  tools/perf/Documentation/perf-record.txt           |    5 +
>  tools/perf/Makefile.config                         |   14 +-
>  tools/perf/Makefile.perf                           |   24 +-
>  tools/perf/arch/Build                              |    4 +-
>  tools/perf/arch/arm/Build                          |    4 +-
>  tools/perf/arch/arm/tests/Build                    |    8 +-
>  tools/perf/arch/arm/util/Build                     |    8 +-
>  tools/perf/arch/arm64/Build                        |    4 +-
>  tools/perf/arch/arm64/tests/Build                  |    6 +-
>  tools/perf/arch/arm64/util/Build                   |   12 +-
>  tools/perf/arch/nds32/Build                        |    2 +-
>  tools/perf/arch/nds32/util/Build                   |    2 +-
>  tools/perf/arch/powerpc/Build                      |    4 +-
>  tools/perf/arch/powerpc/tests/Build                |    6 +-
>  tools/perf/arch/powerpc/util/Build                 |   18 +-
>  tools/perf/arch/s390/Build                         |    2 +-
>  tools/perf/arch/s390/util/Build                    |   12 +-
>  tools/perf/arch/sh/Build                           |    2 +-
>  tools/perf/arch/sh/util/Build                      |    2 +-
>  tools/perf/arch/sparc/Build                        |    2 +-
>  tools/perf/arch/sparc/util/Build                   |    2 +-
>  tools/perf/arch/x86/Build                          |    4 +-
>  tools/perf/arch/x86/tests/Build                    |   14 +-
>  tools/perf/arch/x86/util/Build                     |   30 +-
>  tools/perf/arch/xtensa/Build                       |    2 +-
>  tools/perf/arch/xtensa/util/Build                  |    2 +-
>  tools/perf/builtin-list.c                          |    8 +-
>  tools/perf/builtin-record.c                        |   18 +
>  tools/perf/builtin-trace.c                         |    6 +-
>  .../pmu-events/arch/powerpc/power8/metrics.json    | 2245 ++++++++++++++++++++
>  .../pmu-events/arch/powerpc/power9/metrics.json    | 1982 +++++++++++++++++
>  tools/perf/scripts/Build                           |    4 +-
>  tools/perf/scripts/perl/Perf-Trace-Util/Build      |    2 +-
>  tools/perf/scripts/python/Perf-Trace-Util/Build    |    2 +-
>  tools/perf/tests/parse-events.c                    |   30 +
>  tools/perf/trace/beauty/Build                      |   26 +-
>  tools/perf/trace/beauty/ioctl.c                    |    2 +-
>  tools/perf/trace/beauty/waitid_options.c           |    2 +-
>  tools/perf/ui/Build                                |   18 +-
>  tools/perf/ui/browsers/Build                       |   10 +-
>  tools/perf/ui/tui/Build                            |    8 +-
>  tools/perf/util/Build                              |  276 +--
>  tools/perf/util/bpf-event.c                        |    4 +-
>  tools/perf/util/c++/Build                          |    4 +-
>  tools/perf/util/cs-etm-decoder/Build               |    2 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   10 +-
>  tools/perf/util/cs-etm.c                           |  458 ++--
>  tools/perf/util/cs-etm.h                           |    4 +-
>  tools/perf/util/header.c                           |    8 +-
>  tools/perf/util/intel-pt-decoder/Build             |    2 +-
>  tools/perf/util/metricgroup.c                      |    8 +-
>  tools/perf/util/metricgroup.h                      |    3 +-
>  tools/perf/util/parse-events.c                     |    2 +-
>  tools/perf/util/parse-events.y                     |    4 +-
>  tools/perf/util/s390-cpumsf.c                      |    5 +
>  tools/perf/util/scripting-engines/Build            |    4 +-
>  64 files changed, 4877 insertions(+), 512 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/metrics.json

Pulled, thanks a lot Arnaldo!

	Ingo
