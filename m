From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Wed, 3 Jul 2019 15:56:59 +0200
Message-ID: <20190703135659.GB108545@gmail.com>
References: <20190703032746.21692-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Mariano Pache <npache@redhat.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, this is on top of perf-core-for-mingo-5.3-20190701.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 06c642c0e9fceafd16b1a4c80d44b1c09e282215:
> 
>   perf jevents: Use nonlocal include statements in pmu-events.c (2019-07-01 22:50:42 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190703
> 
> for you to fetch changes up to 15a108af1a18b597bfbd7f7b3c7b4823bfbaf8df:
> 
>   perf script: Allow specifying the files to process guest samples (2019-07-03 00:13:25 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf metrics:
> 
>   Andi Kleen:
> 
>   - Fixes for SkylakeX and CascadeLakeX Intel vendor events.
> 
>   - Avoid extra ':' for --raw metrics.
> 
>   - Don't include duration_time in group.
> 
> perf script:
> 
>   Arnaldo Carvalho de Melo/Jiri Olsa:
> 
>   - Fix processing guest samples.
> 
> perf diff:
> 
>   Jin Yao:
> 
>   - Do diffs by basic blocks.
> 
> objtool:
> 
>   Jiri Olsa:
> 
>   - Fix build by linking against tools/lib/ctype.o sources.
> 
> perf pmu:
> 
>   John Garry:
> 
>   - Support more complex PMU event aliasing.
> 
>   - Add support for Hisi hip08 DDRC, HHA and L3C PMU aliasing.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (4):
>       perf tools: Fix typos / broken sentences
>       perf vendor events intel: Metric fixes for SKX/CLX
>       perf list: Avoid extra : for --raw metrics
>       perf tools metric: Don't include duration_time in group
> 
> Arnaldo Carvalho de Melo (1):
>       perf script: Allow specifying the files to process guest samples
> 
> Jin Yao (7):
>       perf symbol: Create block_info structure
>       perf hists: Add block_info in hist_entry
>       perf diff: Check if all data files with branch stacks
>       perf diff: Use hists to manage basic blocks per symbol
>       perf diff: Link same basic blocks among different data
>       perf diff: Print the basic block cycles diff
>       perf diff: Documentation -c cycles option
> 
> Jiri Olsa (1):
>       objtool: Fix build by linking against tools/lib/ctype.o sources
> 
> John Garry (4):
>       perf pmu: Support more complex PMU event aliasing
>       perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
>       perf jevents: Add support for Hisi hip08 HHA PMU aliasing
>       perf jevents: Add support for Hisi hip08 L3C PMU aliasing
> 
>  tools/objtool/Build                                |   5 +
>  tools/perf/Documentation/perf-diff.txt             |  17 +-
>  tools/perf/Documentation/perf-report.txt           |   2 +-
>  tools/perf/Documentation/tips.txt                  |   2 +-
>  tools/perf/builtin-diff.c                          | 382 ++++++++++++++++++++-
>  tools/perf/builtin-script.c                        |  19 +
>  .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |  44 +++
>  .../arch/arm64/hisilicon/hip08/uncore-hha.json     |  51 +++
>  .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |  37 ++
>  .../arch/x86/cascadelakex/clx-metrics.json         |   4 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  22 +-
>  tools/perf/pmu-events/jevents.c                    |   3 +
>  tools/perf/ui/stdio/hist.c                         |  27 ++
>  tools/perf/util/hist.c                             |  41 ++-
>  tools/perf/util/hist.h                             |   8 +
>  tools/perf/util/metricgroup.c                      |  21 +-
>  tools/perf/util/pmu.c                              |  46 ++-
>  tools/perf/util/sort.h                             |  13 +
>  tools/perf/util/srcline.c                          |   4 +-
>  tools/perf/util/symbol.c                           |  22 ++
>  tools/perf/util/symbol.h                           |  23 ++
>  tools/perf/util/symbol_conf.h                      |   4 +-
>  22 files changed, 753 insertions(+), 44 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json

Pulled, thanks a lot Arnaldo!

	Ingo
