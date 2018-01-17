From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/32] perf/core improvements and fixes
Date: Wed, 17 Jan 2018 17:22:02 +0100
Message-ID: <20180117162202.ucs3xwtuwf5pq5nt@gmail.com>
References: <20180117161222.15611-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@gmail.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Federico Vaga <federico.vaga@vaga.pv.it>, Gopanapalli Pradeep <prap_hai@yahoo.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Joe Perches <joe@perches.com>, Kan Liang <kan.liang@intel.com>, Kim Phillips <kim.phillips@arm.com>, linux-arm-kernel@lists.infra
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
> The following changes since commit 1ccb8feda7471efb62ebf68d70055b4c51fa7d92:
> 
>   Merge tag 'perf-core-for-mingo-4.16-20180110' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-01-11 06:53:06 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.16-20180117
> 
> for you to fetch changes up to 81fccd6ca507d3b2012eaf1edeb9b1dbf4bd22db:
> 
>   perf record: Fix failed memory allocation for get_cpuid_str (2018-01-17 10:31:25 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Fix various per event 'max-stack' and 'call-graph=dwarf' issues,
>   mostly in 'perf trace', allowing to use 'perf trace --call-graph' with
>   'dwarf' and 'fp' to setup the callgraph details for the syscall events
>   and make that apply to other events, whilhe allowing to override that on
>   a per-event basis, using '-e sched:*switch/call-graph=dwarf/' for
>   instance (Arnaldo Carvalho de Melo)
> 
> - Improve the --time percent support in record/report/script (Jin Yao)
> 
> - Fix copyfile_offset update of output offset (Jiri Olsa)
> 
> - Add python script to profile and resolve physical mem type (Kan Liang)
> 
> - Add ARM Statistical Profiling Extensions (SPE) support (Kim Phillips)
> 
> - Remove trailing semicolon in the evlist code (Luis de Bethencourt)
> 
> - Fix incorrect handling of type _TERM_DRV_CFG (Mathieu Poirier)
> 
> - Use asprintf when possible in libtraceevent (Federico Vaga)
> 
> - Fix bad force_token escape sequence in libtraceevent (Michael Sartain)
> 
> - Add UL suffix to MISSING_EVENTS in libtraceevent (Michael Sartain)
> 
> - value of unknown symbolic fields in libtraceevent (Jan Kiszka)
> 
> - libtraceevent updates: (Steven Rostedt)
>   o Show value of flags that have not been parsed
>   o Simplify pointer print logic and fix %pF
>   o Handle new pointer processing of bprint strings
>   o Show contents (in hex) of data of unrecognized type records
>   o Fix get_field_str() for dynamic strings
> 
> - Add missing break in FALSE case of pevent_filter_clear_trivial() (Taeung Song)
> 
> - Fix failed memory allocation for get_cpuid_str (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> 
> Arnaldo Carvalho de Melo (8):
>       perf trace: No need to set PERF_SAMPLE_IDENTIFIER explicitely
>       perf evsel: Check if callchain is enabled before setting it up
>       perf trace: Fix setting of --call-graph/--max-stack for non-syscall events
>       perf callchain: Fix attr.sample_max_stack setting
>       perf unwind: Do not look just at the global callchain_param.record_mode
>       perf trace: Setup DWARF callchains for non-syscall events when --max-stack is used
>       perf trace: Allow overriding global --max-stack per event
>       perf callchains: Ask for PERF_RECORD_MMAP for data mmaps for DWARF unwinding
> 
> Federico Vaga (1):
>       tools lib traceevent: Use asprintf when possible
> 
> Jan Kiszka (1):
>       tools lib traceevent: Print value of unknown symbolic fields
> 
> Jin Yao (8):
>       perf report: Improve error msg when no first/last sample time found
>       perf script: Improve error msg when no first/last sample time found
>       perf util: Improve error checking for time percent input
>       perf util: Support no index time percent slice
>       perf report: Add an indication of what time slices are used
>       perf util: Allocate time slices buffer according to number of comma
>       perf report: Remove the time slices number limitation
>       perf script: Remove the time slices number limitation
> 
> Jiri Olsa (1):
>       perf tools: Fix copyfile_offset update of output offset
> 
> Kan Liang (1):
>       perf script python: Add script to profile and resolve physical mem type
> 
> Kim Phillips (1):
>       perf tools: Add ARM Statistical Profiling Extensions (SPE) support
> 
> Luis de Bethencourt (1):
>       perf evlist: Remove trailing semicolon
> 
> Mathieu Poirier (1):
>       perf evsel: Fix incorrect handling of type _TERM_DRV_CFG
> 
> Michael Sartain (2):
>       tools lib traceevent: Fix bad force_token escape sequence
>       tools lib traceevent: Add UL suffix to MISSING_EVENTS
> 
> Steven Rostedt (VMware) (5):
>       tools lib traceevent: Show value of flags that have not been parsed
>       tools lib traceevent: Simplify pointer print logic and fix %pF
>       tools lib traceevent: Handle new pointer processing of bprint strings
>       tools lib traceevent: Show contents (in hex) of data of unrecognized type records
>       tools lib traceevent: Fix get_field_str() for dynamic strings
> 
> Taeung Song (1):
>       tools lib traceevent: Fix missing break in FALSE case of pevent_filter_clear_trivial()
> 
> Thomas Richter (1):
>       perf record: Fix failed memory allocation for get_cpuid_str
> 
>  tools/lib/traceevent/event-parse.c                 |  62 ++-
>  tools/lib/traceevent/event-plugin.c                |  24 +-
>  tools/lib/traceevent/kbuffer-parse.c               |   4 +-
>  tools/lib/traceevent/parse-filter.c                |  22 +-
>  tools/perf/Documentation/perf-report.txt           |   2 +-
>  tools/perf/Documentation/perf-script.txt           |  10 +-
>  tools/perf/arch/arm/util/auxtrace.c                |  77 +++-
>  tools/perf/arch/arm/util/pmu.c                     |   6 +
>  tools/perf/arch/arm64/util/Build                   |   3 +-
>  tools/perf/arch/arm64/util/arm-spe.c               | 225 ++++++++++
>  tools/perf/arch/x86/util/header.c                  |   2 +-
>  tools/perf/builtin-c2c.c                           |   5 +-
>  tools/perf/builtin-report.c                        |  34 +-
>  tools/perf/builtin-script.c                        |  25 +-
>  tools/perf/builtin-trace.c                         |  62 +--
>  tools/perf/scripts/python/bin/mem-phys-addr-record |  19 +
>  tools/perf/scripts/python/bin/mem-phys-addr-report |   3 +
>  tools/perf/scripts/python/mem-phys-addr.py         |  95 +++++
>  tools/perf/tests/dwarf-unwind.c                    |   1 +
>  tools/perf/util/Build                              |   2 +
>  tools/perf/util/arm-spe-pkt-decoder.c              | 462 +++++++++++++++++++++
>  tools/perf/util/arm-spe-pkt-decoder.h              |  43 ++
>  tools/perf/util/arm-spe.c                          | 231 +++++++++++
>  tools/perf/util/arm-spe.h                          |  31 ++
>  tools/perf/util/auxtrace.c                         |   3 +
>  tools/perf/util/auxtrace.h                         |   1 +
>  tools/perf/util/callchain.c                        |  10 +
>  tools/perf/util/callchain.h                        |   2 +
>  tools/perf/util/evlist.c                           |   2 +-
>  tools/perf/util/evsel.c                            |  40 +-
>  .../util/scripting-engines/trace-event-python.c    |   2 +
>  tools/perf/util/time-utils.c                       |  72 +++-
>  tools/perf/util/time-utils.h                       |   2 +
>  tools/perf/util/unwind-libunwind-local.c           |   9 +-
>  tools/perf/util/util.c                             |   2 +-
>  35 files changed, 1465 insertions(+), 130 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/arm-spe.c
>  create mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-record
>  create mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-report
>  create mode 100644 tools/perf/scripts/python/mem-phys-addr.py
>  create mode 100644 tools/perf/util/arm-spe-pkt-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-pkt-decoder.h
>  create mode 100644 tools/perf/util/arm-spe.c
>  create mode 100644 tools/perf/util/arm-spe.h

Pulled, thanks a lot Arnaldo!

	Ingo
