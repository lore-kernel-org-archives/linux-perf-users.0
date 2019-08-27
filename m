From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Tue, 27 Aug 2019 10:24:02 +0200
Message-ID: <20190827082402.GA83092@gmail.com>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Benjamin Peterson <benjamin@python.org>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, James Clark <james.clark@arm.com>, Souptick Joarder <jrdr.linux@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 39152ee51b77851689f9b23fde6f610d13566c39:
> 
>   perf/x86/intel/pt: Get rid of reverse lookup table for ToPA (2019-08-26 12:00:16 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190826
> 
> for you to fetch changes up to 74a1e863eb73dcc9f069b671dfb40650f3832116:
> 
>   perf evsel: Rename perf_missing_features::bpf_event to ::bpf (2019-08-26 19:39:11 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf report:
> 
>   Andi Kleen:
> 
>   - Make --ns time sort key output column wide enough for nanoseconds.
> 
> perf script:
> 
>   Gustavo A. R. Silva:
> 
>   - Fix memory leaks in list_scripts()
> 
> perf tests:
> 
>   James Clark:
> 
>   - Fixes hang in zstd compression test by changing the source of random data.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - augmented_raw_syscalls.c BPF helper improvements.
> 
>   Benjamin Peterson:
> 
>   - Fix off-by-one error in ioctl cmd->string table.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Move most PERF_RECORD_ structs to perf/event.h.
> 
> headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Move cacheline related routines to separate source files.
> 
>   - Move record_opts and other record declarations to separate files.
> 
>   - Explicitly add some more needed headers here and there.
> 
>   Souptick Joarder:
> 
>   - Remove some duplicate include directives.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (2):
>       perf report: Use timestamp__scnprintf_nsec() for time sort key
>       perf report: Fix --ns time sort key output
> 
> Arnaldo Carvalho de Melo (15):
>       perf cpumap: No need to include perf.h, ditch it
>       perf stat: Remove needless headers from stat.h
>       perf record: Move record_opts and other record decls out of perf.h
>       perf cacheline: Move cacheline related routines to separate files
>       perf srcline: Add missing srcline.h header to files needing its defs
>       perf sort: Remove needless headers from sort.h, provide fwd struct decls
>       perf augmented_raw_syscalls: Rename augmented_filename to augmented_arg
>       perf augmented_raw_syscalls: Postpone tmp map lookup to after pid_filter
>       perf augmented_raw_syscalls: Introduce helper to get the scratch space
>       perf augmented_raw_syscalls: Reduce perf_event_output() boilerplate
>       libperf: Rename the PERF_RECORD_ structs to have a "perf" suffix
>       perf tools: Rename perf_event::ksymbol_event to perf_event::ksymbol
>       perf tools: Rename perf_event::bpf_event to perf_event::bpf
>       perf tool: Rename perf_tool::bpf_event to bpf
>       perf evsel: Rename perf_missing_features::bpf_event to ::bpf
> 
> Benjamin Peterson (1):
>       perf trace beauty ioctl: Fix off-by-one error in cmd->string table
> 
> Gustavo A. R. Silva (1):
>       perf script: Fix memory leaks in list_scripts()
> 
> James Clark (1):
>       perf tests: Fixes hang in zstd compression test by changing the source of random data
> 
> Jiri Olsa (12):
>       libperf: Add PERF_RECORD_MMAP 'struct mmap_event' to perf/event.h
>       libperf: Add PERF_RECORD_MMAP2 'struct mmap2_event' to perf/event.h
>       libperf: Add PERF_RECORD_COMM 'struct comm_event' to perf/event.h
>       libperf: Add PERF_RECORD_NAMESPACES 'struct namespaces_event' to perf/event.h
>       libperf: Add PERF_RECORD_FORK 'struct fork_event' to perf/event.h
>       libperf: Add PERF_RECORD_LOST 'struct lost_event' to perf/event.h
>       libperf: Add PERF_RECORD_LOST_SAMPLES 'struct lost_samples_event' to perf/event.h
>       libperf: Add PERF_RECORD_READ 'struct read_event' to perf/event.h
>       libperf: Add PERF_RECORD_THROTTLE 'struct throttle_event' to perf/event.h
>       libperf: Add PERF_RECORD_KSYMBOL 'struct ksymbol_event' to perf/event.h
>       libperf: Add PERF_RECORD_BPF_EVENT 'struct bpf_event' to perf/event.h
>       libperf: Add PERF_RECORD_SAMPLE 'struct sample_event' to perf/event.h
> 
> Souptick Joarder (1):
>       perf tools: Remove duplicate headers
> 
>  tools/perf/arch/arm/util/cs-etm.c                 |   2 +-
>  tools/perf/arch/arm64/util/arm-spe.c              |   1 +
>  tools/perf/arch/s390/util/auxtrace.c              |   1 +
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c      |   2 +
>  tools/perf/arch/x86/util/intel-bts.c              |   1 +
>  tools/perf/arch/x86/util/intel-pt.c               |   3 +-
>  tools/perf/builtin-c2c.c                          |   1 +
>  tools/perf/builtin-diff.c                         |   2 +
>  tools/perf/builtin-record.c                       |   4 +-
>  tools/perf/builtin-report.c                       |   1 +
>  tools/perf/builtin-sched.c                        |   2 +-
>  tools/perf/builtin-script.c                       |   7 +-
>  tools/perf/builtin-stat.c                         |   2 +-
>  tools/perf/builtin-trace.c                        |   1 +
>  tools/perf/examples/bpf/augmented_raw_syscalls.c  | 100 +++++++--------
>  tools/perf/lib/include/perf/event.h               | 112 ++++++++++++++++
>  tools/perf/perf.h                                 |  62 ---------
>  tools/perf/tests/backward-ring-buffer.c           |   2 +-
>  tools/perf/tests/bpf.c                            |   1 +
>  tools/perf/tests/code-reading.c                   |   1 +
>  tools/perf/tests/keep-tracking.c                  |   1 +
>  tools/perf/tests/openat-syscall-tp-fields.c       |   3 +-
>  tools/perf/tests/parse-no-sample-id-all.c         |   4 +-
>  tools/perf/tests/perf-record.c                    |   2 +-
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh |   2 +-
>  tools/perf/tests/switch-tracking.c                |   1 +
>  tools/perf/tests/task-exit.c                      |   1 +
>  tools/perf/trace/beauty/ioctl.c                   |   2 +-
>  tools/perf/ui/browsers/res_sample.c               |   2 +
>  tools/perf/ui/browsers/scripts.c                  |   8 +-
>  tools/perf/ui/stdio/hist.c                        |   1 +
>  tools/perf/util/Build                             |   1 +
>  tools/perf/util/annotate.c                        |   2 +
>  tools/perf/util/auxtrace.c                        |   2 +-
>  tools/perf/util/bpf-event.c                       |  36 +++---
>  tools/perf/util/bpf-event.h                       |  10 +-
>  tools/perf/util/cacheline.c                       |  26 ++++
>  tools/perf/util/cacheline.h                       |  21 +++
>  tools/perf/util/callchain.c                       |   1 +
>  tools/perf/util/cpumap.h                          |   2 -
>  tools/perf/util/data.c                            |   1 -
>  tools/perf/util/event.c                           |  35 +++--
>  tools/perf/util/event.h                           | 149 +++++-----------------
>  tools/perf/util/evlist.c                          |   2 +-
>  tools/perf/util/evsel.c                           |  22 ++--
>  tools/perf/util/evsel.h                           |   4 +-
>  tools/perf/util/get_current_dir_name.c            |   1 -
>  tools/perf/util/hist.c                            |   5 +-
>  tools/perf/util/intel-bts.c                       |   2 +-
>  tools/perf/util/kvm-stat.h                        |   2 +-
>  tools/perf/util/machine.c                         |  25 ++--
>  tools/perf/util/machine.h                         |   1 +
>  tools/perf/util/namespaces.c                      |   2 +-
>  tools/perf/util/namespaces.h                      |   4 +-
>  tools/perf/util/python.c                          |  58 ++++-----
>  tools/perf/util/record.c                          |   1 +
>  tools/perf/util/record.h                          |  74 +++++++++++
>  tools/perf/util/session.c                         |  16 +--
>  tools/perf/util/sort.c                            |  12 +-
>  tools/perf/util/sort.h                            |  27 +---
>  tools/perf/util/stat-display.c                    |   1 -
>  tools/perf/util/stat.c                            |   1 +
>  tools/perf/util/stat.h                            |   7 +-
>  tools/perf/util/thread.c                          |   4 +-
>  tools/perf/util/thread.h                          |   4 +-
>  tools/perf/util/tool.h                            |   2 +-
>  tools/perf/util/top.h                             |   1 +
>  tools/perf/util/util.c                            |  20 ---
>  tools/perf/util/util.h                            |   1 -
>  69 files changed, 493 insertions(+), 427 deletions(-)
>  create mode 100644 tools/perf/lib/include/perf/event.h
>  create mode 100644 tools/perf/util/cacheline.c
>  create mode 100644 tools/perf/util/cacheline.h
>  create mode 100644 tools/perf/util/record.h

Pulled, thanks a lot Arnaldo!

	Ingo
