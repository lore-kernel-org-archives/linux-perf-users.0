From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Thu, 26 Sep 2019 07:55:05 +0200
Message-ID: <20190926055505.GA80831@gmail.com>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Andreas Krebbel <krebbel@linux.ibm.com>, Kim Phillips <kim.phillips@amd.com>, Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Stephane Eranian <eranian@google.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Richter <tmricht@linux.ibm.com>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 2b32769700f857a8e608a8ee24080833889965b9:
> 
>   Merge tag 'perf-urgent-for-mingo-5.4-20190921' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-09-22 12:45:11 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20190925
> 
> for you to fetch changes up to d6840d87b2d148e19e244ad2b44d28ba07f437a0:
> 
>   perf parser: Remove needless include directives (2019-09-25 16:26:41 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf record:
> 
>   Stephane Eranian:
> 
>   - Fix priv level with branch sampling for paranoid=2, i.e. the kernel checks
>     if perf_event_attr_attr.exclude_hv is set in addition to .exclude_kernel,
>     so reset both to zero.
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Don't warn about not being able to read kernel maps (kallsyms, etc) when
>     kernel samples aren't being collected.
> 
> perf list:
> 
>   Kim Phillips:
> 
>   - Allow plurals for metric, metricgroup., i.e.:
> 
>     $ perf list metrics
> 
>     was showing nothing, which is very confusing, make it work like:
> 
>     $ perf stat metric
> 
> perf stat:
> 
>   Andi Kleen:
> 
>   - Free memory access/leaks detected via valgrind, related to metrics.
> 
> Libraries:
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Move more stuff from tools/perf, this time a first stab at moving perf_mmap
>     methods.
> 
> libtracevent:
> 
>   Steven Rostedt (VMware):
> 
>   - Round up in tep_print_event() time precision.
> 
>   Tzvetomir Stoyanov (VMware):
> 
>   - Man pages for event print and related and plugins APIs.
> 
>   - Move traceevent plugins in its own subdirectory.
> 
> Feature detection:
> 
>   Thomas Richter:
> 
>   - Add detection of java-11-openjdk-devel package, in addition to the older
>     versions supported.
> 
> Architecture specific:
> 
> S/390:
> 
>   Thomas Richter (2):
> 
>   - Include JVMTI support for s390
> 
> Vendor events:
> 
> AMD:
> 
>   Kim Phillips:
> 
>   - Add L3 cache events for Family 17h.
> 
>   - Remove redundant '['.
> 
> PowerPC:
> 
>   Mamatha Inamdar:
> 
>   - Remove P8 HW events which are not supported.
> 
> Cleanups:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove needless headers, add needed ones, move things around to reduce the
>     headers dependency tree, speeding up builds by not doing needless compiles
>     when unrelated stuff gets changed.
> 
>   - Ditch unused code that was dragging headers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (2):
>       perf stat: Fix free memory access / memory leaks in metrics
>       perf evlist: Fix access of freed id arrays
> 
> Arnaldo Carvalho de Melo (12):
>       perf record: Move restricted maps check to after a possible fallback to not collect kernel samples
>       perf evlist: Adopt backwards ring buffer state enum
>       libperf: Add missing 'struct xyarray' forward declaration
>       perf tools: No need to include internal/lib.h from util/util.h
>       libperf: Use sys/types.h to get ssize_t, not unistd.h
>       perf copyfile: Move copyfile routines to separate files
>       perf evsel: Remove need for symbol_conf in evsel_fprintf.c
>       perf evsel: Introduce evsel_fprintf.h
>       perf evlist: Remove unused perf_evlist__fprintf() method
>       perf evsel: Move config terms to a separate header
>       perf tools: Replace needless mmap.h with what is needed, event.h
>       perf parser: Remove needless include directives
> 
> Jiri Olsa (37):
>       tools: Add missing stdio.h include to asm/bug.h header
>       perf tools: Rename 'struct perf_mmap' to 'struct mmap'
>       perf tools: Rename perf_evlist__mmap() to evlist__mmap()
>       perf tools: Rename perf_evlist__munmap() to evlist__munmap()
>       perf tools: Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap()
>       perf tools: Rename perf_evlist__exit() to evlist__exit()
>       perf tools: Rename perf_evlist__purge() to evlist__purge()
>       libperf: Link libapi.a in libperf.so
>       libperf: Add perf_mmap struct
>       libperf: Add 'mask' to struct perf_mmap
>       libperf: Add 'fd' to struct perf_mmap
>       libperf: Add 'cpu' to struct perf_mmap
>       libperf: Add 'refcnt' to struct perf_mmap
>       libperf: Add prev/start/end to struct perf_mmap
>       libperf: Add 'overwrite' to 'struct perf_mmap'
>       libperf: Add 'event_copy' to 'struct perf_mmap'
>       libperf: Add 'flush' to 'struct perf_mmap'
>       libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'
>       libperf: Move 'nr_mmaps' from 'struct evlist' to 'struct perf_evlist'
>       libperf: Move 'mmap_len' from 'struct evlist' to 'struct perf_evlist'
>       libperf: Move 'pollfd' from 'struct evlist' to 'struct perf_evlist'
>       libperf: Move 'sample_id' from 'struct evsel' to 'struct perf_evsel'
>       libperf: Move 'id' from 'struct evsel' to 'struct perf_evsel'
>       libperf: Move 'ids' from 'struct evsel' to 'struct perf_evsel'
>       libperf: Move 'heads' from 'struct evlist' to 'struct perf_evlist'
>       libperf: Add perf_evsel__alloc_id/perf_evsel__free_id functions
>       libperf: Add perf_evlist__first()/last() functions
>       libperf: Add perf_evlist__read_format() function
>       libperf: Add perf_evlist__id_add() function
>       libperf: Add perf_evlist__id_add_fd() function
>       libperf: Move 'page_size' global variable to libperf
>       libperf: Add libperf dependency for tests targets
>       libperf: Merge libperf_set_print() into libperf_init()
>       libperf: Add libperf_init() call to the tests
>       libperf: Add perf_evlist__alloc_pollfd() function
>       libperf: Add perf_evlist__add_pollfd() function
>       libperf: Add perf_evlist__poll() function
> 
> Kim Phillips (4):
>       perf vendor events amd: Add L3 cache events for Family 17h
>       perf vendor events amd: Remove redundant '['
>       perf vendor events: Minor fixes to the README
>       perf list: Allow plurals for metric, metricgroup
> 
> Mamatha Inamdar (1):
>       perf vendor events: Remove P8 HW events which are not supported
> 
> Stephane Eranian (1):
>       perf record: Fix priv level with branch sampling for paranoid=2
> 
> Steven Rostedt (VMware) (1):
>       libtraceevent: Round up in tep_print_event() time precision
> 
> Thomas Richter (2):
>       perf jvmti: Include JVMTI support for s390
>       perf build: Add detection of java-11-openjdk-devel package
> 
> Tzvetomir Stoyanov (2):
>       libtraceevent: Man pages for libtraceevent event print related API
>       libtraceevent: Man pages for tep plugins APIs
> 
> Tzvetomir Stoyanov (VMware) (4):
>       libtraceevent: Man pages fix, rename tep_ref_get() to tep_get_ref()
>       libtraceevent: Man pages fix, changes in event printing APIs
>       libtraceevent: Add tep_get_event() in event-parse.h
>       libtraceevent: Move traceevent plugins in its own subdirectory
> 
>  tools/include/asm/bug.h                            |   1 +
>  tools/lib/traceevent/Build                         |  11 -
>  .../Documentation/libtraceevent-event_print.txt    | 130 +++++++++
>  .../Documentation/libtraceevent-handle.txt         |   8 +-
>  .../Documentation/libtraceevent-plugins.txt        |  99 +++++++
>  .../lib/traceevent/Documentation/libtraceevent.txt |  15 +-
>  tools/lib/traceevent/Makefile                      |  94 ++-----
>  tools/lib/traceevent/event-parse.c                 |   4 +-
>  tools/lib/traceevent/event-parse.h                 |   2 +
>  tools/lib/traceevent/plugins/Build                 |  10 +
>  tools/lib/traceevent/plugins/Makefile              | 222 ++++++++++++++++
>  .../lib/traceevent/{ => plugins}/plugin_cfg80211.c |   0
>  .../lib/traceevent/{ => plugins}/plugin_function.c |   0
>  .../lib/traceevent/{ => plugins}/plugin_hrtimer.c  |   0
>  tools/lib/traceevent/{ => plugins}/plugin_jbd2.c   |   0
>  tools/lib/traceevent/{ => plugins}/plugin_kmem.c   |   0
>  tools/lib/traceevent/{ => plugins}/plugin_kvm.c    |   0
>  .../lib/traceevent/{ => plugins}/plugin_mac80211.c |   0
>  .../traceevent/{ => plugins}/plugin_sched_switch.c |   0
>  tools/lib/traceevent/{ => plugins}/plugin_scsi.c   |   0
>  tools/lib/traceevent/{ => plugins}/plugin_xen.c    |   0
>  tools/perf/Makefile.config                         |   2 +-
>  tools/perf/Makefile.perf                           |   4 +-
>  tools/perf/arch/arm/util/cs-etm.c                  |   7 +-
>  tools/perf/arch/arm64/util/arm-spe.c               |   6 +-
>  tools/perf/arch/s390/Makefile                      |   1 +
>  tools/perf/arch/s390/util/auxtrace.c               |   1 +
>  tools/perf/arch/s390/util/machine.c                |   2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c              |   5 +-
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c       |  11 +-
>  tools/perf/arch/x86/tests/rdpmc.c                  |   2 +-
>  tools/perf/arch/x86/util/intel-bts.c               |   9 +-
>  tools/perf/arch/x86/util/intel-pt.c                |  17 +-
>  tools/perf/arch/x86/util/machine.c                 |   2 +-
>  tools/perf/builtin-evlist.c                        |   1 +
>  tools/perf/builtin-kvm.c                           |  13 +-
>  tools/perf/builtin-list.c                          |   4 +-
>  tools/perf/builtin-record.c                        | 102 +++----
>  tools/perf/builtin-sched.c                         |   3 +-
>  tools/perf/builtin-script.c                        |  11 +-
>  tools/perf/builtin-stat.c                          |   6 +-
>  tools/perf/builtin-top.c                           |  22 +-
>  tools/perf/builtin-trace.c                         |  17 +-
>  tools/perf/lib/Makefile                            |  35 ++-
>  tools/perf/lib/core.c                              |  13 +-
>  tools/perf/lib/evlist.c                            | 124 +++++++++
>  tools/perf/lib/evsel.c                             |  30 +++
>  tools/perf/lib/include/internal/evlist.h           |  33 +++
>  tools/perf/lib/include/internal/evsel.h            |  33 +++
>  tools/perf/lib/include/internal/lib.h              |   4 +-
>  tools/perf/lib/include/internal/mmap.h             |  32 +++
>  tools/perf/lib/include/perf/core.h                 |   2 +-
>  tools/perf/lib/include/perf/evlist.h               |   1 +
>  tools/perf/lib/lib.c                               |   2 +
>  tools/perf/lib/libperf.map                         |   3 +-
>  tools/perf/lib/tests/test-cpumap.c                 |  10 +
>  tools/perf/lib/tests/test-evlist.c                 |  10 +
>  tools/perf/lib/tests/test-evsel.c                  |  10 +
>  tools/perf/lib/tests/test-threadmap.c              |  10 +
>  tools/perf/perf.c                                  |  13 +-
>  tools/perf/pmu-events/README                       |  22 +-
>  .../perf/pmu-events/arch/powerpc/power8/other.json |  24 --
>  .../perf/pmu-events/arch/x86/amdfam17h/cache.json  |  42 +++
>  tools/perf/pmu-events/arch/x86/amdfam17h/core.json |   2 +-
>  tools/perf/pmu-events/jevents.c                    |   1 +
>  tools/perf/tests/backward-ring-buffer.c            |  11 +-
>  tools/perf/tests/bpf.c                             |   9 +-
>  tools/perf/tests/code-reading.c                    |  11 +-
>  tools/perf/tests/event-times.c                     |  14 +-
>  tools/perf/tests/event_update.c                    |   6 +-
>  tools/perf/tests/evsel-roundtrip-name.c            |   2 +-
>  tools/perf/tests/hists_cumulate.c                  |   2 +-
>  tools/perf/tests/hists_link.c                      |   5 +-
>  tools/perf/tests/hists_output.c                    |   2 +-
>  tools/perf/tests/keep-tracking.c                   |  11 +-
>  tools/perf/tests/mmap-basic.c                      |   5 +-
>  tools/perf/tests/mmap-thread-lookup.c              |   2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c        |  11 +-
>  tools/perf/tests/parse-events.c                    | 116 ++++----
>  tools/perf/tests/perf-record.c                     |  13 +-
>  tools/perf/tests/sdt.c                             |   1 +
>  tools/perf/tests/sw-clock.c                        |   5 +-
>  tools/perf/tests/switch-tracking.c                 |  29 +-
>  tools/perf/tests/task-exit.c                       |   9 +-
>  tools/perf/tests/vmlinux-kallsyms.c                |   2 +-
>  tools/perf/ui/browsers/hists.c                     |   6 +-
>  tools/perf/ui/gtk/hists.c                          |   1 +
>  tools/perf/util/Build                              |   2 +
>  tools/perf/util/annotate.c                         |   1 +
>  tools/perf/util/auxtrace.c                         |   8 +-
>  tools/perf/util/auxtrace.h                         |   8 +-
>  tools/perf/util/bpf-loader.c                       |   2 +-
>  tools/perf/util/build-id.c                         |   3 +-
>  tools/perf/util/copyfile.c                         | 144 ++++++++++
>  tools/perf/util/copyfile.h                         |  16 ++
>  tools/perf/util/cs-etm.c                           |   2 +-
>  tools/perf/util/evlist.c                           | 295 ++++++---------------
>  tools/perf/util/evlist.h                           |  81 +++---
>  tools/perf/util/evsel.c                            | 204 ++------------
>  tools/perf/util/evsel.h                            | 121 +--------
>  tools/perf/util/evsel_config.h                     |  50 ++++
>  tools/perf/util/evsel_fprintf.c                    |  15 +-
>  tools/perf/util/evsel_fprintf.h                    |  50 ++++
>  tools/perf/util/genelf.h                           |   3 +
>  tools/perf/util/header.c                           |  29 +-
>  tools/perf/util/intel-bts.c                        |   4 +-
>  tools/perf/util/intel-pt.c                         |  10 +-
>  tools/perf/util/jitdump.c                          |   2 +-
>  tools/perf/util/machine.c                          |   1 +
>  tools/perf/util/mmap.c                             | 185 ++++++-------
>  tools/perf/util/mmap.h                             |  77 ++----
>  tools/perf/util/parse-events.c                     |   8 +-
>  tools/perf/util/parse-events.y                     |   4 +-
>  tools/perf/util/perf_event_attr_fprintf.c          | 148 +++++++++++
>  tools/perf/util/python-ext-sources                 |   1 +
>  tools/perf/util/python.c                           |  24 +-
>  tools/perf/util/record.c                           |   6 +-
>  tools/perf/util/session.c                          |   5 +-
>  tools/perf/util/sort.c                             |   2 +-
>  tools/perf/util/srccode.c                          |   2 +-
>  tools/perf/util/stat-shadow.c                      |   4 +-
>  tools/perf/util/stat.c                             |   2 +-
>  tools/perf/util/symbol-elf.c                       |   2 +-
>  tools/perf/util/synthetic-events.c                 |  20 +-
>  tools/perf/util/top.c                              |   2 +-
>  tools/perf/util/trace-event-info.c                 |   2 +-
>  tools/perf/util/util.c                             | 136 ----------
>  tools/perf/util/util.h                             |   8 -
>  128 files changed, 1941 insertions(+), 1321 deletions(-)
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_print.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
>  create mode 100644 tools/lib/traceevent/plugins/Build
>  create mode 100644 tools/lib/traceevent/plugins/Makefile
>  rename tools/lib/traceevent/{ => plugins}/plugin_cfg80211.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_function.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_hrtimer.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_jbd2.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_kmem.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_kvm.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_mac80211.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_sched_switch.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_scsi.c (100%)
>  rename tools/lib/traceevent/{ => plugins}/plugin_xen.c (100%)
>  create mode 100644 tools/perf/lib/include/internal/mmap.h
>  create mode 100644 tools/perf/util/copyfile.c
>  create mode 100644 tools/perf/util/copyfile.h
>  create mode 100644 tools/perf/util/evsel_config.h
>  create mode 100644 tools/perf/util/evsel_fprintf.h
>  create mode 100644 tools/perf/util/perf_event_attr_fprintf.c

Pulled, thanks a lot Arnaldo!

	Ingo
