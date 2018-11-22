From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/28] perf/core improvements and fixes
Date: Thu, 22 Nov 2018 07:54:06 +0100
Message-ID: <20181122065406.GA122927@gmail.com>
References: <20181122033611.15890-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Anton Blanchard <anton@samba.org>, Ben Gainey <ben.gainey@arm.com>, Ben Hutchings <ben@decadent.org.uk>, Borislav Petkov <bp@suse.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Kleikamp <dave.kleikamp@oracle.com>, David Ahern <dsahern@gmail.com>, David Aldridge <david.aldridge@oracle.com>, Davidlohr Bueso <dbueso@suse.de>, Edward Cree <ecree@solarflare.com>, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Gustavo Luiz Duarte <gd>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, some from before the trip to Vancouver,
> some that were more easy to process before I continue with the backlog.
> Took a bit more time than I antecipated due to fixing build breakage in
> various places due to multiple patches.  This has tip/perf/urgent
> merged.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b1a9d7b0190119dad5b9b7841751b5a7586bbc8b:
> 
>   Merge tag 'perf-urgent-for-mingo-4.20-20181121' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-11-21 15:57:21 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20181122
> 
> for you to fetch changes up to f4a0742b3cc1d03b2ff448017b8c714a77e5a261:
> 
>   perf pmu: Move *_cpuid_str() weak functions to header.c (2018-11-21 22:39:59 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Start using BPF maps in 'perf trace' for filters in the augmented syscalls
>   code, keeping the existing code for tracepoint filters so that we can switch
>   back and forth while getting everything BPFied (Arnaldo Carvalho de Melo)
> 
> - Suppress potential format-truncation warning in the PMU code (Ben Hutchings)
> 
> - Introduce 'perf bench epoll', with "wait" and "ctl" benchmarks (Davidlohr Bueso)
> 
> - Fix slowness due to -ffunction-section, do it by sorting the maps by name, so
>   avoiding the using rb_first/next to traverse all entries looking for a map name,
>   that with --ffunction-section gets to thousands of maps (Eric Saint-Etienne)
> 
> - Separate jvmti cmlr check (Jiri Olsa)
> 
> - Allow using the stepping when figuring out which JSON files to use for a x86
>   processor, so that Cascadelake server can be support, which has the same
>   cpuid as some other processor, being different only in the stepping (Kan Liang)
> 
> - Share code and output format for uregs and iregs 'perf script' output (Milian Wolff)
> 
> - Use perf_evsel__is_clocki() for clock events in 'perf stat' (Ravi Bangoria)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (15):
>       perf bpf: Add unistd.h to the headers accessible to bpf proggies
>       perf augmented_syscalls: Filter on a hard coded pid
>       perf augmented_syscalls: Remove needless linux/socket.h include
>       perf bpf: Add defines for map insertion/lookup
>       perf bpf: Add simple pid_filter class accessible to BPF proggies
>       perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter
>       perf augmented_syscalls: Use pid_filter
>       perf evlist: Rename perf_evlist__set_filter* to perf_evlist__set_tp_filter*
>       perf trace: Add "_from_option" suffix to trace__set_filter()
>       perf trace: See if there is a map named "filtered_pids"
>       perf trace: Fill in BPF "filtered_pids" map when present
>       perf augmented_syscalls: Remove example hardcoded set of filtered pids
>       Revert "perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter"
>       perf bpf: Reduce the hardcoded .max_entries for pid_maps
>       tools build feature: Check if eventfd() is available
> 
> Ben Hutchings (1):
>       perf pmu: Suppress potential format-truncation warning
> 
> Davidlohr Bueso (3):
>       perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h
>       perf bench: Add epoll parallel epoll_wait benchmark
>       perf bench: Add epoll_ctl(2) benchmark
> 
> Eric Saint-Etienne (1):
>       perf symbols: Fix slowness due to -ffunction-section
> 
> Jiri Olsa (1):
>       perf jvmti: Separate jvmti cmlr check
> 
> Kan Liang (3):
>       perf vendor events: Add stepping in CPUID string for x86
>       perf vendor events: Add JSON metrics for Cascadelake server
>       perf pmu: Move *_cpuid_str() weak functions to header.c
> 
> Milian Wolff (2):
>       perf script: Add newline after uregs output
>       perf script: Share code and output format for uregs and iregs output
> 
> Pu Wen (1):
>       perf tools: Add Hygon Dhyana support
> 
> Ravi Bangoria (1):
>       perf stat: Use perf_evsel__is_clocki() for clock events
> 
>  tools/build/Makefile.feature                       |     1 +
>  tools/build/feature/Makefile                       |     8 +
>  tools/build/feature/test-all.c                     |     5 +
>  tools/build/feature/test-eventfd.c                 |     9 +
>  tools/build/feature/test-jvmti-cmlr.c              |    11 +
>  tools/build/feature/test-jvmti.c                   |     1 -
>  tools/perf/Documentation/perf-bench.txt            |    10 +
>  tools/perf/Makefile.config                         |    12 +-
>  tools/perf/Makefile.perf                           |     3 +
>  tools/perf/arch/x86/util/header.c                  |    66 +-
>  tools/perf/arch/x86/util/kvm-stat.c                |     2 +-
>  tools/perf/bench/Build                             |     3 +
>  tools/perf/bench/bench.h                           |    14 +
>  tools/perf/bench/epoll-ctl.c                       |   413 +
>  tools/perf/bench/epoll-wait.c                      |   540 +
>  tools/perf/bench/futex.h                           |    12 -
>  tools/perf/builtin-bench.c                         |    13 +
>  tools/perf/builtin-script.c                        |    38 +-
>  tools/perf/builtin-trace.c                         |    92 +-
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   |    10 +-
>  tools/perf/include/bpf/bpf.h                       |    19 +
>  tools/perf/include/bpf/pid_filter.h                |    21 +
>  tools/perf/include/bpf/unistd.h                    |    10 +
>  tools/perf/jvmti/libjvmti.c                        |    12 +
>  .../pmu-events/arch/x86/cascadelakex/cache.json    | 10172 +++++++++++++++++++
>  .../arch/x86/cascadelakex/clx-metrics.json         |   164 +
>  .../arch/x86/cascadelakex/floating-point.json      |    85 +
>  .../pmu-events/arch/x86/cascadelakex/frontend.json |   482 +
>  .../pmu-events/arch/x86/cascadelakex/memory.json   |  9909 ++++++++++++++++++
>  .../pmu-events/arch/x86/cascadelakex/other.json    |  8908 ++++++++++++++++
>  .../pmu-events/arch/x86/cascadelakex/pipeline.json |   969 ++
>  .../arch/x86/cascadelakex/uncore-memory.json       |   117 +
>  .../arch/x86/cascadelakex/uncore-other.json        |   255 +
>  .../arch/x86/cascadelakex/virtual-memory.json      |   285 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv         |     3 +-
>  tools/perf/util/evlist.c                           |    10 +-
>  tools/perf/util/evlist.h                           |     6 +-
>  tools/perf/util/header.c                           |    39 +
>  tools/perf/util/map.c                              |    27 +
>  tools/perf/util/map.h                              |     2 +
>  tools/perf/util/pmu.c                              |    47 +-
>  tools/perf/util/stat-shadow.c                      |     3 +-
>  tools/perf/util/symbol.c                           |    15 +-
>  43 files changed, 32711 insertions(+), 112 deletions(-)
>  create mode 100644 tools/build/feature/test-eventfd.c
>  create mode 100644 tools/build/feature/test-jvmti-cmlr.c
>  create mode 100644 tools/perf/bench/epoll-ctl.c
>  create mode 100644 tools/perf/bench/epoll-wait.c
>  create mode 100644 tools/perf/include/bpf/pid_filter.h
>  create mode 100644 tools/perf/include/bpf/unistd.h
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json

Pulled, thanks a lot Arnaldo!

	Ingo
