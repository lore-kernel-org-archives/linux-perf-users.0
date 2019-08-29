From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Thu, 29 Aug 2019 20:58:07 +0200
Message-ID: <20190829185807.GA109374@gmail.com>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Igor Lubashev <ilubashe@akamai.com>, Karl Rister <krister@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 42880f726c66f13ae1d9ac9ce4c43abe64ecac84:
> 
>   perf/x86/intel: Support PEBS output to PT (2019-08-28 11:29:39 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190829
> 
> for you to fetch changes up to 301011ba622513cb41ced59973972204e0da2f71:
> 
>   tools lib traceevent: Remove unneeded qsort and uses memmove instead (2019-08-29 08:36:12 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf top:
> 
>   Namhyung Kim:
> 
>   - Decay all events in the evlist, we were decaying just the first event
>     in a group.
> 
>   - Fix linking of histograms in different evsels in a event group with more
>     than two events.
> 
>   With the two fixes above a command line such as:
> 
>     # perf top -e '{cycles,instructions,cache-misses,cache-references}
> 
>     Should work as expected, with four columns and with all of them being
>     decayed over time, i.e. less weight is given for older samples.
> 
> perf record:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix collection of build-ids when using setns() to get into namespaces,
>     which had been broken with the introduction of the extra thread to
>     react to PERF_RECORD_BPF_EVENT, i.e. to collect extra info for BPF
>     programs. We need to unshare(CLONE_FS) in that thread so that the
>     main one can do the setns(CLONE_NEWNS) when collectingthe build-ids.
>     Without that symbol resolution gets more difficult and potentially
>     misresolves symbols.
> 
> core:
> 
>   Igor Lubashev:
> 
>   - Further alignment in permission checking via capabilities to how the
>     kernel checks what tooling tries to do.
> 
> PowerPC:
> 
>   Naveen N. Rao:
> 
>   - Sync powerpc syscall.tbl, so that 'perf trace' gets the definitions
>     for recent syscalls.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Move the rest of the PERF_RECORD_ metadata struct definitions so that
>     we can use 'union perf_event'.
> 
> libtraceevent:
> 
>   Steven Rostedt (VMware):
> 
>   - Do not free tep->cmdlines in add_new_comm() on failure.
> 
>   - Remove unneeded qsort and uses memmove instead
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf tools: Remove needless util.h include from builtin.h
>       perf evlist: Remove needless util.h from evlist.h
>       perf clang: Delete needless util-cxx.h header
>       perf evlist: Use unshare(CLONE_FS) in sb threads to let setns(CLONE_NEWNS) work
> 
> Igor Lubashev (5):
>       perf event: Check ref_reloc_sym before using it
>       perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
>       perf evsel: Kernel profiling is disallowed only when perf_event_paranoid > 1
>       perf symbols: Use CAP_SYSLOG with kptr_restrict checks
>       perf tools: Warn that perf_event_paranoid can restrict kernel symbols
> 
> Jiri Olsa (23):
>       libperf: Add PERF_RECORD_HEADER_ATTR 'struct attr_event' to perf/event.h
>       libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h
>       libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_BUILD_ID 'struct build_id_event' to perf/event.h
>       libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
>       libperf: Add PERF_RECORD_ITRACE_START 'struct itrace_start_event' to perf/event.h
>       libperf: Add PERF_RECORD_SWITCH 'struct context_switch_event' to perf/event.h
>       libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
>       libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_FEATURE 'struct feature_event' to perf/event.h
>       libperf: Add PERF_RECORD_COMPRESSED 'struct compressed_event' to perf/event.h
>       libperf: Add 'union perf_event' to perf/event.h
>       libperf: Rename the PERF_RECORD_ structs to have a "perf" prefix
>       libperf: Move 'enum perf_user_event_type' to perf/event.h
> 
> Namhyung Kim (2):
>       perf top: Decay all events in the evlist
>       perf top: Fix event group with more than two events
> 
> Naveen N. Rao (1):
>       perf arch powerpc: Sync powerpc syscall.tbl
> 
> Steven Rostedt (VMware) (2):
>       tools lib traceevent: Do not free tep->cmdlines in add_new_comm() on failure
>       tools lib traceevent: Remove unneeded qsort and uses memmove instead
> 
>  tools/lib/traceevent/event-parse.c                 |  58 ++++-
>  tools/perf/arch/arm/util/cs-etm.c                  |   7 +-
>  tools/perf/arch/arm64/util/arm-spe.c               |   5 +-
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 146 +++++++++--
>  tools/perf/arch/s390/util/auxtrace.c               |   2 +-
>  tools/perf/arch/x86/util/intel-bts.c               |   6 +-
>  tools/perf/arch/x86/util/intel-pt.c                |   7 +-
>  tools/perf/arch/x86/util/tsc.c                     |   2 +-
>  tools/perf/builtin-buildid-cache.c                 |   1 +
>  tools/perf/builtin-record.c                        |   6 +-
>  tools/perf/builtin-report.c                        |   3 +-
>  tools/perf/builtin-script.c                        |   3 +-
>  tools/perf/builtin-stat.c                          |   2 +-
>  tools/perf/builtin-top.c                           |  47 ++--
>  tools/perf/builtin-trace.c                         |   3 +-
>  tools/perf/builtin.h                               |   2 -
>  tools/perf/lib/include/perf/event.h                | 273 ++++++++++++++++++++
>  tools/perf/perf.c                                  |   1 +
>  tools/perf/tests/cpumap.c                          |  12 +-
>  tools/perf/tests/event_update.c                    |  16 +-
>  tools/perf/tests/sdt.c                             |   1 +
>  tools/perf/tests/stat.c                            |   8 +-
>  tools/perf/tests/thread-map.c                      |   2 +-
>  tools/perf/util/arm-spe.c                          |   6 +-
>  tools/perf/util/auxtrace.c                         |  21 +-
>  tools/perf/util/auxtrace.h                         |   8 +-
>  tools/perf/util/bpf-loader.c                       |   1 +
>  tools/perf/util/build-id.c                         |   2 +-
>  tools/perf/util/c++/clang-c.h                      |   2 +-
>  tools/perf/util/c++/clang-test.cpp                 |   4 +-
>  tools/perf/util/cpumap.c                           |   6 +-
>  tools/perf/util/cpumap.h                           |   4 +-
>  tools/perf/util/cs-etm.c                           |   4 +-
>  tools/perf/util/event.c                            |  45 ++--
>  tools/perf/util/event.h                            | 278 +--------------------
>  tools/perf/util/evlist.c                           |  10 +
>  tools/perf/util/evlist.h                           |   1 -
>  tools/perf/util/evsel.c                            |   3 +-
>  tools/perf/util/header.c                           |  57 ++---
>  tools/perf/util/hist.c                             |  39 +--
>  tools/perf/util/hist.h                             |   1 +
>  tools/perf/util/intel-bts.c                        |   6 +-
>  tools/perf/util/intel-pt.c                         |  12 +-
>  tools/perf/util/python.c                           |   4 +-
>  tools/perf/util/s390-cpumsf.c                      |   4 +-
>  tools/perf/util/session.c                          |  29 +--
>  tools/perf/util/session.h                          |   2 +-
>  tools/perf/util/stat.c                             |  12 +-
>  tools/perf/util/symbol.c                           |  15 +-
>  tools/perf/util/thread_map.c                       |   4 +-
>  tools/perf/util/thread_map.h                       |   4 +-
>  tools/perf/util/util-cxx.h                         |  27 --
>  52 files changed, 684 insertions(+), 540 deletions(-)
>  delete mode 100644 tools/perf/util/util-cxx.h

Pulled, thanks a lot Arnaldo!

	Ingo
