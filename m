From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/27] perf/core improvements and fixes
Date: Thu, 11 Jan 2018 06:54:09 +0100
Message-ID: <20180111055409.kxce2ivjvem7zgx4@gmail.com>
References: <20180110212844.12441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33311 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeAKFyO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Jan 2018 00:54:14 -0500
Content-Disposition: inline
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9128d3ed9de3882c83b927eb553d5d44c84505f5:
> 
>   perf/x86/msr: Clean up the code (2018-01-06 12:18:40 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.16-20180110
> 
> for you to fetch changes up to 5d64db2966e38bfd99114ecf0b54f97d33023dcd:
> 
>   tools headers: Synchronize kernel <-> tooling headers (2018-01-10 12:46:54 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - The 'perf test bpf' entry hooked a eBPF proggie to the
>   SyS_epoll_wait() kernel function and expected it to be hit when calling
>   the epoll_wait() libc wrapper, which changed recently, in systems such
>   as Fedora 27, with the glibc wrapper calling instead the epoll_pwait()
>   syscall, so switch to epoll_pwait() for both the kernel and libc
>   function, getting it to work both in old and new systems (Arnaldo Carvalho de Melo)
> 
> - Beautify 'gettid' syscall result in 'perf trace', and in doing so
>   noticed that we need to handle namespaces in 'perf trace', will be
>   dealt with in follow up patches where we'll try to figure out if
>   the recent support for namespace in tools/perf/ can be used for this
>   purpose as well. (Arnaldo Carvalho de Melo)
> 
> - Introduce 'perf report --mmaps' and 'perf report --tasks' to show
>   info present in 'perf.data' (Jiri Olsa, Arnaldo Carvalho de Melo)
> 
> - Synchronize kernel <-> tooling headers wrt meltdown/spectre changes
>   (Arnaldo Carvalho de Melo)
> 
> - Fix a wrong offset issue when using /proc/kcore (Jin Yao)
> 
> - Fix bug that prevented annotating symbols in perf.data files
>   generated with 'perf record --branch-any'  (Jin Yao)
> 
> - Add infrastructure to record first and last sample time to the
>   perf.data file header, so that when processing all samples in
>   a 'perf record' session, such as when doing build-id processing,
>   or when specifically requesting that that info be recorded, use
>   that in 'perf report --time', that also got support for percent
>   slices in addition to absolute ones.
> 
>   I.e. now it is possible to ask for the samples in the 10%-20%
>   time slice of a perf.data file (Jin Yao)
> 
> - Enable building with libbabeltrace by default (Jiri Olsa)
> 
> - Display perf_event_attr::namespaces when duping the attributes
>   in verbose mode (Jiri Olsa)
> 
> - Allocate context task_ctx_data for child event (Jiri Olsa)
> 
> - Update comments for PERF_RECORD_ITRACE_START and PERF_RECORD_MISC_* (Jiri Olsa)
> 
> - Add support for showing PERF_RECORD_LOST events in 'perf script' (Jiri Olsa)
> 
> - Add 'perf report --stats' option to display quick statistics about
>   metadata events (PERF_RECORD_*) i.e. what we get at the end of 'perf
>   report -D' (Jiri Olsa)
> 
> - Fix compile error with libunwind x86 (Wang Nan)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (6):
>       perf test bpf: Improve message about expected samples
>       perf test bpf: Use designated struct field initializers
>       perf test bpf: Hook on epoll_pwait()
>       perf trace: Beautify 'gettid' syscall result
>       perf report: Introduce --mmaps
>       tools headers: Synchronize kernel <-> tooling headers
> 
> Jin Yao (8):
>       perf report: Fix a wrong offset issue when using /proc/kcore
>       perf report: Fix a no annotate browser displayed issue
>       perf header: Add infrastructure to record first and last sample time
>       perf record: Record the first and last sample time in the header
>       perf tools: Create function to parse time percent
>       perf tools: Create function to perform multiple time range checking
>       perf report: Support time percent and multiple time ranges
>       perf script: Support time percent and multiple time ranges
> 
> Jiri Olsa (12):
>       perf tools: Enable LIBBABELTRACE by default
>       perf tools: Display perf_event_attr::namespaces debug info
>       perf: Allocate context task_ctx_data for child event
>       perf: Add sample_id to PERF_RECORD_ITRACE_START event comment
>       perf: Make perf_callchain function static
>       perf: Return empty callchain instead of NULL
>       perf: Update PERF_RECORD_MISC_* comment for perf_event_header::misc bit 13
>       perf script: Add support to display sample misc field
>       perf script: Add support to display lost events
>       perf tools: Make the tool's warning messages optional
>       perf report: Add --stats option to display quick data statistics
>       perf report: Add --tasks option to display monitored tasks
> 
> Wang Nan (1):
>       perf tools: Fix compile error with libunwind x86
> 
>  include/uapi/linux/perf_event.h                    |  10 +-
>  kernel/events/callchain.c                          |  15 --
>  kernel/events/core.c                               |  54 +++--
>  kernel/events/internal.h                           |   4 -
>  tools/arch/x86/include/asm/cpufeatures.h           |   4 +-
>  tools/arch/x86/include/asm/disabled-features.h     |   8 +-
>  tools/include/uapi/linux/perf_event.h              |  10 +-
>  tools/perf/Documentation/perf-record.txt           |   3 +
>  tools/perf/Documentation/perf-report.txt           |  37 ++-
>  tools/perf/Documentation/perf-script.txt           |  39 +++-
>  tools/perf/Documentation/perf.data-file-format.txt |   4 +
>  tools/perf/Makefile.config                         |   2 +-
>  tools/perf/Makefile.perf                           |   2 +-
>  tools/perf/arch/x86/util/unwind-libunwind.c        |   2 +-
>  tools/perf/builtin-record.c                        |  18 +-
>  tools/perf/builtin-report.c                        | 249 ++++++++++++++++++++-
>  tools/perf/builtin-script.c                        | 136 +++++++++--
>  tools/perf/builtin-trace.c                         |   1 +
>  tools/perf/tests/bpf-script-example.c              |   4 +-
>  tools/perf/tests/bpf.c                             |  65 +++---
>  tools/perf/util/annotate.c                         |   3 +-
>  tools/perf/util/event.c                            |   8 +
>  tools/perf/util/event.h                            |   1 +
>  tools/perf/util/evlist.h                           |   2 +
>  tools/perf/util/evsel.c                            |   2 +
>  tools/perf/util/header.c                           |  60 +++++
>  tools/perf/util/header.h                           |   1 +
>  tools/perf/util/machine.c                          |   2 +-
>  tools/perf/util/map.c                              |   2 +-
>  tools/perf/util/session.c                          |   6 +-
>  tools/perf/util/sort.c                             |  16 +-
>  tools/perf/util/srcline.c                          |   9 +-
>  tools/perf/util/srcline.h                          |   5 +-
>  tools/perf/util/time-utils.c                       | 233 ++++++++++++++++++-
>  tools/perf/util/time-utils.h                       |   6 +
>  tools/perf/util/tool.h                             |   1 +
>  36 files changed, 884 insertions(+), 140 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
