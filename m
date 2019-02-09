From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/53] perf/core improvements and fixes
Date: Sat, 9 Feb 2019 13:17:26 +0100
Message-ID: <20190209121726.GB54650@gmail.com>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Changbin Du <changbin.du@gmail.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, William Cohen <wcohen@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit ca3bb3d027f69ac3ab1dafb32bde2f5a3a44439c:
> 
>   perf/ring_buffer: Convert ring_buffer.aux_refcount to refcount_t (2019-02-04 08:46:17 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190206
> 
> for you to fetch changes up to 16bd4321c2425d37031a902cdbf183e2cd099946:
> 
>   perf auxtrace: Add timestamp to auxtrace errors (2019-02-06 11:20:32 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> Hardware tracing:
> 
>   Adrian Hunter:
> 
>   - Handle calls optimized into jumps to a different symbol
>     in the thread stack routines used to process hardware traces (Adrian Hunter)
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Fix overlap calculation for padding.
> 
>   - Fix CYC timestamp calculation after OVF.
> 
>   - Packet splitting can only happen in 32-bit.
> 
>   - Add timestamp to auxtrace errors.
> 
> ARM CoreSight:
> 
>   Leo Yan:
> 
>   - Add last instruction information in packet
> 
>   - Set sample flags for instruction range, exception and
>     return packets and for a trace discontinuity.
> 
>   - Add exception number in exception packet
> 
>   - Change tuple from traceID-CPU# to traceID-metadata
> 
>   - Add traceID in packet
> 
>   Mathieu Poirier:
> 
>   - Add "sinks" group to PMU directory
> 
>   - Use event attributes to send sink information to kernel
> 
>   - Remove set_drv_config() API, no longer used.
> 
> perf annotate:
> 
>   Jiri Olsa:
> 
>   - Delay symbol annotation to the resort phase, speeding up 'perf report'
>     startup.
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Allow binding userspace buffers to NUMA nodes.
> 
> Symbols:
> 
>   Adrian Hunter:
> 
>   - Fix calculating of symbol sizes when splitting kallsyms into
>     maps for kcore processing.
> 
> Vendor events:
> 
>   William Cohen:
> 
>   - Intel: Fix Load_Miss_Real_Latency on CLX
> 
> Misc:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Streamline headers, removing includes when all that is needed are
>     just forward declarations, fixup the fallout for cases where headers
>     should have been explicitely included but were instead obtained
>     indirectly, by sheer luck.
> 
>   - Add fallback versions for CPU_{OR,EQUAL}(), so that code using it
>     continue to build on older systems where those were not yet introduced
>     or in systems using some other libc than the GNU one where those
>     helpers aren't present.
> 
> Documentation:
> 
>   Changbin Du:
> 
>   - Add documentation for BPF event selection.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (9):
>       perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
>       perf thread-stack: Tidy thread_stack__push_cp() usage
>       perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
>       perf thread-stack: Represent jmps to the start of a different symbol
>       perf auxtrace: Define auxtrace record alignment
>       perf intel-pt: Fix overlap calculation for padding
>       perf intel-pt: Fix CYC timestamp calculation after OVF
>       perf intel-pt: Packet splitting can happen only on 32-bit
>       perf auxtrace: Add timestamp to auxtrace errors
> 
> Alexey Budankov (3):
>       perf record: Allocate affinity masks
>       perf record: Bind the AIO user space buffers to nodes
>       perf record: Apply affinity masks when reading mmap buffers
> 
> Arnaldo Carvalho de Melo (21):
>       perf powerpc: Add missing headers to skip-callchain-idx.c
>       perf arm pmu: Add missing linux/string.h header
>       perf srccode: Move struct definition from map.h to srccode.h
>       perf callchain: Uninline callchain_cursor_reset() to remove map.h dependency
>       perf symbols: Introduce map_symbol.h
>       pref tools: Add missing map.h includes
>       perf map: Move structs and prototypes for map groups to a separate header
>       perf tests: Add missing headers so far obtained indirectly
>       perf hist: Remove symbol.h from hist.h, just fwd decls are needed
>       perf tools: Add missing include for symbols.h
>       perf evsel: No need to include symbol.h in evsel.h, symbol_conf.h is enough
>       perf thread: Don't include symbol.h, symbol_conf.h is enough
>       perf tools: Add missing include <callchain.h> in various places
>       perf hist: Remove the needless callchain.h include from hist.h
>       perf tests pmu: Add missing headers
>       perf pmu: Remove needless evsel.h include, only needs one fwd decl
>       perf kvm stat: Replace kvm-stat.h includes with forward declarations
>       perf powerpc kvm-stat: Add missing evlist.h header
>       perf bpf-loader: Remove unecessary includes from bpf-loader.h
>       perf tools: Add fallback versions for CPU_{OR,EQUAL}()
>       perf clang: Do not use 'return std::move(something)'
> 
> Changbin Du (1):
>       perf tools: Add documentation for BPF event selection
> 
> Jiri Olsa (3):
>       perf hists: Add argument to hists__resort_cb_t callback
>       perf evsel: Add output_resort_cb method
>       perf report: Move symbol annotation to the resort phase
> 
> Leo Yan (8):
>       perf cs-etm: Add last instruction information in packet
>       perf cs-etm: Set sample flags for instruction range packet
>       perf cs-etm: Set sample flags for trace discontinuity
>       perf cs-etm: Add exception number in exception packet
>       perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
>       perf cs-etm: Add traceID in packet
>       perf cs-etm: Set sample flags for exception packet
>       perf cs-etm: Set sample flags for exception return packet
> 
> Mathieu Poirier (7):
>       perf/aux: Make perf_event accessible to setup_aux()
>       coresight: perf: Add "sinks" group to PMU directory
>       coresight: Use event attributes for sink selection
>       perf pmu: Move EVENT_SOURCE_DEVICE_PATH to PMU header file
>       perf arm cs-etm: Use event attributes to send sink information to kernel
>       perf coresight: Remove set_drv_config() API
>       perf pmu: Remove set_drv_config API
> 
> William Cohen (1):
>       perf vendor events intel: Fix Load_Miss_Real_Latency on CLX
> 
>  arch/s390/kernel/perf_cpum_sf.c                    |   6 +-
>  arch/x86/events/intel/bts.c                        |   4 +-
>  arch/x86/events/intel/pt.c                         |   5 +-
>  drivers/hwtracing/coresight/coresight-etm-perf.c   | 112 +++++-
>  drivers/hwtracing/coresight/coresight-etm-perf.h   |   6 +-
>  drivers/hwtracing/coresight/coresight-priv.h       |   1 +
>  drivers/hwtracing/coresight/coresight.c            |  60 ++++
>  drivers/perf/arm_spe_pmu.c                         |   6 +-
>  include/linux/coresight.h                          |   7 +-
>  include/linux/perf_event.h                         |   2 +-
>  kernel/events/ring_buffer.c                        |   2 +-
>  tools/perf/Documentation/perf-config.txt           |  31 ++
>  tools/perf/Documentation/perf-record.txt           |  14 +
>  tools/perf/arch/arm/tests/dwarf-unwind.c           |   1 +
>  tools/perf/arch/arm/util/cs-etm.c                  |  98 +++--
>  tools/perf/arch/arm/util/cs-etm.h                  |   3 -
>  tools/perf/arch/arm/util/pmu.c                     |   3 +-
>  tools/perf/arch/arm64/tests/dwarf-unwind.c         |   1 +
>  tools/perf/arch/powerpc/tests/dwarf-unwind.c       |   1 +
>  tools/perf/arch/powerpc/util/kvm-stat.c            |   2 +
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   3 +
>  tools/perf/arch/s390/util/kvm-stat.c               |   1 +
>  tools/perf/arch/x86/tests/dwarf-unwind.c           |   1 +
>  tools/perf/arch/x86/util/kvm-stat.c                |   1 +
>  tools/perf/builtin-annotate.c                      |   1 +
>  tools/perf/builtin-c2c.c                           |   9 +-
>  tools/perf/builtin-inject.c                        |   2 +
>  tools/perf/builtin-kallsyms.c                      |   1 +
>  tools/perf/builtin-kmem.c                          |   1 +
>  tools/perf/builtin-mem.c                           |   1 +
>  tools/perf/builtin-record.c                        |  38 +-
>  tools/perf/builtin-report.c                        |  22 +-
>  tools/perf/builtin-script.c                        |   1 +
>  tools/perf/builtin-stat.c                          |   9 -
>  tools/perf/builtin-top.c                           |  14 +-
>  tools/perf/builtin-trace.c                         |   2 +
>  tools/perf/perf.h                                  |   8 +
>  .../arch/x86/cascadelakex/clx-metrics.json         |   2 +-
>  tools/perf/scripts/python/export-to-postgresql.py  |   2 +-
>  tools/perf/scripts/python/export-to-sqlite.py      |   2 +-
>  tools/perf/tests/code-reading.c                    |   2 +
>  tools/perf/tests/dwarf-unwind.c                    |   1 +
>  tools/perf/tests/hists_common.c                    |   1 +
>  tools/perf/tests/hists_cumulate.c                  |   1 +
>  tools/perf/tests/hists_filter.c                    |   1 +
>  tools/perf/tests/hists_output.c                    |   1 +
>  tools/perf/tests/mmap-thread-lookup.c              |   1 +
>  tools/perf/tests/pmu.c                             |   2 +
>  tools/perf/tests/sample-parsing.c                  |   2 +
>  tools/perf/tests/sdt.c                             |   1 +
>  tools/perf/ui/browsers/annotate.c                  |   1 +
>  tools/perf/ui/browsers/hists.c                     |   3 +
>  tools/perf/ui/gtk/annotate.c                       |   2 +
>  tools/perf/ui/gtk/hists.c                          |   1 +
>  tools/perf/ui/hist.c                               |   1 +
>  tools/perf/ui/stdio/hist.c                         |   4 +
>  tools/perf/util/Build                              |   1 -
>  tools/perf/util/annotate.c                         |   1 +
>  tools/perf/util/auxtrace.c                         |  27 +-
>  tools/perf/util/auxtrace.h                         |   5 +-
>  tools/perf/util/bpf-loader.c                       |   1 +
>  tools/perf/util/bpf-loader.h                       |   7 +-
>  tools/perf/util/build-id.c                         |   1 +
>  tools/perf/util/c++/clang.cpp                      |   2 +-
>  tools/perf/util/callchain.c                        |  17 +
>  tools/perf/util/callchain.h                        |  20 +-
>  tools/perf/util/config.c                           |   1 +
>  tools/perf/util/cpu-set-sched.h                    |  50 +++
>  tools/perf/util/cpumap.c                           |  10 +
>  tools/perf/util/cpumap.h                           |   1 +
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  41 ++-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   6 +
>  tools/perf/util/cs-etm.c                           | 394 ++++++++++++++++++++-
>  tools/perf/util/cs-etm.h                           |  53 ++-
>  tools/perf/util/db-export.c                        |   1 +
>  tools/perf/util/drv_configs.c                      |  78 ----
>  tools/perf/util/drv_configs.h                      |  26 --
>  tools/perf/util/dso.c                              |   1 +
>  tools/perf/util/event.c                            |   2 +
>  tools/perf/util/event.h                            |   3 +-
>  tools/perf/util/evlist.c                           |   6 +-
>  tools/perf/util/evlist.h                           |   2 +-
>  tools/perf/util/evsel.h                            |   2 +-
>  tools/perf/util/hist.c                             |  21 +-
>  tools/perf/util/hist.h                             |   9 +-
>  tools/perf/util/intel-bts.c                        |   6 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  39 +-
>  tools/perf/util/intel-pt.c                         |  23 +-
>  tools/perf/util/kvm-stat.h                         |   7 +-
>  tools/perf/util/machine.c                          |   1 +
>  tools/perf/util/machine.h                          |   2 +-
>  tools/perf/util/map.c                              |   6 +
>  tools/perf/util/map.h                              | 100 +-----
>  tools/perf/util/map_groups.h                       |  91 +++++
>  tools/perf/util/map_symbol.h                       |  22 ++
>  tools/perf/util/mmap.c                             | 105 +++++-
>  tools/perf/util/mmap.h                             |   3 +-
>  tools/perf/util/pmu.c                              |   2 -
>  tools/perf/util/pmu.h                              |   5 +-
>  tools/perf/util/probe-event.c                      |   2 +
>  tools/perf/util/s390-cpumsf.c                      |   7 +-
>  .../perf/util/scripting-engines/trace-event-perl.c |   2 +
>  .../util/scripting-engines/trace-event-python.c    |   2 +
>  tools/perf/util/session.c                          |   5 +
>  tools/perf/util/setup.py                           |   5 +
>  tools/perf/util/sort.c                             |   8 +-
>  tools/perf/util/sort.h                             |   3 +-
>  tools/perf/util/srccode.h                          |  13 +
>  tools/perf/util/symbol-elf.c                       |   2 +
>  tools/perf/util/symbol.c                           |   3 +
>  tools/perf/util/symbol.h                           |  14 +-
>  tools/perf/util/thread-stack.c                     |  78 ++--
>  tools/perf/util/thread-stack.h                     |   3 +
>  tools/perf/util/thread.c                           |   1 +
>  tools/perf/util/thread.h                           |   7 +-
>  tools/perf/util/unwind-libdw.c                     |   2 +
>  tools/perf/util/unwind-libunwind-local.c           |   1 +
>  tools/perf/util/unwind-libunwind.c                 |   1 +
>  tools/perf/util/vdso.c                             |   1 +
>  119 files changed, 1399 insertions(+), 473 deletions(-)
>  create mode 100644 tools/perf/util/cpu-set-sched.h
>  delete mode 100644 tools/perf/util/drv_configs.c
>  delete mode 100644 tools/perf/util/drv_configs.h
>  create mode 100644 tools/perf/util/map_groups.h
>  create mode 100644 tools/perf/util/map_symbol.h

Pulled, thanks a lot Arnaldo!

	Ingo
