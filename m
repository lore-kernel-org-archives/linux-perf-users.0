From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/54] perf/core improvements and fixes
Date: Fri, 9 Mar 2018 08:29:32 +0100
Message-ID: <20180309072932.nphzr4smyxzupzbt@gmail.com>
References: <20180308195029.14991-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Lakshman Annadorai <lakshmana@google.com>, linux-arm-kernel@lists.infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
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
> The following changes since commit 3f986eefc89c528bf2d398a6dc3637b743a7139e:
> 
>   Merge branch 'perf/urgent' into perf/core, to resolve conflict (2018-03-07 09:23:12 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180308
> 
> for you to fetch changes up to 2427b432e63b4b911100f717c48289195b7a7d62:
> 
>   perf tools: Update quipper information (2018-03-08 11:30:54 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Support to display the IPC/Cycle in 'annotate' TUI, for systems
>   where this info can be obtained, like Intel's >= Skylake (Jin Yao)
> 
> - Support wildcards on PMU name in dynamic PMU events (Agustin Vega-Frias)
> 
> - Display pmu name when printing unmerged events in stat (Agustin Vega-Frias)
> 
> - Auto-merge PMU events created by prefix or glob match (Agustin Vega-Frias)
> 
> - Fix s390 'call' operations target function annotation (Thomas Richter)
> 
> - Handle s390 PC relative load and store instruction in the augmented
>   'annotate', code, used so far in the TUI modes of 'perf report' and
>   'perf annotate' (Thomas Richter)
> 
> - Provide libtraceevent with a kernel symbol resolver, so that
>   symbols in tracepoint fields can be resolved when showing them in
>   tools such as 'perf report' (Wang YanQing)
> 
> - Refactor the cgroups code to look more like other code in tools/perf,
>   using cgroup__{put,get} for refcount operations instead of its
>   open-coded equivalent, breaking larger functions, etc (Arnaldo Carvalho de Melo)
> 
> - Implement support for the -G/--cgroup target in 'perf trace', allowing
>   strace like tracing (plus other events, backtraces, etc) for cgroups
>   (Arnaldo Carvalho de Melo)
> 
> - Update thread shortname in 'perf sched map' when the thread's COMM
>   changes (Changbin Du)
> 
> - refcount 'struct mem_info', for better sharing it over several
>   users, avoid duplicating structs and fixing crashes related to
>   use after free (Jiri Olsa)
> 
> - Display perf.data version, offsets in 'perf report --header' (Jiri Olsa)
> 
> - Record the machine's memory topology information in a perf.data
>   feature section, to be used by tools such as 'perf c2c' (Jiri Olsa)
> 
> - Fix output of forced groups in the header for 'perf report' --stdio
>   and --tui (Jiri Olsa)
> 
> - Better support llvm, clang, cxx make tests in the build process (Jiri Olsa)
> 
> - Streamline the 'struct perf_mmap' methods, storing some info in the
>   struct instead of passing it via various methods, shortening its
>   signatures (Kan Liang)
> 
> - Update the quipper perf.data parser library site information (Stephane Eranian)
> 
> - Correct perf's man pages title markers for asciidoctor (Takashi Iwai)
> 
> - Intel PT fixes and refactorings paving the way for implementing
>   support for AUX area sampling (Adrian Hunter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (13):
>       perf record: Combine some auxtrace initialization into a single function
>       perf auxtrace: Add missing parameters from kernel-doc comments
>       perf auxtrace: Rename some buffer-queuing functions
>       perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr
>       perf intel-pt: Fix overlap detection to identify consecutive buffers correctly
>       perf intel-pt: Fix sync_switch
>       perf intel-pt: Fix error recovery from missing TIP packet
>       perf intel-pt: Fix timestamp following overflow
>       perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL
>       perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()
>       perf intel-pt: Tidy old_buffer handling in intel_pt_get_trace()
>       perf intel-pt: Remove a check for sampling mode
>       perf intel-pt: Adjust overlap-checking to support sampling mode
> 
> Agustin Vega-Frias (3):
>       perf pmu: Support wildcards on pmu name in dynamic pmu events
>       perf pmu: Display pmu name when printing unmerged events in stat
>       perf pmu: Auto-merge PMU events created by prefix or glob match
> 
> Arnaldo Carvalho de Melo (11):
>       perf cgroup: Remove misplaced __maybe_unused
>       perf cgroup: Rename 'struct cgroup_sel' to 'struct cgroup'
>       perf cgroup: Introduce cgroup__delete()
>       perf cgroup: Rename close_cgroup() to cgroup__put()
>       perf cgroup: Introduce cgroup__get()
>       perf cgroup: Introduce find_cgroup() method
>       perf cgroup: Introduce cgroup__new() out of open coded equivalent
>       perf cgroup: Add evlist__findnew_cgroup()
>       perf cgroup: Add evlist__add_default_cgroup()
>       perf cgroup: Make the cgroup name be const char *
>       perf trace: Support setting cgroups as targets
> 
> Changbin Du (2):
>       perf sched: Move thread::shortname to thread_runtime
>       perf sched map: Re-annotate shortname if thread comm changed
> 
> Jin Yao (1):
>       perf annotate: Support to display the IPC/Cycle in TUI mode
> 
> Jiri Olsa (11):
>       perf report: Fix the output for stdio events list
>       perf report: Display perf.data header info
>       perf record: Move machine variable down the function
>       perf record: Remove progname from struct record
>       perf tools: Add refcnt into struct mem_info
>       perf c2c: Use mem_info refcnt logic
>       perf tools: Add MEM_TOPOLOGY feature to perf data file
>       perf tools: Update tags with .cpp files
>       perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA
>       perf build: Add llvm/clang make targets to FILES
>       perf build: Force llvm/clang test compile output to .make.output
> 
> Kan Liang (8):
>       perf evlist: Store 'overwrite' in struct perf_mmap
>       perf mmap: Store mmap scope in struct perf_mmap()
>       perf mmap: Use the stored scope data in perf_mmap__push()
>       perf mmap: Use the stored data in perf_mmap__read_event()
>       perf mmap: Use stored 'overwrite' in perf_mmap__consume()
>       perf mmap: Simplify perf_mmap__consume()
>       perf mmap: Simplify perf_mmap__read_event()
>       perf mmap: Simplify perf_mmap__read_init()
> 
> Stephane Eranian (1):
>       perf tools: Update quipper information
> 
> Takashi Iwai (1):
>       perf tools: Correct title markers for asciidoctor
> 
> Thomas Richter (2):
>       perf annotate: Fix s390 target function disassembly
>       perf annotate: Handle s390 PC relative load and store instruction.
> 
> Wang YanQing (1):
>       perf report: Provide libtraceevent with a kernel symbol resolver
> 
>  tools/build/Makefile.feature                       |   6 +-
>  tools/build/feature/Makefile                       |  14 +-
>  tools/include/linux/bitmap.h                       |   2 +-
>  tools/perf/Documentation/perf-data.txt             |   2 +-
>  tools/perf/Documentation/perf-ftrace.txt           |   2 +-
>  tools/perf/Documentation/perf-kallsyms.txt         |   2 +-
>  tools/perf/Documentation/perf-list.txt             |   8 +-
>  tools/perf/Documentation/perf-sched.txt            |   2 +-
>  tools/perf/Documentation/perf-script-perl.txt      |   2 +-
>  tools/perf/Documentation/perf-stat.txt             |  17 ++
>  tools/perf/Documentation/perf-trace.txt            |  25 ++
>  tools/perf/Documentation/perf.data-file-format.txt |   7 +-
>  tools/perf/Makefile.perf                           |   6 +-
>  tools/perf/arch/s390/annotate/instructions.c       | 116 +++++++-
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   7 +-
>  tools/perf/arch/x86/util/auxtrace.c                |  14 +-
>  tools/perf/builtin-annotate.c                      |  88 +++++-
>  tools/perf/builtin-c2c.c                           |  24 +-
>  tools/perf/builtin-kvm.c                           |   9 +-
>  tools/perf/builtin-record.c                        |  45 +--
>  tools/perf/builtin-report.c                        |  26 +-
>  tools/perf/builtin-sched.c                         | 133 ++++++---
>  tools/perf/builtin-stat.c                          |  29 +-
>  tools/perf/builtin-top.c                           |   7 +-
>  tools/perf/builtin-trace.c                         |  57 +++-
>  tools/perf/tests/backward-ring-buffer.c            |   5 +-
>  tools/perf/tests/bpf.c                             |   5 +-
>  tools/perf/tests/code-reading.c                    |   7 +-
>  tools/perf/tests/keep-tracking.c                   |   7 +-
>  tools/perf/tests/mmap-basic.c                      |   7 +-
>  tools/perf/tests/openat-syscall-tp-fields.c        |   7 +-
>  tools/perf/tests/perf-record.c                     |   7 +-
>  tools/perf/tests/sw-clock.c                        |   7 +-
>  tools/perf/tests/switch-tracking.c                 |   7 +-
>  tools/perf/tests/task-exit.c                       |   7 +-
>  tools/perf/ui/browsers/hists.c                     |   5 +-
>  tools/perf/util/annotate.c                         |   2 +-
>  tools/perf/util/auxtrace.c                         |  37 ++-
>  tools/perf/util/auxtrace.h                         |   2 +
>  tools/perf/util/cgroup.c                           | 111 +++++---
>  tools/perf/util/cgroup.h                           |  13 +-
>  tools/perf/util/env.h                              |   9 +
>  tools/perf/util/evlist.c                           |   8 +-
>  tools/perf/util/evsel.c                            |  23 +-
>  tools/perf/util/evsel.h                            |   6 +-
>  tools/perf/util/header.c                           | 312 ++++++++++++++++++++-
>  tools/perf/util/header.h                           |   1 +
>  tools/perf/util/hist.c                             |   4 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  64 ++---
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +-
>  tools/perf/util/intel-pt.c                         | 110 ++++----
>  tools/perf/util/machine.c                          |   2 +-
>  tools/perf/util/mmap.c                             |  63 ++---
>  tools/perf/util/mmap.h                             |  16 +-
>  tools/perf/util/parse-events.c                     |  21 +-
>  tools/perf/util/parse-events.h                     |   2 +-
>  tools/perf/util/parse-events.l                     |   2 +-
>  tools/perf/util/parse-events.y                     |  18 +-
>  tools/perf/util/python.c                           |   7 +-
>  tools/perf/util/symbol.c                           |  22 ++
>  tools/perf/util/symbol.h                           |  19 +-
>  tools/perf/util/thread.h                           |   1 -
>  62 files changed, 1197 insertions(+), 401 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
