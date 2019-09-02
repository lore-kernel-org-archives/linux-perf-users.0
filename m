From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Mon, 2 Sep 2019 09:14:00 +0200
Message-ID: <20190902071400.GA78337@gmail.com>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Joe Mario <jmario@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kyle Meyer <kyle.meyer@hpe.com>, Patrick McLean <chutzpah@gentoo.org>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 39c2ca43465e0f52ebba3ee96fd03436367c1880:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190829' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-08-29 20:56:32 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190901
> 
> for you to fetch changes up to ae31a514a134d9e4ca1d7b0f0a19b5934747d79f:
> 
>   objtool: Ignore intentional differences for the x86 insn decoder (2019-08-31 22:27:52 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> objtool:
> 
>   Josh Poimboeuf:
> 
>   - Move x86 insn decoder to a common location.
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Ignore intentional differences for the x86 insn decoder.
> 
> build:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Ignore intentional differences for the x86 insn decoder.
> 
> Intel PT:
> 
>   Josh Poimboeuf:
> 
>   - Use shared x86 insn decoder.
> 
> metric groups:
> 
>   Jin Yao:
> 
>   - Scale the metric result.
> 
>   - Support multiple events.
> 
> perf c2c:
> 
>   Jiri Olsa:
> 
>   - Display proper cpu count in nodes column.
> 
> Miscellaneous:
> 
>   Kyle Meyer:
> 
>   - Replace MAX_NR_CPUS with perf_env::nr_cpus_online, i.e. with
>     the number of online CPUs as detected at tool start and/or
>     recorded in the perf.data file.
> 
> libtraceevent:
> 
>   Tzvetomir Stoyanov:
> 
>   - Simplify the tep_print_event_* APIs.
> 
>   - Remove tep_register_trace_clock().
> 
>   - Change users plugin directory.
> 
> Cleanups:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Continue taming the includes hell: remove needless include directives, fix
>     the fallout, rinse, repeat.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (29):
>       perf tools: Remove needless libtraceevent include directives
>       perf header: Move CPUINFO_PROC to the only file where it is used
>       perf tools: Move everything related to sys_perf_event_open() to perf-sys.h
>       perf time-utils: Adopt rdclock() from perf.h
>       perf tools: Remove needless perf.h include directive from headers
>       perf tools: Remove perf.h from source files not needing it
>       perf tools: Remove debug.h from header files not needing it
>       perf debug: Remove needless include directives from debug.h
>       perf env: Remove env.h from other headers where just a fwd decl is needed
>       perf event: Remove needless include directives from event.h
>       perf dso: Adopt DSO related macros from symbol.h
>       perf symbol: Move C++ demangle defines to the only file using it
>       perf symbols: Add missing linux/refcount.h to symbol.h
>       perf symbols: Move symsrc prototypes to a separate header
>       perf dsos: Move the dsos struct and its methods to separate source files
>       perf hist: Remove needless ui/progress.h from hist.h
>       perf tools: Move 'struct events_stats' and prototypes to separate header
>       perf tools: Remove needless sort.h include directives
>       perf probe: No need for symbol.h, symbol_conf is enough
>       perf tools: Remove needless map.h include directives
>       perf tools: Remove needless thread.h include directives
>       perf tools: Remove needless thread_map.h include directives
>       perf tools: Remove needless evlist.h include directives
>       perf tools: Remove needless evlist.h include directives
>       perf auxtrace: Uninline functions that touch perf_session
>       perf symbols: Move mem_info and branch_info out of symbol.h
>       perf build: Ignore intentional differences for the x86 insn decoder
>       objtool: Update sync-check.sh from perf's check-headers.sh
>       objtool: Ignore intentional differences for the x86 insn decoder
> 
> Jin Yao (3):
>       perf pmu: Change convert_scale from static to global
>       perf metricgroup: Scale the metric result
>       perf metricgroup: Support multiple events for metricgroup
> 
> Jiri Olsa (1):
>       perf c2c: Display proper cpu count in nodes column
> 
> Josh Poimboeuf (4):
>       objtool: Move x86 insn decoder to a common location
>       perf: Update .gitignore file
>       perf intel-pt: Remove inat.c from build dependency list
>       perf intel-pt: Use shared x86 insn decoder
> 
> Kyle Meyer (7):
>       perf timechart: Refactor svg_build_topology_map()
>       perf svghelper: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
>       perf stat: Replace MAX_NR_CPUS with cpu__max_cpu()
>       perf session: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
>       perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
>       perf header: Replace MAX_NR_CPUS with cpu__max_cpu()
>       libperf: Warn when exceeding MAX_NR_CPUS in cpumap
> 
> Tzvetomir Stoyanov (3):
>       libtraceevent, perf tools: Changes in tep_print_event_* APIs
>       libtraceevent: Remove tep_register_trace_clock()
>       libtraceevent: Change users plugin directory
> 
>  267 files changed, 1319 insertions(+), 3578 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
