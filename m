From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Fri, 23 Aug 2019 12:30:45 +0200
Message-ID: <20190823103045.GA90468@gmail.com>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Gerald Baeza <gerald.baeza@st.com>, Nageswara R Sastry <nasastry@in.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 4e92b18e5b0b61211f4511cdbc5803300eeead40:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190820' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-08-20 21:38:22 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190822
> 
> for you to fetch changes up to d9c5c083416500e95da098c01be092b937def7fa:
> 
>   libperf: Fix alignment trap with xyarray contents in 'perf stat' (2019-08-22 17:16:57 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf c2c:
> 
>   Ravi Bangoria:
> 
>   - Fix report with offline cpus.
> 
> libperf:
> 
>   Gerald BAEZA:
> 
>   - Fix alignment trap with xyarray contents in 'perf stat', noticed on ARMv7.
> 
>   Jiri Olsa:
> 
>   - Move some more cpu_map and thread_map methods from tools/perf/util/ to libperf.
> 
> headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Do some house cleaning on the headers, removing needless includes in some places,
>     providing forward declarations when those are the only thing needed, and fixing
>     up the fallout from that for cases where we were using stuff and not adding the
>     necessary headers. Should speed up the build and avoid needless rebuilds when
>     something unrelated gets touched.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (18):
>       perf arm64: Add missing debug.h header
>       perf kvm s390: Add missing string.h header
>       perf metricgroup: Remove needless includes from metricgroup.h
>       perf evsel: Move xyarray.h from evsel.c to evsel.h to reduce include dep tree
>       perf counts: Add missing headers needed for types used
>       perf bpf: Add missing xyarray.h header
>       perf evlist: Add missing xyarray.h header
>       perf script: Add missing counts.h
>       perf tests: Add missing counts.h
>       perf stat: Add missing counts.h
>       perf scripting python: Add missing counts.h header
>       perf evsel: Add missing perf/evsel.h header in util/evsel.h
>       perf evsel: Remove needless counts.h header from util/evsel.h
>       perf evsel: Remove needless stddef.h from util/evsel.h
>       perf evsel: util/evsel.h needs stdio.h as it uses FILE
>       perf x86 kvm-stat: Add missing string.h header
>       perf evsel: Switch to libperf's cpumap.h
>       perf cpumap: Remove needless includes from cpumap.h
> 
> Gerald BAEZA (1):
>       libperf: Fix alignment trap with xyarray contents in 'perf stat'
> 
> Jiri Olsa (5):
>       tools headers: Add missing perf_event.h include
>       perf tools: Use perf_cpu_map__nr instead of cpu_map__nr
>       libperf: Move perf's cpu_map__empty() to perf_cpu_map__empty()
>       libperf: Move perf's cpu_map__idx() to perf_cpu_map__idx()
>       libperf: Add perf_thread_map__nr/perf_thread_map__pid functions
> 
> Ravi Bangoria (1):
>       perf c2c: Fix report with offline cpus
> 
>  tools/include/linux/ring_buffer.h                  |  1 +
>  tools/perf/arch/arm/util/cs-etm.c                  | 12 ++++----
>  tools/perf/arch/arm64/util/header.c                |  1 +
>  tools/perf/arch/s390/util/kvm-stat.c               |  1 +
>  tools/perf/arch/x86/util/header.c                  |  1 +
>  tools/perf/arch/x86/util/intel-bts.c               |  4 +--
>  tools/perf/arch/x86/util/intel-pt.c                | 10 +++----
>  tools/perf/arch/x86/util/kvm-stat.c                |  1 +
>  tools/perf/builtin-c2c.c                           |  4 +--
>  tools/perf/builtin-ftrace.c                        |  2 +-
>  tools/perf/builtin-script.c                        |  5 ++--
>  tools/perf/builtin-stat.c                          |  8 +++---
>  tools/perf/builtin-trace.c                         |  4 +--
>  tools/perf/lib/cpumap.c                            | 17 ++++++++++++
>  tools/perf/lib/include/internal/cpumap.h           |  2 ++
>  tools/perf/lib/include/internal/xyarray.h          |  3 +-
>  tools/perf/lib/include/perf/cpumap.h               |  2 ++
>  tools/perf/lib/include/perf/threadmap.h            |  2 ++
>  tools/perf/lib/libperf.map                         |  3 ++
>  tools/perf/lib/threadmap.c                         | 10 +++++++
>  tools/perf/tests/mem2node.c                        |  1 +
>  tools/perf/tests/openat-syscall-all-cpus.c         |  1 +
>  tools/perf/tests/openat-syscall.c                  |  1 +
>  tools/perf/tests/thread-map.c                      |  6 ++--
>  tools/perf/util/auxtrace.c                         |  4 +--
>  tools/perf/util/bpf-loader.c                       |  2 ++
>  tools/perf/util/counts.h                           |  4 +++
>  tools/perf/util/cpumap.c                           | 22 ++++-----------
>  tools/perf/util/cpumap.h                           | 17 ++----------
>  tools/perf/util/cputopo.c                          |  2 ++
>  tools/perf/util/env.c                              |  1 +
>  tools/perf/util/event.c                            | 10 +++----
>  tools/perf/util/evlist.c                           | 32 ++++++++++++----------
>  tools/perf/util/evsel.c                            |  6 ++--
>  tools/perf/util/evsel.h                            | 12 +++++---
>  tools/perf/util/mem2node.c                         |  1 +
>  tools/perf/util/metricgroup.c                      |  3 +-
>  tools/perf/util/metricgroup.h                      | 13 +++++----
>  tools/perf/util/mmap.c                             |  2 +-
>  tools/perf/util/pmu.c                              |  1 +
>  tools/perf/util/record.c                           |  2 +-
>  .../util/scripting-engines/trace-event-python.c    |  3 +-
>  tools/perf/util/stat-display.c                     |  7 +++--
>  tools/perf/util/stat.c                             |  7 +++--
>  tools/perf/util/svghelper.c                        |  1 +
>  tools/perf/util/thread_map.c                       |  4 +--
>  tools/perf/util/thread_map.h                       | 10 -------
>  47 files changed, 155 insertions(+), 113 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
