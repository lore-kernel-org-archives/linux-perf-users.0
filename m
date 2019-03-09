From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/35] perf/core improvements and fixes
Date: Sat, 9 Mar 2019 17:02:20 +0100
Message-ID: <20190309160220.GA118776@gmail.com>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Jin Yao <yao.jin@linux.intel.com>, Mathias Krause <minipli@googlemail.com>, Michael Sartain <mikesart@fastmail.com>, Nageswara R Sastry <nasastry@in.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Song Liu <songliubraving@fb.com>, Tony Jones <tonyj@suse.de>, Travis Downs <travis.downs@gmail.com>, Yang Wei <yang.wei9@zte.com.cn>, Arnaldo Carvalho de Melo <acme@r>
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
> The following changes since commit c978b9460fe1d4a1e1effa0abd6bd69b18a098a8:
> 
>   Merge tag 'perf-core-for-mingo-5.1-20190225' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-02-28 08:29:50 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190307
> 
> for you to fetch changes up to b8f7d86b5849ea7bb84bddc0345a3799049764d4:
> 
>   perf data: Force perf_data__open|close zero data->file.path (2019-03-06 18:21:00 -0300)
> 
> ----------------------------------------------------------------
> perf bpf:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Automatically add BTF ELF markers to 'perf trace' BPF programs, so that
>     tools such as 'bpftool map dump' can pretty print map keys and values.
> 
> perf c2c:
> 
>   Jiri Olsa:
> 
>   - Fix report for empty NUMA node.
> 
> perf diff:
> 
>   Jin Yao:
> 
>   - Support --time, --cpu, --pid and --tid filter options.
> 
> perf probe:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Clarify error message about not finding kernel modules debuginfo.
> 
> perf record:
> 
>   Jiri Olsa:
> 
>   - Fixup probing for max attr.precise_ip.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add missing %s lost in the 'msg_flags' recvmmsg arg when adding prefix suppression logic.
> 
> perf annotate:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Calculate the max instruction name, align column to that, removing the
>     hardcoded max 6 chars and cope with instructions with names longer than that,
>     such as vpmovmskb, vpcmpeqb, etc.
> 
> kernel:
> 
>   Song Liu:
> 
>   - Consider events with attr.bpf_event set as side-band.
> 
>   Gustavo A. R. Silva:
> 
>   - Mark expected switch fall-through in perf_event_parse_addr_filter().
> 
> Libraries:
> 
>   Jiri Olsa:
> 
>   - Fix leaks and double frees on error paths.
> 
> libtraceevent:
> 
>   Tony Jones:
> 
>   - Fix buffer overflow in arg_eval().
> 
> python scripting:
> 
>   Tony Jones:
> 
>   - More python3 fixes.
> 
> Trivial:
> 
>   Yang Wei:
> 
>   - Remove needless extra semicolon in clang C++ glue code.
> 
> Intel PT/BTS:
> 
>   Adrian Hunter:
> 
>   - Improve auxtrace address filter error message when there is no DSO.
> 
>   - Fix divide by zero when TSC is not available.
> 
>   - Further improvements to the export to sqlite/posgresql python scripts
>     and to the GUI sqlviewer, exporting 'parent_id' so that we have enable
>     the creation of call trees.
> 
>   Andi Kleen:
> 
>   - Generalize function to copy from thread addr space from intel-bts code.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (10):
>       perf auxtrace: Improve address filter error message when there is no DSO
>       perf intel-pt: Fix divide by zero when TSC is not available
>       perf db-export: Add calls parent_id to enable creation of call trees
>       perf scripts python: export-to-sqlite.py: Export calls parent_id
>       perf scripts python: export-to-postgresql.py: Fix invalid input syntax for integer error
>       perf scripts python: export-to-postgresql.py: Export calls parent_id
>       perf scripts python: exported-sql-viewer.py: Factor out TreeWindowBase
>       perf scripts python: exported-sql-viewer.py: Improve TreeModel abstraction
>       perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase
>       perf scripts python: exported-sql-viewer.py: Add call tree
> 
> Andi Kleen (1):
>       perf thread: Generalize function to copy from thread addr space from intel-bts code
> 
> Arnaldo Carvalho de Melo (4):
>       perf probe: Clarify error message about not finding kernel modules debuginfo
>       perf beauty msg_flags: Add missing %s lost when adding prefix suppression logic
>       perf bpf: Automatically add BTF ELF markers
>       perf annotate: Calculate the max instruction name, align column to that
> 
> Gustavo A. R. Silva (1):
>       perf: Mark expected switch fall-through
> 
> Jin Yao (4):
>       perf time-utils: Refactor time range parsing code
>       perf diff: Support --time filter option
>       perf diff: Support --cpu filter option
>       perf diff: Support --pid/--tid filter options
> 
> Jiri Olsa (7):
>       perf c2c: Fix c2c report for empty numa node
>       perf hist: Add error path into hist_entry__init
>       perf hist: Fix memory leak of srcline
>       perf tools: Read and store caps/max_precise in perf_pmu
>       perf evsel: Probe for precise_ip with simple attr
>       perf session: Fix double free in perf_data__close
>       perf data: Force perf_data__open|close zero data->file.path
> 
> Song Liu (1):
>       perf, bpf: Consider events with attr.bpf_event as side-band events
> 
> Tony Jones (6):
>       tools lib traceevent: Fix buffer overflow in arg_eval
>       perf script python: Remove mixed indentation
>       perf script python: Add Python3 support to futex-contention.py
>       perf script python: add Python3 support to check-perf-trace.py
>       perf script python: Add Python3 support to event_analyzing_sample.py
>       perf script python: Add Python3 support to intel-pt-events.py
> 
> Yang Wei (1):
>       perf clang: Remove needless extra semicolon
> 
>  kernel/events/core.c                               |   4 +-
>  tools/lib/traceevent/event-parse.c                 |   2 +-
>  tools/perf/Documentation/perf-diff.txt             |  56 ++++
>  tools/perf/arch/arm64/annotate/instructions.c      |   2 +-
>  tools/perf/arch/s390/annotate/instructions.c       |   2 +-
>  tools/perf/builtin-c2c.c                           |   8 +-
>  tools/perf/builtin-diff.c                          | 168 +++++++++-
>  tools/perf/builtin-report.c                        |  38 +--
>  tools/perf/builtin-script.c                        |  39 +--
>  tools/perf/include/bpf/bpf.h                       |   8 +-
>  tools/perf/scripts/python/check-perf-trace.py      |  76 ++---
>  tools/perf/scripts/python/compaction-times.py      |   8 +-
>  .../perf/scripts/python/event_analyzing_sample.py  |  48 +--
>  tools/perf/scripts/python/export-to-postgresql.py  |  16 +-
>  tools/perf/scripts/python/export-to-sqlite.py      |  12 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   | 354 ++++++++++++++++-----
>  .../perf/scripts/python/failed-syscalls-by-pid.py  |  38 +--
>  tools/perf/scripts/python/futex-contention.py      |  10 +-
>  tools/perf/scripts/python/intel-pt-events.py       |  60 ++--
>  tools/perf/scripts/python/mem-phys-addr.py         |   7 +-
>  tools/perf/scripts/python/net_dropmonitor.py       |   2 +-
>  tools/perf/scripts/python/netdev-times.py          |  12 +-
>  tools/perf/scripts/python/sched-migration.py       |   6 +-
>  tools/perf/scripts/python/sctop.py                 |  13 +-
>  tools/perf/scripts/python/stackcollapse.py         |   2 +-
>  tools/perf/scripts/python/syscall-counts-by-pid.py |  47 ++-
>  tools/perf/scripts/python/syscall-counts.py        |  31 +-
>  tools/perf/trace/beauty/msg_flags.c                |   2 +-
>  tools/perf/util/annotate.c                         |  74 +++--
>  tools/perf/util/annotate.h                         |   7 +-
>  tools/perf/util/auxtrace.c                         |   3 +-
>  tools/perf/util/c++/clang.cpp                      |   2 +-
>  tools/perf/util/data.c                             |   4 +-
>  tools/perf/util/db-export.c                        |  15 +-
>  tools/perf/util/db-export.h                        |   3 +-
>  tools/perf/util/evlist.c                           |  25 +-
>  tools/perf/util/evsel.c                            |   8 -
>  tools/perf/util/hist.c                             |  51 +--
>  tools/perf/util/intel-bts.c                        |  20 +-
>  tools/perf/util/intel-pt.c                         |   2 +
>  tools/perf/util/pmu.c                              |  14 +
>  tools/perf/util/pmu.h                              |   1 +
>  tools/perf/util/probe-event.c                      |   9 +-
>  .../util/scripting-engines/trace-event-python.c    |   8 +-
>  tools/perf/util/session.c                          |   4 +-
>  tools/perf/util/thread-stack.c                     |  16 +-
>  tools/perf/util/thread-stack.h                     |   6 +-
>  tools/perf/util/thread.c                           |  23 ++
>  tools/perf/util/thread.h                           |   3 +
>  tools/perf/util/time-utils.c                       |  51 ++-
>  tools/perf/util/time-utils.h                       |   6 +
>  51 files changed, 978 insertions(+), 448 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
