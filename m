From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/20] perf/core improvements and fixes
Date: Fri, 24 Mar 2017 19:39:46 +0100
Message-ID: <20170324183946.GA939@gmail.com>
References: <20170324145731.29350-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36157 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdCXSjw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2017 14:39:52 -0400
Content-Disposition: inline
In-Reply-To: <20170324145731.29350-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexis Berlemont <alexis.berlemont@gmail.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, John Shortt <jshortt@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Taeung Song <treeze.taeung@gmail>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 267dd0a07eefbb37264fcfad984fffc8856898ad:
> 
>   Merge tag 'perf-core-for-mingo-4.12-20170320' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-03-21 07:41:29 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.12-20170324
> 
> for you to fetch changes up to bf874fcf9f2fed58510dc83abcee388cee2b427e:
> 
>   perf list: Move extra details printing to new option (2017-03-23 11:42:31 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> - Allow suppressing 'uncore_' when specifying PMU events (Andi Kleen)
> 
> - Collapse identically named PMU events in 'perf stat', allow
>   not merging it via --no-merge (Andi Kleen)
> 
> Fixes:
> 
> - Use more precise 'grep -v' to suppress unwanted 'objdump -dS'
>   disassembly output to not ditch line:number lines needed by
>   'perf annotate --print-lines' logic (Taeung Song)
> 
> Infrastructure:
> 
> - SDT (Statically Defined Tracing)/uprobes_events arguments improvements
>   (Alexis Berlemont, Ravi Bangoria)
> 
> - Improvements for the handling of JSON described vendor events,
>   including having an expression parser to calculate metrics
>   from multiple vendor events (Andi Kleen)
> 
> - Update Intel JSON vendor event files (Andi Kleen)
> 
> - Restore error reporting in 'perf probe -d' when none of the events
>   requested to be deleted exist. (Kefeng Wang)
> 
> - Bump MAX_CMDLEN in 'perf probe' to match what the kernel accepts
>   (Ravi Bangoria)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexis Berlemont (2):
>       perf sdt: Add scanning of sdt probes arguments
>       perf probe: Add sdt probes arguments into the uprobe cmd string
> 
> Andi Kleen (13):
>       perf stat: Factor out callback for collecting event values
>       perf stat: Collapse identically named events
>       perf stat: Handle partially bad results with merging
>       perf tools: Factor out PMU matching in parser
>       perf pmu: Expand PMU events by prefix match
>       perf pmu: Special case uncore_ prefix
>       perf tools: Add a simple expression parser for JSON
>       perf vendor events intel: Update Intel uncore JSON event files
>       perf pmu: Support MetricExpr header in JSON event list
>       perf stat: Output JSON MetricExpr metric
>       perf list: Support printing MetricExpr with --debug
>       perf pmu: Add support for MetricName JSON attribute
>       perf list: Move extra details printing to new option
> 
> Arnaldo Carvalho de Melo (1):
>       perf annotate: Add comment clarifying how the source code line is parsed
> 
> Kefeng Wang (1):
>       perf probe: Return errno when not hitting any event
> 
> Ravi Bangoria (2):
>       perf probe: Change MAX_CMDLEN
>       perf sdt x86: Add renaming logic for rNN and other registers
> 
> Taeung Song (1):
>       perf annotate: More exactly grep -v of the objdump command
> 
>  tools/perf/Documentation/perf-list.txt             |   4 +
>  tools/perf/Documentation/perf-stat.txt             |   3 +
>  tools/perf/arch/x86/util/perf_regs.c               | 103 +++++++++++
>  tools/perf/builtin-list.c                          |  14 +-
>  tools/perf/builtin-probe.c                         |   6 +-
>  tools/perf/builtin-stat.c                          | 146 ++++++++++++---
>  .../arch/x86/broadwellde/uncore-cache.json         |  28 +--
>  .../arch/x86/broadwellde/uncore-memory.json        |  26 ++-
>  .../arch/x86/broadwellde/uncore-power.json         |  26 ++-
>  .../arch/x86/broadwellx/uncore-cache.json          |  28 +--
>  .../arch/x86/broadwellx/uncore-interconnect.json   |   6 +-
>  .../arch/x86/broadwellx/uncore-memory.json         |  21 ++-
>  .../arch/x86/broadwellx/uncore-power.json          |  26 ++-
>  .../pmu-events/arch/x86/haswellx/uncore-cache.json |  28 +--
>  .../arch/x86/haswellx/uncore-interconnect.json     |   6 +-
>  .../arch/x86/haswellx/uncore-memory.json           |  21 ++-
>  .../pmu-events/arch/x86/haswellx/uncore-power.json |  26 ++-
>  .../pmu-events/arch/x86/ivytown/uncore-cache.json  |  22 +--
>  .../arch/x86/ivytown/uncore-interconnect.json      |  12 +-
>  .../pmu-events/arch/x86/ivytown/uncore-memory.json |  19 +-
>  .../pmu-events/arch/x86/ivytown/uncore-power.json  |  53 ++++--
>  .../pmu-events/arch/x86/jaketown/uncore-cache.json |  13 +-
>  .../arch/x86/jaketown/uncore-interconnect.json     |  12 +-
>  .../arch/x86/jaketown/uncore-memory.json           |  21 ++-
>  .../pmu-events/arch/x86/jaketown/uncore-power.json |  53 ++++--
>  tools/perf/pmu-events/jevents.c                    |  26 ++-
>  tools/perf/pmu-events/jevents.h                    |   3 +-
>  tools/perf/pmu-events/pmu-events.h                 |   2 +
>  tools/perf/tests/Build                             |   1 +
>  tools/perf/tests/builtin-test.c                    |   4 +
>  tools/perf/tests/expr.c                            |  56 ++++++
>  tools/perf/tests/tests.h                           |   1 +
>  tools/perf/util/Build                              |   6 +
>  tools/perf/util/annotate.c                         |   8 +-
>  tools/perf/util/evsel.c                            |   4 +
>  tools/perf/util/evsel.h                            |   5 +
>  tools/perf/util/expr.h                             |  25 +++
>  tools/perf/util/expr.y                             | 173 ++++++++++++++++++
>  tools/perf/util/parse-events.c                     |  78 +++++++-
>  tools/perf/util/parse-events.h                     |  10 +-
>  tools/perf/util/parse-events.y                     |  73 ++++----
>  tools/perf/util/perf_regs.c                        |   6 +
>  tools/perf/util/perf_regs.h                        |   6 +
>  tools/perf/util/pmu.c                              |  32 +++-
>  tools/perf/util/pmu.h                              |   6 +-
>  tools/perf/util/probe-event.c                      |   1 -
>  tools/perf/util/probe-file.c                       | 173 +++++++++++++++++-
>  tools/perf/util/stat-shadow.c                      | 197 +++++++++++++++++++++
>  tools/perf/util/stat.h                             |   2 +
>  tools/perf/util/symbol-elf.c                       |  25 ++-
>  tools/perf/util/symbol.h                           |   1 +
>  51 files changed, 1370 insertions(+), 277 deletions(-)
>  create mode 100644 tools/perf/tests/expr.c
>  create mode 100644 tools/perf/util/expr.h
>  create mode 100644 tools/perf/util/expr.y

Pulled, thanks a lot Arnaldo!

	Ingo
