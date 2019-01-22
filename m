From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/24] perf/core improvements and fixes
Date: Tue, 22 Jan 2019 11:07:54 +0100
Message-ID: <20190122100754.GA113758@gmail.com>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Brajeswar Ghosh <brajeswar.linux@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Song Liu <songliubraving@fb.com>, Thomas Richter <tmricht@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit ad07c8ceb6631a83b62d405a61448bba92adac68:
> 
>   perf/core: Remove unused perf_flags (2019-01-21 11:01:31 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.0-20190121
> 
> for you to fetch changes up to 32e9136e37840a62c659259a394ed3735e3b3c84:
> 
>   perf utils: Move perf_config using routines from color.c to separate object (2019-01-21 17:38:56 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> BPF:
> 
>   Song Liu:
> 
>   - Introduce PERF_RECORD_KSYMBOL to allow tooling to notice the addition
>     of new kernel symbols and be able to resolve samples in such symbols.
> 
>   - Introduce PERF_RECORD_BPF_EVENT to notify tooling about the loading
>     and unloading of BPF programs, making them visible and allowing for
>     the request of further information to allow for things like annotation.
> 
>   - Change the userspace perf tools to handle those new events and to
>     synthesize them for pre-existing loaded BPF programs.
> 
> Kernel:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Make perf_event_output() propagate the output() return, allowing
>     users to check for -ENOSPC in the ring buffer.
> 
> perf report:
> 
>   Thomas Richter:
> 
>   - Display arch specific diagnostic counter sets, starting with s390
>     diagnostic counter sets.
> 
> perf session:
> 
>   Jiri Olsa:
> 
>   - Introduce a reader object to prep for multithreaded processing
>     of recorded events.
> 
> Misc:
> 
>   Rasmus Villemoes:
> 
>   - Replace automatic const char[] variables by statics, to avoid
>     initializing them at runtime, instead having them in .rodata,
>     reducing code size.
> 
>   YueHaibing:
> 
>   - Remove duplicated workqueue.h include from perf_event.h
> 
>   Brajeswar Ghosh:
> 
>   - Remove some more duplicated headers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf: Make perf_event_output() propagate the output() return
>       perf top: Synthesize BPF events for pre-existing loaded BPF programs
>       perf python: Remove -fstack-clash-protection when building with some clang versions
>       perf utils: Move perf_config using routines from color.c to separate object
> 
> Brajeswar Ghosh (1):
>       perf tools: Remove duplicate headers
> 
> Jiri Olsa (6):
>       perf session: Rearrange perf_session__process_events function
>       perf session: Get rid of file_size variable
>       perf session: Add reader object
>       perf session: Add 'data_size' member to reader object
>       perf session: Add 'data_offset' member to reader object
>       perf session: Add reader__process_events function
> 
> Rasmus Villemoes (1):
>       perf tools: Replace automatic const char[] variables by statics
> 
> Song Liu (8):
>       perf, bpf: Introduce PERF_RECORD_KSYMBOL
>       tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
>       perf, bpf: Introduce PERF_RECORD_BPF_EVENT
>       tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
>       perf tools: Handle PERF_RECORD_KSYMBOL
>       perf tools: Handle PERF_RECORD_BPF_EVENT
>       perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
>       bpf: Add module name [bpf] to ksymbols for bpf programs
> 
> Thomas Richter (3):
>       perf report: Display arch specific diagnostic counter sets, starting with s390
>       perf report: Display names in s390 diagnostic counter sets
>       perf report: Dump s390 counter set data to file
> 
> YueHaibing (1):
>       perf: Remove duplicated workqueue.h include from perf_event.h
> 
>  include/linux/filter.h                           |   7 +
>  include/linux/perf_event.h                       |  21 +-
>  include/uapi/linux/perf_event.h                  |  53 ++++-
>  kernel/bpf/core.c                                |   2 +-
>  kernel/bpf/syscall.c                             |   2 +
>  kernel/events/core.c                             | 224 +++++++++++++++++++-
>  kernel/kallsyms.c                                |   2 +-
>  kernel/trace/bpf_trace.c                         |   3 +-
>  tools/include/uapi/linux/perf_event.h            |  53 ++++-
>  tools/perf/builtin-c2c.c                         |   4 +-
>  tools/perf/builtin-kmem.c                        |   4 +-
>  tools/perf/builtin-record.c                      |   7 +
>  tools/perf/builtin-report.c                      |   6 +-
>  tools/perf/builtin-sched.c                       |   2 +-
>  tools/perf/builtin-stat.c                        |   1 -
>  tools/perf/builtin-top.c                         |   7 +
>  tools/perf/examples/bpf/augmented_raw_syscalls.c |   4 +-
>  tools/perf/examples/bpf/augmented_syscalls.c     |  14 +-
>  tools/perf/examples/bpf/etcsnoop.c               |  10 +-
>  tools/perf/perf.h                                |   1 +
>  tools/perf/tests/bp_account.c                    |   1 -
>  tools/perf/ui/browsers/header.c                  |   2 +-
>  tools/perf/ui/browsers/hists.c                   |   4 +-
>  tools/perf/util/Build                            |   5 +
>  tools/perf/util/bpf-event.c                      | 257 +++++++++++++++++++++++
>  tools/perf/util/bpf-event.h                      |  38 ++++
>  tools/perf/util/color.c                          |  39 ----
>  tools/perf/util/color_config.c                   |  47 +++++
>  tools/perf/util/dso.h                            |   1 -
>  tools/perf/util/event.c                          |  41 ++++
>  tools/perf/util/event.h                          |  36 ++++
>  tools/perf/util/evlist.h                         |   4 +-
>  tools/perf/util/evsel.c                          |  19 +-
>  tools/perf/util/evsel.h                          |   2 +
>  tools/perf/util/machine.c                        |  58 +++++
>  tools/perf/util/machine.h                        |   3 +
>  tools/perf/util/s390-cpumcf-kernel.h             |  62 ++++++
>  tools/perf/util/s390-cpumsf.c                    |  77 ++++++-
>  tools/perf/util/s390-sample-raw.c                | 222 ++++++++++++++++++++
>  tools/perf/util/sample-raw.c                     |  18 ++
>  tools/perf/util/sample-raw.h                     |  14 ++
>  tools/perf/util/session.c                        |  98 ++++++---
>  tools/perf/util/setup.py                         |   2 +
>  tools/perf/util/tool.h                           |   5 +-
>  tools/perf/util/zlib.c                           |   1 -
>  45 files changed, 1358 insertions(+), 125 deletions(-)
>  create mode 100644 tools/perf/util/bpf-event.c
>  create mode 100644 tools/perf/util/bpf-event.h
>  create mode 100644 tools/perf/util/color_config.c
>  create mode 100644 tools/perf/util/s390-cpumcf-kernel.h
>  create mode 100644 tools/perf/util/s390-sample-raw.c
>  create mode 100644 tools/perf/util/sample-raw.c
>  create mode 100644 tools/perf/util/sample-raw.h

Pulled, thanks a lot Arnaldo!

	Ingo
