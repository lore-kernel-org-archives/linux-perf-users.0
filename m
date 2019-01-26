From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/29] perf/core improvements and fixes
Date: Sat, 26 Jan 2019 10:52:09 +0100
Message-ID: <20190126095209.GA88083@gmail.com>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>, Song Liu <songliubraving@fb.com>, Tony Jones <tonyj@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit f575494d4a610278ea8597f2f798c8431b94e884:
> 
>   Merge tag 'perf-core-for-mingo-5.0-20190121' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-01-22 11:07:01 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.0-20190126
> 
> for you to fetch changes up to 76a06125dd57ed2c7559410168b543313fa0cc51:
> 
>   perf augmented_syscalls: Convert to bpf_map() (2019-01-25 15:12:11 +0100)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> BPF:
> 
>   Song Liu:
> 
>   - Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add bpf_map() helper, to make BPF map declararions more compact and
>     allow for BTF annotations to be made transparently.
> 
> perf script python:
> 
>   Tony Jones:
> 
>   - Remove explicit shebangs.
> 
>   - Fix the PYTHON=python3 builds.
> 
> Core:
> 
>   Davidlohr Bueso:
> 
>   - Update rbtree implementation, getting it closer to the kernel one.
> 
>   - Use cached rbtrees.
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove some needless headers from .c and .h files fixing up the fallout,
>     to reduce building time when changes are made to .h files
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (16):
>       perf color: Add missing stdarg.g to color.h
>       perf symbols: Move symbol_conf to separate file
>       perf annotate: Remove lots of headers from annotate.h
>       perf tools: Move branch structs to branch.h
>       perf block-range: Add missing headers
>       perf symbols: Remove include map.h from dso.h
>       perf symbols: Remove some unnecessary includes from symbol.h
>       perf namespaces: Remove namespaces.h from .h headers
>       perf comm: Remove needless headers from comm.h
>       perf callchain: No need to include perf.h
>       perf bpf: Add bpf_map() helper
>       perf bpf: Convert pid_map() to bpf_map()
>       perf augmented_raw_syscalls: Use bpf_map()
>       perf trace: Fixup etcsnoop example
>       perf bpf examples: Convert etcsnoop to use bpf_map()
>       perf augmented_syscalls: Convert to bpf_map()
> 
> Davidlohr Bueso (7):
>       tools: Update rbtree implementation
>       perf machine: Use cached rbtrees
>       perf callchain: Use cached rbtrees
>       perf util: Use cached rbtree for rblists
>       perf symbols: Use cached rbtrees
>       perf hist: Use cached rbtrees
>       perf sched: Use cached rbtrees
> 
> Song Liu (1):
>       perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT
> 
> Tony Jones (6):
>       perf script python: Add trace_context extension module to sys.modules
>       perf script python: Use PyBytes for attr in trace-event-python
>       perf script python: Remove explicit shebang from setup.py
>       perf script python: Remove explicit shebang from tests/attr.c
>       perf script python: Remove explicit shebang from Python scripts
>       perf script python: Add Python3 support to tests/attr.py
> 
>  tools/include/linux/rbtree.h                       |  52 +++++-
>  tools/include/linux/rbtree_augmented.h             |  60 +++++--
>  tools/lib/rbtree.c                                 | 178 +++++++++++++-----
>  tools/perf/Makefile.perf                           |   4 +-
>  tools/perf/builtin-annotate.c                      |   4 +-
>  tools/perf/builtin-c2c.c                           |   6 +-
>  tools/perf/builtin-diff.c                          |  10 +-
>  tools/perf/builtin-probe.c                         |   1 +
>  tools/perf/builtin-report.c                        |   3 +-
>  tools/perf/builtin-sched.c                         |  45 ++---
>  tools/perf/builtin-top.c                           |   2 +-
>  tools/perf/builtin-trace.c                         |   3 +-
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   |  14 +-
>  tools/perf/examples/bpf/augmented_syscalls.c       |   8 +-
>  tools/perf/examples/bpf/etcsnoop.c                 |   8 +-
>  tools/perf/include/bpf/bpf.h                       |  16 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   |   1 -
>  tools/perf/scripts/python/sched-migration.py       |   2 -
>  tools/perf/scripts/python/stat-cpi.py              |   1 -
>  tools/perf/tests/attr.py                           |  33 ++--
>  tools/perf/tests/hists_common.c                    |   8 +-
>  tools/perf/tests/hists_cumulate.c                  |  14 +-
>  tools/perf/tests/hists_link.c                      |   8 +-
>  tools/perf/tests/hists_output.c                    |  32 ++--
>  tools/perf/ui/browsers/hists.c                     |  16 +-
>  tools/perf/ui/browsers/map.c                       |   1 +
>  tools/perf/ui/gtk/annotate.c                       |   1 +
>  tools/perf/ui/gtk/hists.c                          |   6 +-
>  tools/perf/ui/stdio/hist.c                         |   3 +-
>  tools/perf/util/annotate.c                         |   1 +
>  tools/perf/util/annotate.h                         |  14 +-
>  tools/perf/util/block-range.c                      |   2 +
>  tools/perf/util/block-range.h                      |   6 +-
>  tools/perf/util/bpf-event.c                        |  10 +-
>  tools/perf/util/branch.h                           |  27 ++-
>  tools/perf/util/build-id.c                         |  13 +-
>  tools/perf/util/build-id.h                         |   3 +-
>  tools/perf/util/callchain.h                        |   1 -
>  tools/perf/util/color.h                            |   1 +
>  tools/perf/util/comm.c                             |   1 +
>  tools/perf/util/comm.h                             |   4 +-
>  tools/perf/util/dso.c                              |  10 +-
>  tools/perf/util/dso.h                              |  16 +-
>  tools/perf/util/event.h                            |  21 +--
>  tools/perf/util/hist.c                             | 199 ++++++++++++---------
>  tools/perf/util/hist.h                             |  10 +-
>  tools/perf/util/intlist.h                          |   2 +-
>  tools/perf/util/jitdump.c                          |   1 +
>  tools/perf/util/machine.c                          |  53 +++---
>  tools/perf/util/machine.h                          |  12 +-
>  tools/perf/util/map.c                              |   8 +-
>  tools/perf/util/metricgroup.c                      |   2 +-
>  tools/perf/util/probe-event.c                      |   4 +-
>  tools/perf/util/probe-event.h                      |   5 +-
>  tools/perf/util/probe-file.c                       |   1 +
>  tools/perf/util/rb_resort.h                        |   8 +-
>  tools/perf/util/rblist.c                           |  28 +--
>  tools/perf/util/rblist.h                           |   2 +-
>  .../util/scripting-engines/trace-event-python.c    |  15 +-
>  tools/perf/util/setup.py                           |   2 -
>  tools/perf/util/sort.h                             |   4 +-
>  tools/perf/util/srcline.c                          |  43 +++--
>  tools/perf/util/srcline.h                          |  13 +-
>  tools/perf/util/stat-display.c                     |   1 +
>  tools/perf/util/stat-shadow.c                      |   2 +-
>  tools/perf/util/strlist.h                          |   2 +-
>  tools/perf/util/symbol-minimal.c                   |   1 +
>  tools/perf/util/symbol.c                           |  87 ++++-----
>  tools/perf/util/symbol.h                           |  88 ++-------
>  tools/perf/util/symbol_conf.h                      |  73 ++++++++
>  tools/perf/util/symbol_fprintf.c                   |   3 +-
>  tools/perf/util/thread.h                           |   1 +
>  tools/perf/util/util.c                             |   1 +
>  73 files changed, 810 insertions(+), 531 deletions(-)
>  create mode 100644 tools/perf/util/symbol_conf.h

Pulled, thanks a lot Arnaldo!

	Ingo
