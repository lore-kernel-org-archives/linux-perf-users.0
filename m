From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/40] perf/core improvements and fixes
Date: Wed, 26 Jul 2017 19:10:09 +0200
Message-ID: <20170726171009.74vcmk2lwecuwup2@gmail.com>
References: <20170726141730.30750-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35660 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdGZRKP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jul 2017 13:10:15 -0400
Content-Disposition: inline
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Arun Kalyanasundaram <arunkaly@google.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kan Liang <kan.liang@intel.com>, Kees Cook <keescook@chromium.org>, Krister Johansen <kjlx@templeofstupid.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 510457ec9dc259b002879bcfe475f89d4514a0fc:
> 
>   Merge tag 'perf-core-for-mingo-4.13-20170718' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-07-20 10:31:52 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170725
> 
> for you to fetch changes up to 62e6039f02888efdd824e8c596c4927616a97ce3:
> 
>   perf tools: Add tools/include/uapi/asm-generic/fcntl.h to the MANIFEST (2017-07-25 22:46:37 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvemends and fixes for v4.14:
> 
> New features:
> 
> - Filter out 'sshd' in the tracer ancestry in 'perf trace' syswide tracing,
>   to elliminate tracing loops (Arnaldo Carvalho de Melo)
> 
> - Support lookup of symbols in other mount namespaces in 'perf top' (Krister Johansen)
> 
> - Initial 'clone' syscall args beautifier in 'perf trace' (Arnaldo Carvalho de Melo)
> 
> User visible:
> 
> - Ignore 'fd' and 'offset' args for MAP_ANONYMOUS in 'perf trace'
>   (Arnaldo Carvalho de Melo)
> 
> - Process tracing data in 'perf annotate' pipe mode (David Carrillo-Cisneros)
> 
> - Make 'perf report --branch-history' work without callgraphs(-g) option
>   in perf record (Jin Yao)
> 
> - Tag branch type/flag on "to" and tag cycles on "from" in 'perf report' (Jin Yao)
> 
> Fixes:
> 
> - Fix jvmti linker error when libelf config is disabled (Sudeep Holla)
> 
> - Fix cgroups refcount usage (Arnaldo Carvalho de Melo)
> 
> - Fix kernel symbol adjustment for s390x (Thomas Richter)
> 
> - Fix 'perf report --stdio --show-total-period', it was showing the
>   number of samples, not the total period (Taeung Song)
> 
> Infrastructure:
> 
> - Add perf_sample dictionary to tracepoint handlers in 'perf script'
>   python, which were already present for other types of events
>   (hardware, etc) (Arun Kalyanasundaram)
> 
> - Make build fail on vendor events JSON parse error (Andi Kleen)
> 
> - Adopt strstarts() from the kernel (Arnaldo Carvalho de Melo)
> 
> Arch specific:
> 
> - Set no_aux_samples for the tracking event in Intel PT (Kan Liang)
> 
> - Always set no branch for Intel PT dummy event (Kan Liang)
> 
> Trivial:
> 
> - Simplify some error handlers in 'perf script' (Dan Carpenter)
> 
> - Add EXCLUDE_EXTLIBS and EXTRA_PERFLIBS to makefile (David Carrillo-Cisneros)
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf jevents: Make build fail on JSON parse error
> 
> Arnaldo Carvalho de Melo (16):
>       perf trace: Add missing ' = ' in the default formatting of syscall returns
>       perf trace beauty mmap: Ignore 'fd' and 'offset' args for MAP_ANONYMOUS
>       perf trace: Allow allocating sc->arg_fmt even without the syscall tracepoint
>       perf trace: Use the syscall_fmt formatters without a tracepoint
>       perf trace: Ditch __syscall__arg_val() variant, not needed anymore
>       perf trace: Allow specifying number of syscall args for tracepointless syscalls
>       perf trace: Allow specifying names to syscall arguments formatters
>       tools include uapi: Grab a copy of linux/sched.h
>       perf trace beauty clone: Beautify syscall arguments
>       perf trace beauty clone: Suppress unused args according to 'flags' arg
>       perf trace: Introduce filter_loop_pids()
>       perf trace: Filter out 'sshd' in the tracer ancestry in syswide tracing
>       tools include: Adopt strstarts() from the kernel
>       tools lib: Update copy of strtobool from the kernel sources
>       perf cgroup: Fix refcount usage
>       perf tools: Add tools/include/uapi/asm-generic/fcntl.h to the MANIFEST
> 
> Arun Kalyanasundaram (5):
>       perf script python: Allocate memory only if handler exists
>       perf script python: Refactor creation of perf sample dict
>       perf script python: Add sample_read to dict
>       perf script python: Add perf_sample dict to tracepoint handlers
>       perf script python: Generate hooks with additional argument
> 
> Dan Carpenter (1):
>       perf script: Remove some bogus error handling
> 
> David Carrillo-Cisneros (2):
>       perf tools: Add EXCLUDE_EXTLIBS and EXTRA_PERFLIBS to makefile
>       perf annotate: Process tracing data in pipe mode
> 
> Jin Yao (2):
>       perf report: Make --branch-history work without callgraphs(-g) option in perf record
>       perf report: Tag branch type/flag on "to" and tag cycles on "from"
> 
> Jiri Olsa (1):
>       perf evsel: Add verbose output for sys_perf_event_open fallback
> 
> Kan Liang (2):
>       perf intel-pt: Set no_aux_samples for the tracking event
>       perf intel-pt: Always set no branch for dummy event
> 
> Krister Johansen (1):
>       perf top: Support lookup of symbols in other mount namespaces.
> 
> Sudeep Holla (1):
>       perf jvmti: Fix linker error when libelf config is disabled
> 
> Taeung Song (7):
>       perf annotate: Introduce struct sym_hist_entry
>       perf annotate: Rename 'sum' to 'nr_samples' in struct sym_hist
>       perf hists: Pass perf_sample to __symbol__inc_addr_samples()
>       perf annotate: Store the sample period in each histogram bucket
>       perf annotate: Do not overwrite sample->period
>       perf annotate stdio: Fix --show-total-period
>       perf annotate stdio: Fix column header when using --show-total-period
> 
> Thomas Richter (1):
>       perf report: Fix kernel symbol adjustment for s390x
> 
>  tools/include/linux/string.h                       |  12 +-
>  tools/include/uapi/linux/sched.h                   |  52 +++++
>  tools/lib/string.c                                 |  41 ++--
>  tools/lib/subcmd/help.c                            |   2 +-
>  tools/lib/subcmd/parse-options.c                   |  18 +-
>  tools/perf/Documentation/perf-top.txt              |   4 +
>  tools/perf/MANIFEST                                |   2 +
>  tools/perf/Makefile.perf                           |  10 +-
>  tools/perf/arch/s390/util/Build                    |   1 +
>  tools/perf/arch/s390/util/sym-handling.c           |  22 ++
>  tools/perf/arch/x86/util/intel-pt.c                |   3 +
>  tools/perf/builtin-annotate.c                      |   4 +-
>  tools/perf/builtin-config.c                        |   3 +-
>  tools/perf/builtin-ftrace.c                        |   2 +-
>  tools/perf/builtin-help.c                          |   6 +-
>  tools/perf/builtin-report.c                        |  27 ++-
>  tools/perf/builtin-script.c                        |   7 +-
>  tools/perf/builtin-top.c                           |  20 +-
>  tools/perf/builtin-trace.c                         | 140 ++++++++----
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/perf.c                                  |  16 +-
>  tools/perf/pmu-events/README                       |   4 -
>  tools/perf/pmu-events/jevents.c                    |  21 +-
>  tools/perf/trace/beauty/Build                      |   1 +
>  tools/perf/trace/beauty/beauty.h                   |   3 +
>  tools/perf/trace/beauty/clone.c                    |  75 +++++++
>  tools/perf/trace/beauty/mmap.c                     |   3 +
>  tools/perf/ui/browser.c                            |   3 +-
>  tools/perf/ui/browsers/annotate.c                  |   9 +-
>  tools/perf/ui/gtk/annotate.c                       |   4 +-
>  tools/perf/ui/stdio/hist.c                         |   3 +-
>  tools/perf/util/annotate.c                         |  99 +++++----
>  tools/perf/util/annotate.h                         |  18 +-
>  tools/perf/util/bpf-loader.c                       |   2 +-
>  tools/perf/util/branch.h                           |  11 +-
>  tools/perf/util/callchain.c                        | 157 +++++++++----
>  tools/perf/util/cgroup.c                           |   8 +-
>  tools/perf/util/config.c                           |  13 +-
>  tools/perf/util/evsel.c                            |   8 +
>  tools/perf/util/hist.c                             |   2 +
>  tools/perf/util/llvm-utils.c                       |   2 +-
>  tools/perf/util/machine.c                          |  13 +-
>  .../util/scripting-engines/trace-event-python.c    | 246 +++++++++++++++------
>  43 files changed, 798 insertions(+), 300 deletions(-)
>  create mode 100644 tools/include/uapi/linux/sched.h
>  create mode 100644 tools/perf/arch/s390/util/sym-handling.c
>  create mode 100644 tools/perf/trace/beauty/clone.c

Pulled, thanks a lot Arnaldo!

	Ingo
