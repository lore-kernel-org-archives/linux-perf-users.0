From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Thu, 19 Mar 2020 15:03:38 +0100
Message-ID: <20200319140338.GB52834@gmail.com>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, disconnect3d <dominik.b.czarnota@gmail.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Michael Petlan <mpetlan@redhat.com>, Mike Leach <mike.leach@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit f787feff69c466dfc6f261c9632627e383b49187:
> 
>   perf block-info: Support color ops to print block percents in color (2020-03-09 21:43:25 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.7-20200317
> 
> for you to fetch changes up to 59a08b4b3b1a9374adacd13cd7544c03e5582e0e:
> 
>   perf expr: Fix copy/paste mistake (2020-03-17 18:01:40 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Fix binding of AIO user space buffers to nodes
> 
> maps:
> 
>   Dominik b. Czarnota:
> 
>   - Fix off by one in strncpy() size argument.
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use strstarts() to look for Android libraries.
> 
>   Ian Rogers:
> 
>   - Give synthetic mmap events an inode generation.
> 
> man pages:
> 
>   Ian Rogers:
> 
>   - Set man page date to last git commit.
> 
> perf test:
> 
>   Ian Rogers:
> 
>   - Print if shell directory isn't present.
> 
> perf report:
> 
>   Jin Yao:
> 
>   - Fix no branch type statistics report issue.
> 
> perf expr:
> 
>   Jiri Olsa:
> 
>   - Fix copy/paste mistake
> 
> vendor events:
> 
>   Kan Liang:
> 
>   - Support metric constraints.
> 
> vendor events intel:
> 
>   Kan Liang:
> 
>   - Add NO_NMI_WATCHDOG metric constraint.
> 
> vendor events s390:
> 
>   Thomas Richter:
> 
>  - Add new deflate counters for IBM z15.
> 
> ARM cs-etm:
> 
>   Leo Yan:
> 
>   - Last branch improvements.
> 
> intel-pt:
> 
>   Adrian Hunter:
> 
>   - Update intel-pt.txt file with new location of the documentation.
> 
>   - Add Intel PT man page references.
> 
>   - Rename intel-pt.txt and put it in man page format.
> 
> perl scripting:
> 
>   Michael Petlan:
> 
>  - Add common_callchain to fix argument order.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (3):
>       perf intel-pt: Rename intel-pt.txt and put it in man page format
>       perf intel-pt: Add Intel PT man page references
>       perf intel-pt: Update intel-pt.txt file with new location of the documentation
> 
> Alexey Budankov (1):
>       perf record: Fix binding of AIO user space buffers to nodes
> 
> Arnaldo Carvalho de Melo (1):
>       perf map: Use strstarts() to look for Android libraries
> 
> Ian Rogers (3):
>       perf doc: Set man page date to last git commit
>       perf test: Print if shell directory isn't present
>       perf tools: Give synthetic mmap events an inode generation
> 
> Jin Yao (1):
>       perf report: Fix no branch type statistics report issue
> 
> Jiri Olsa (1):
>       perf expr: Fix copy/paste mistake
> 
> Kan Liang (5):
>       perf jevents: Support metric constraint
>       perf metricgroup: Factor out metricgroup__add_metric_weak_group()
>       perf util: Factor out sysctl__nmi_watchdog_enabled()
>       perf metricgroup: Support metric constraint
>       perf vendor events intel: Add NO_NMI_WATCHDOG metric constraint
> 
> Leo Yan (5):
>       perf cs-etm: Swap packets for instruction samples
>       perf cs-etm: Continuously record last branch
>       perf cs-etm: Correct synthesizing instruction samples
>       perf cs-etm: Optimize copying last branches
>       perf cs-etm: Fix unsigned variable comparison to zero
> 
> Michael Petlan (1):
>       perf scripting perl: Add common_callchain to fix argument order
> 
> Thomas Richter (1):
>       perf vendor events s390: Add new deflate counters for IBM z15
> 
> disconnect3d (1):
>       perf map: Fix off by one in strncpy() size argument
> 
>  tools/perf/Documentation/Makefile                  |    5 +-
>  tools/perf/Documentation/intel-pt.txt              |  992 +------------------
>  tools/perf/Documentation/perf-inject.txt           |    3 +-
>  tools/perf/Documentation/perf-intel-pt.txt         | 1007 ++++++++++++++++++++
>  tools/perf/Documentation/perf-record.txt           |    2 +-
>  tools/perf/Documentation/perf-report.txt           |    3 +-
>  tools/perf/Documentation/perf-script.txt           |    2 +-
>  tools/perf/builtin-report.c                        |    9 +-
>  .../perf/pmu-events/arch/s390/cf_z15/crypto6.json  |    8 +-
>  .../perf/pmu-events/arch/s390/cf_z15/extended.json |   30 +-
>  .../arch/x86/cascadelakex/clx-metrics.json         |    3 +-
>  .../pmu-events/arch/x86/skylake/skl-metrics.json   |    3 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |    3 +-
>  tools/perf/pmu-events/jevents.c                    |   19 +-
>  tools/perf/pmu-events/jevents.h                    |    2 +-
>  tools/perf/pmu-events/pmu-events.h                 |    1 +
>  tools/perf/scripts/perl/check-perf-trace.pl        |    6 +-
>  tools/perf/scripts/perl/failed-syscalls.pl         |    2 +-
>  tools/perf/scripts/perl/rw-by-file.pl              |    6 +-
>  tools/perf/scripts/perl/rw-by-pid.pl               |   10 +-
>  tools/perf/scripts/perl/rwtop.pl                   |   10 +-
>  tools/perf/scripts/perl/wakeup-latency.pl          |    6 +-
>  tools/perf/tests/builtin-test.c                    |    5 +-
>  tools/perf/util/cs-etm.c                           |  157 ++-
>  tools/perf/util/expr.l                             |    4 +-
>  tools/perf/util/map.c                              |    8 +-
>  tools/perf/util/metricgroup.c                      |  109 ++-
>  tools/perf/util/mmap.c                             |   21 +-
>  tools/perf/util/stat-display.c                     |    6 +-
>  tools/perf/util/synthetic-events.c                 |    1 +
>  tools/perf/util/util.c                             |   18 +
>  tools/perf/util/util.h                             |    2 +
>  32 files changed, 1340 insertions(+), 1123 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-intel-pt.txt

Pulled this and the previous perf/core pull request into tip:perf/core, thanks Arnaldo!

(You might want to double check my conflict resolution with perf/urgent, 
to tools/perf/util/map.c.)

Thanks,

	Ingo
