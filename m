From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Fri, 20 Sep 2019 18:15:10 +0200
Message-ID: <20190920161510.GA6038@gmail.com>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Colin King <colin.king@canonical.com>, James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit e336b4027775cb458dc713745e526fa1a1996b2a:
> 
>   kprobes: Prohibit probing on BUG() and WARN() address (2019-09-05 10:15:16 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190920-2
> 
> for you to fetch changes up to 2bff2b828502b5e5d5ea5a52643d3542053df03f:
> 
>   perf kvm stat: Set 'trace_cycles' as default event for 'perf kvm record' in powerpc (2019-09-20 10:28:26 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf stat:
> 
>   Srikar Dronamraju:
> 
>   - Fix a segmentation fault when using repeat forever.
> 
>   - Reset previous counts on repeat with interval.
> 
> aarch64:
> 
>   James Clark:
> 
>   - Add PMU event JSON files for Cortex-A76 and Neoverse N1.
> 
> PowerPC:
> 
>   Anju T Sudhakar:
> 
>   - Make 'trace_cycles' the default event for 'perf kvm record' in PowerPC.
> 
> S/390:
> 
>   - Link libjvmti to tools/lib/string.o to have a weak strlcpy()
>     implementation, providing previously unresolved symbol on s/390.
> 
> perf test:
> 
>   Jiri Olsa:
> 
>   - Add libperf automated tests to 'make -C tools/perf build-test'.
> 
>   Colin Ian King:
> 
>   - Fix spelling mistake.
> 
> Tree wide:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Some more header file sanitization.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Add dependency on libperf for python.so binding.
> 
> libtraceevent:
> 
>   Sakari Ailus:
> 
>   - Convert remaining %p[fF] users to %p[sS].
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Anju T Sudhakar (3):
>       perf kvm: Move kvm-stat header file from conditional inclusion to common include section
>       perf kvm: Add arch neutral function to choose event for perf kvm record
>       perf kvm stat: Set 'trace_cycles' as default event for 'perf kvm record' in powerpc
> 
> Arnaldo Carvalho de Melo (19):
>       perf jvmti: Link against tools/lib/string.o to have weak strlcpy()
>       perf tools: Remove needless builtin.h include directives
>       perf debug: No need to include ui/util.h
>       perf tools: Remove debug.h from places where it is not needed
>       perf tools: Remove util.h from where it is not needed
>       perf probe: Add missing build-id.h header.
>       perf symbols: Add missing dso.h header
>       perf env: Remove needless cpumap.h header
>       perf event: Move perf_event__synthesize* to event.h
>       perf stat: Move perf_stat_synthesize_config() to event.h
>       perf callchain: Remove needless event.h include
>       perf python: Remove debug.h
>       perf hist: Add missing 'struct branch_stack' forward declaration
>       perf annotate: Add missing machine.h include directive
>       perf sched: Add missing event.h include directive
>       perf auxtrace: Add missing 'struct perf_sample' forward declaration
>       perf tools: Move event synthesizing routines to separate header
>       perf memswap: Adopt 'struct u64_swap' from evsel.h
>       perf tools: Move event synthesizing routines to separate .c file
> 
> Colin Ian King (1):
>       perf test: Fix spelling mistake "allos" -> "allocate"
> 
> James Clark (1):
>       perf tools: Add PMU event JSON files for ARM Cortex-A76 and, Neoverse N1.
> 
> Jiri Olsa (4):
>       perf python: Add missing python/perf.so dependency for libperf
>       perf tests: Add libperf automated test for 'make -C tools/perf build-test'
>       libperf: Add missing event.h file to install rule
>       libperf: Adopt perf_cpu_map__max() function
> 
> Sakari Ailus (1):
>       tools lib traceevent: Convert remaining %p[fF] users to %p[sS]
> 
> Srikar Dronamraju (2):
>       perf stat: Reset previous counts on repeat with interval
>       perf stat: Fix a segmentation fault when using repeat forever
> 
>  .../Documentation/libtraceevent-func_apis.txt      |   10 +-
>  tools/lib/traceevent/event-parse.c                 |   18 +-
>  tools/perf/Makefile.perf                           |    2 +-
>  tools/perf/arch/arm/util/cs-etm.c                  |    2 +-
>  tools/perf/arch/arm64/util/arm-spe.c               |    2 +-
>  tools/perf/arch/arm64/util/dwarf-regs.c            |    1 -
>  tools/perf/arch/arm64/util/header.c                |    4 +-
>  tools/perf/arch/arm64/util/unwind-libunwind.c      |    2 +-
>  tools/perf/arch/powerpc/util/dwarf-regs.c          |    1 -
>  tools/perf/arch/powerpc/util/header.c              |    1 -
>  tools/perf/arch/powerpc/util/kvm-stat.c            |   45 +
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c  |    1 +
>  tools/perf/arch/powerpc/util/sym-handling.c        |    1 -
>  tools/perf/arch/s390/util/machine.c                |    2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c              |    1 -
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c       |    1 -
>  tools/perf/arch/x86/tests/rdpmc.c                  |    2 +-
>  tools/perf/arch/x86/util/archinsn.c                |    1 +
>  tools/perf/arch/x86/util/event.c                   |    2 +
>  tools/perf/arch/x86/util/intel-bts.c               |    2 +-
>  tools/perf/arch/x86/util/intel-pt.c                |    2 +-
>  tools/perf/arch/x86/util/machine.c                 |    3 +-
>  tools/perf/arch/x86/util/tsc.c                     |    2 +
>  tools/perf/bench/epoll-ctl.c                       |    2 +-
>  tools/perf/bench/epoll-wait.c                      |    2 +-
>  tools/perf/bench/futex-hash.c                      |    2 +-
>  tools/perf/bench/futex-lock-pi.c                   |    2 +-
>  tools/perf/bench/futex-requeue.c                   |    2 +-
>  tools/perf/bench/futex-wake-parallel.c             |    3 +-
>  tools/perf/bench/futex-wake.c                      |    2 +-
>  tools/perf/bench/numa.c                            |    1 -
>  tools/perf/bench/sched-messaging.c                 |    2 -
>  tools/perf/bench/sched-pipe.c                      |    2 -
>  tools/perf/builtin-annotate.c                      |    1 +
>  tools/perf/builtin-c2c.c                           |    1 +
>  tools/perf/builtin-config.c                        |    1 -
>  tools/perf/builtin-evlist.c                        |    2 -
>  tools/perf/builtin-inject.c                        |    1 +
>  tools/perf/builtin-kvm.c                           |   15 +-
>  tools/perf/builtin-record.c                        |   10 +-
>  tools/perf/builtin-report.c                        |    2 +-
>  tools/perf/builtin-sched.c                         |    3 +
>  tools/perf/builtin-stat.c                          |   24 +-
>  tools/perf/builtin-top.c                           |    1 +
>  tools/perf/builtin-trace.c                         |    1 +
>  tools/perf/jvmti/Build                             |    9 +
>  tools/perf/lib/Makefile                            |    1 +
>  tools/perf/lib/cpumap.c                            |   12 +
>  tools/perf/lib/include/perf/cpumap.h               |    1 +
>  tools/perf/lib/libperf.map                         |    1 +
>  tools/perf/perf.c                                  |    2 +-
>  .../arch/arm64/arm/cortex-a76-n1/branch.json       |   14 +
>  .../arch/arm64/arm/cortex-a76-n1/bus.json          |   24 +
>  .../arch/arm64/arm/cortex-a76-n1/cache.json        |  207 +++
>  .../arch/arm64/arm/cortex-a76-n1/exception.json    |   52 +
>  .../arch/arm64/arm/cortex-a76-n1/instruction.json  |  108 ++
>  .../arch/arm64/arm/cortex-a76-n1/memory.json       |   23 +
>  .../arch/arm64/arm/cortex-a76-n1/other.json        |    7 +
>  .../arch/arm64/arm/cortex-a76-n1/pipeline.json     |   14 +
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |    2 +
>  tools/perf/tests/bitmap.c                          |    2 +-
>  tools/perf/tests/clang.c                           |    2 -
>  tools/perf/tests/code-reading.c                    |    2 +-
>  tools/perf/tests/cpumap.c                          |    1 +
>  tools/perf/tests/dso-data.c                        |    1 -
>  tools/perf/tests/dwarf-unwind.c                    |    1 +
>  tools/perf/tests/event-times.c                     |    1 -
>  tools/perf/tests/event_update.c                    |    4 +-
>  tools/perf/tests/hists_common.c                    |    2 +
>  tools/perf/tests/keep-tracking.c                   |    3 +-
>  tools/perf/tests/llvm.c                            |    1 -
>  tools/perf/tests/make                              |    6 +-
>  tools/perf/tests/mem2node.c                        |    2 +-
>  tools/perf/tests/mmap-basic.c                      |    3 +-
>  tools/perf/tests/mmap-thread-lookup.c              |    4 +-
>  tools/perf/tests/openat-syscall-all-cpus.c         |    5 +-
>  tools/perf/tests/parse-events.c                    |    1 -
>  tools/perf/tests/parse-no-sample-id-all.c          |    2 -
>  tools/perf/tests/perf-hooks.c                      |    1 -
>  tools/perf/tests/pmu.c                             |    1 -
>  tools/perf/tests/sample-parsing.c                  |    2 +-
>  tools/perf/tests/stat.c                            |    1 +
>  tools/perf/tests/switch-tracking.c                 |    1 -
>  tools/perf/tests/task-exit.c                       |    2 +-
>  tools/perf/tests/thread-map.c                      |    1 +
>  tools/perf/tests/topology.c                        |    2 +-
>  tools/perf/tests/vmlinux-kallsyms.c                |    2 +-
>  tools/perf/ui/browser.c                            |    1 -
>  tools/perf/ui/browsers/annotate.c                  |    1 -
>  tools/perf/ui/browsers/header.c                    |    1 -
>  tools/perf/ui/browsers/map.c                       |    1 -
>  tools/perf/ui/browsers/res_sample.c                |    2 +-
>  tools/perf/ui/browsers/scripts.c                   |    3 +-
>  tools/perf/ui/gtk/helpline.c                       |    1 -
>  tools/perf/ui/gtk/progress.c                       |    1 -
>  tools/perf/ui/gtk/setup.c                          |    3 +-
>  tools/perf/ui/gtk/util.c                           |    1 -
>  tools/perf/ui/helpline.c                           |    2 -
>  tools/perf/ui/hist.c                               |    1 -
>  tools/perf/ui/setup.c                              |    2 +-
>  tools/perf/ui/stdio/hist.c                         |    1 +
>  tools/perf/ui/tui/helpline.c                       |    1 -
>  tools/perf/ui/tui/setup.c                          |    2 +-
>  tools/perf/ui/tui/util.c                           |    1 -
>  tools/perf/util/Build                              |    1 +
>  tools/perf/util/annotate.c                         |    2 +-
>  tools/perf/util/arm-spe.c                          |    1 -
>  tools/perf/util/auxtrace.c                         |    6 +-
>  tools/perf/util/auxtrace.h                         |   18 +-
>  tools/perf/util/bpf-event.c                        |    1 +
>  tools/perf/util/bpf-event.h                        |   15 +-
>  tools/perf/util/branch.c                           |    2 -
>  tools/perf/util/branch.h                           |    9 +-
>  tools/perf/util/build-id.c                         |    2 +-
>  tools/perf/util/callchain.c                        |    1 +
>  tools/perf/util/callchain.h                        |    5 +-
>  tools/perf/util/cloexec.c                          |    2 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |    1 -
>  tools/perf/util/cs-etm.c                           |    2 +-
>  tools/perf/util/data.c                             |    3 +-
>  tools/perf/util/debug.c                            |    1 -
>  tools/perf/util/debug.h                            |    2 +-
>  tools/perf/util/demangle-java.c                    |    1 -
>  tools/perf/util/demangle-rust.c                    |    1 -
>  tools/perf/util/dwarf-regs.c                       |    1 -
>  tools/perf/util/env.h                              |    3 +-
>  tools/perf/util/event.c                            | 1109 +-----------
>  tools/perf/util/event.h                            |   77 +-
>  tools/perf/util/evlist.c                           |    2 +-
>  tools/perf/util/evsel.c                            |  280 +--
>  tools/perf/util/evsel.h                            |    5 -
>  tools/perf/util/evsel_fprintf.c                    |    1 +
>  tools/perf/util/header.c                           |  395 +---
>  tools/perf/util/header.h                           |   60 +-
>  tools/perf/util/hist.h                             |    1 +
>  tools/perf/util/intel-bts.c                        |    2 +-
>  tools/perf/util/intel-pt.c                         |    1 +
>  tools/perf/util/jitdump.c                          |    2 -
>  tools/perf/util/kvm-stat.h                         |    4 +
>  tools/perf/util/libunwind/arm64.c                  |    1 -
>  tools/perf/util/libunwind/x86_32.c                 |    1 -
>  tools/perf/util/llvm-utils.c                       |    1 +
>  tools/perf/util/lzma.c                             |    2 +-
>  tools/perf/util/machine.c                          |   15 -
>  tools/perf/util/machine.h                          |   15 -
>  tools/perf/util/memswap.h                          |    7 +
>  tools/perf/util/namespaces.c                       |   18 +
>  tools/perf/util/namespaces.h                       |    2 +
>  tools/perf/util/parse-events.c                     |    1 -
>  tools/perf/util/perf-hooks.c                       |    1 -
>  tools/perf/util/pmu.c                              |    1 -
>  tools/perf/util/probe-file.c                       |    1 +
>  tools/perf/util/python.c                           |    4 +-
>  tools/perf/util/record.c                           |    2 -
>  tools/perf/util/rwsem.c                            |    1 +
>  tools/perf/util/s390-cpumsf.c                      |    1 -
>  tools/perf/util/s390-sample-raw.c                  |    1 -
>  .../util/scripting-engines/trace-event-python.c    |    2 -
>  tools/perf/util/session.c                          |   72 +-
>  tools/perf/util/session.h                          |    5 -
>  tools/perf/util/srccode.c                          |    2 +-
>  tools/perf/util/stat.c                             |   60 +-
>  tools/perf/util/stat.h                             |    9 +-
>  tools/perf/util/svghelper.c                        |    2 +-
>  tools/perf/util/symbol-elf.c                       |    3 +
>  tools/perf/util/symbol-minimal.c                   |    3 +-
>  tools/perf/util/symbol.c                           |    2 +-
>  tools/perf/util/synthetic-events.c                 | 1884 ++++++++++++++++++++
>  tools/perf/util/synthetic-events.h                 |  103 ++
>  tools/perf/util/target.c                           |    2 -
>  tools/perf/util/top.c                              |    1 -
>  tools/perf/util/trace-event-info.c                 |    2 +-
>  tools/perf/util/trace-event-read.c                 |    1 -
>  tools/perf/util/trace-event.c                      |    1 -
>  tools/perf/util/tsc.h                              |   14 +-
>  tools/perf/util/unwind-libdw.c                     |    1 -
>  tools/perf/util/unwind-libunwind-local.c           |    1 -
>  tools/perf/util/usage.c                            |    1 -
>  tools/perf/util/vdso.c                             |    2 +-
>  tools/perf/util/zlib.c                             |    4 +-
>  180 files changed, 2763 insertions(+), 2256 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
>  create mode 100644 tools/perf/util/synthetic-events.c
>  create mode 100644 tools/perf/util/synthetic-events.h

Pulled, thanks a lot Arnaldo!

	Ingo
