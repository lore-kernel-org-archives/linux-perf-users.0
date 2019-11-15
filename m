From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Fri, 15 Nov 2019 08:35:28 +0100
Message-ID: <20191115073528.GA124116@gmail.com>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 56b2147f34d057b0898c53a3eb2e9e70756ab89f:
> 
>   Merge tag 'perf-core-for-mingo-5.5-20191107' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-11-12 12:06:08 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-core-for-mingo-5.5-20191112
> 
> for you to fetch changes up to e1e9b78d3957a267346a86c8f2c433f6a332af65:
> 
>   perf parse: Use YYABORT to clear stack after failure, plugging leaks (2019-11-12 08:34:16 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf record:
> 
>   Ravi Bangoria:
> 
>   - Provide an option to print perf_event_open args and syscall return value.
>     This was already possible using -v, but then lots of other debug info
>     would be output as well, provide a way to show just the syscall args
>     and return value, e.g.:
> 
>       # perf --debug perf-event-open=1 record
>       perf_event_attr:
>         size                             112
>         { sample_period, sample_freq }   4000
>         sample_type                      IP|TID|TIME|PERIOD
>         read_format                      ID
>         disabled                         1
>         inherit                          1
>       <SNIP>
>         ksymbol                          1
>         bpf_event                        1
>       ------------------------------------------------------------
>       sys_perf_event_open: pid 4308  cpu 0  group_fd -1  flags 0x8 = 4
> 
> core:
> 
> - Remove map->groups, we can get that information in other ways, reduces
>   the size of a key data structure and paves the way to have it shared
>   by multiple threads.
> 
> - Use 'struct map_symbol' in more places, where we already were using a
>   'struct map' + 'struct symbol', this helps passing that usual pair of
>   information across callchain, browser code, etc.
> 
> - Add 'struct map_groups' (where the map_symbol->map is) to 'struct map_symbol',
>   to ease annotation code, for instance, where we call from functions in one map
>   we're browsing to functions in another DSO, mapped in another 'struct map'.
> 
> event parsing:
> 
>   Ian Rogers:
> 
>   - Use YYABORT to clear stack after failure, plugging leaks
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (13):
>       perf map: Use map->dso->kernel + map__kmaps() in map__kmaps()
>       perf symbols: Stop using map->groups, we can use kmaps instead
>       perf map_groups: Pass the object to map_groups__find_ams()
>       perf tools: Add map_groups to 'struct addr_location'
>       perf annotate: Pass a 'map_symbol' in places receiving a pair of 'map' and 'symbol' pointers
>       perf unwind: Use 'struct map_symbol' in 'struct unwind_entry'
>       perf callchain: Use 'struct map_symbol' in 'struct callchain_cursor_node'
>       pref tools: Make 'struct addr_map_symbol' contain 'struct map_symbol'
>       perf symbols: Use kmaps(map)->machine when we know its a kernel map
>       perf tools: Add a 'struct map_groups' pointer to 'struct map_symbol'
>       perf annotate: Stop using map->groups, use map_symbol->mg instead
>       perf map: Combine maps__fixup_overlappings with its only use
>       perf map: Remove ->groups from 'struct map'
> 
> Ian Rogers (1):
>       perf parse: Use YYABORT to clear stack after failure, plugging leaks
> 
> Ravi Bangoria (1):
>       perf tool: Provide an option to print perf_event_open args and return value
> 
>  tools/perf/Documentation/perf.txt                  |   2 +
>  tools/perf/arch/s390/annotate/instructions.c       |   8 +-
>  tools/perf/builtin-annotate.c                      |   6 +-
>  tools/perf/builtin-kmem.c                          |   4 +-
>  tools/perf/builtin-report.c                        |   2 +-
>  tools/perf/builtin-sched.c                         |   2 +-
>  tools/perf/builtin-top.c                           |   6 +-
>  tools/perf/tests/dwarf-unwind.c                    |   2 +-
>  tools/perf/ui/browsers/annotate.c                  |  25 +++--
>  tools/perf/ui/browsers/hists.c                     |  20 ++--
>  tools/perf/ui/gtk/annotate.c                       |  27 +++---
>  tools/perf/util/annotate.c                         | 105 ++++++++++-----------
>  tools/perf/util/annotate.h                         |  22 ++---
>  tools/perf/util/callchain.c                        |  40 ++++----
>  tools/perf/util/callchain.h                        |   5 +-
>  tools/perf/util/db-export.c                        |  16 ++--
>  tools/perf/util/debug.c                            |   2 +
>  tools/perf/util/debug.h                            |   9 ++
>  tools/perf/util/event.c                            |   6 +-
>  tools/perf/util/evsel.c                            |  36 +++----
>  tools/perf/util/evsel_fprintf.c                    |  29 +++---
>  tools/perf/util/hist.c                             |  58 ++++++------
>  tools/perf/util/machine.c                          |  48 ++++++----
>  tools/perf/util/map.c                              |  46 +++------
>  tools/perf/util/map.h                              |   1 -
>  tools/perf/util/map_groups.h                       |   2 +-
>  tools/perf/util/map_symbol.h                       |   5 +-
>  tools/perf/util/mem-events.c                       |   2 +-
>  tools/perf/util/parse-events.y                     |   3 +-
>  tools/perf/util/python.c                           |   1 +
>  .../perf/util/scripting-engines/trace-event-perl.c |  16 ++--
>  .../util/scripting-engines/trace-event-python.c    |  18 ++--
>  tools/perf/util/sort.c                             |  89 ++++++++---------
>  tools/perf/util/symbol-elf.c                       |   2 +-
>  tools/perf/util/symbol.c                           |  16 +---
>  tools/perf/util/symbol.h                           |   2 +-
>  tools/perf/util/unwind-libdw.c                     |   7 +-
>  tools/perf/util/unwind-libunwind-local.c           |   7 +-
>  tools/perf/util/unwind.h                           |   8 +-
>  39 files changed, 347 insertions(+), 358 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
