From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Sun, 22 Sep 2019 12:46:28 +0200
Message-ID: <20190922104628.GA122003@gmail.com>
References: <20190921124240.15741-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>, Roy Ben Shlomo <royb@sentinelone.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 351a1f5c8afa13ea5cfcdae543f6596ef8ebdbd9:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190920-2' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-09-20 18:16:42 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.4-20190921
> 
> for you to fetch changes up to 9f014e3a66bc936412b6614304a4e6c70c70230e:
> 
>   perf/core: Fix several typos in comments (2019-09-20 16:05:20 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes
> 
> perf tests:
> 
>   Jiri Olsa:
> 
>   - Fix 'make -C tools/perf build-test' static build entry.
> 
> perf record:
> 
>   Jiri Olsa:
> 
>   - Fix segfault in cpu_cache_level__read() when reading CPU topology.
> 
> session:
> 
>   Mamatha Inamdar:
> 
>   - Properly propagate error when reading a perf.data file, it may
>     not exist or the user may not have permissions, etc.
> 
> perf probe:
> 
>   Masami Hiramatsu:
> 
>   - Skip same probe address for a given line.
> 
>   - Clear tev->nargs in clear_probe_trace_event(), fixing segfault.
> 
> tools headers UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync headers, among them prctl.h, that introduces two new options
>     that are now supported in the 'perf trace' prctl syscall args
>     beautifiers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       tools headers uapi: Sync prctl.h with the kernel sources
>       tools uapi asm-generic: Sync unistd.h with the kernel sources
>       tools arch x86 uapi: Synch asm/unistd.h with the kernel sources
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
> 
> Jiri Olsa (2):
>       perf tests: Fix static build test
>       perf tools: Fix segfault in cpu_cache_level__read()
> 
> Mamatha Inamdar (1):
>       perf session: Return error code for perf_session__new() function on failure
> 
> Masami Hiramatsu (2):
>       perf probe: Skip same probe address for a given line
>       perf probe: Fix to clear tev->nargs in clear_probe_trace_event()
> 
> Roy Ben Shlomo (1):
>       perf/core: Fix several typos in comments
> 
>  kernel/events/core.c                     |  6 +++---
>  tools/arch/x86/include/asm/cpufeatures.h |  3 +++
>  tools/arch/x86/include/uapi/asm/unistd.h |  2 +-
>  tools/include/uapi/asm-generic/unistd.h  |  2 +-
>  tools/include/uapi/linux/prctl.h         |  7 ++++++-
>  tools/perf/builtin-annotate.c            |  5 +++--
>  tools/perf/builtin-buildid-cache.c       |  5 +++--
>  tools/perf/builtin-buildid-list.c        |  5 +++--
>  tools/perf/builtin-c2c.c                 |  6 ++++--
>  tools/perf/builtin-diff.c                |  9 +++++----
>  tools/perf/builtin-evlist.c              |  5 +++--
>  tools/perf/builtin-inject.c              |  5 +++--
>  tools/perf/builtin-kmem.c                |  5 +++--
>  tools/perf/builtin-kvm.c                 |  9 +++++----
>  tools/perf/builtin-lock.c                |  5 +++--
>  tools/perf/builtin-mem.c                 |  5 +++--
>  tools/perf/builtin-record.c              |  5 +++--
>  tools/perf/builtin-report.c              |  4 ++--
>  tools/perf/builtin-sched.c               | 11 ++++++-----
>  tools/perf/builtin-script.c              |  9 +++++----
>  tools/perf/builtin-stat.c                | 11 ++++++-----
>  tools/perf/builtin-timechart.c           |  5 +++--
>  tools/perf/builtin-top.c                 |  5 +++--
>  tools/perf/builtin-trace.c               |  4 ++--
>  tools/perf/tests/make                    |  2 +-
>  tools/perf/tests/topology.c              |  5 +++--
>  tools/perf/util/data-convert-bt.c        |  5 ++++-
>  tools/perf/util/header.c                 |  2 +-
>  tools/perf/util/probe-event.c            |  1 +
>  tools/perf/util/probe-finder.c           | 19 +++++++++++++++++++
>  tools/perf/util/session.c                | 15 +++++++++++----
>  31 files changed, 122 insertions(+), 65 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
