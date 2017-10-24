From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/24] perf/core improvements and fixes
Date: Tue, 24 Oct 2017 11:13:39 +0200
Message-ID: <20171024091338.wk5ogkkmzntnedsp@gmail.com>
References: <20171023234736.5335-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46335 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbdJXJNn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Oct 2017 05:13:43 -0400
Content-Disposition: inline
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, hopefully the next batch will have a
> few other interesting patchkits, from Jin Yao, Kan Liang and Milian
> Wolff.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 8776fe75dc0e263ed2056ea9896c2267599dc447:
> 
>   lkdtm, kprobes: Convert from jprobes to kprobes (2017-10-23 13:52:45 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171023
> 
> for you to fetch changes up to 65db92e0965ab56e8031d5c804f26d5be0e47047:
> 
>   perf vendor events: Add Goldmont Plus V1 event file (2017-10-23 16:30:54 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Update vendor events JSON metrics for Intel's Broadwell, Broadwell
>   Server, Haswell, Haswell Server, IvyBridge, IvyTown, JakeTown, Sandy
>   Bridge, Skylake and SkyLake Server (Andi Kleen)
> 
> - Add vendor event file for Intel's Goldmont Plus V1 (Kan Liang)
> 
> - Move perf_mmap methods from 'perf record' and evlist.c to a separate
>   mmap.[ch] pair, to better separate things and pave the way for further
>   work on multithreading tools (Arnaldo Carvalho de Melo)
> 
> - Do not check ABI headers in a detached tarball build, as it the kernel
>   headers from where we copied tools/include/ are by definition not
>   available (Arnaldo Carvalho de Melo)
> 
> - Make 'perf script' use fprintf() like printing, i.e. receiving a FILE
>   pointer so that it gets consistent with other tools/ code and allows
>   for printing to per-event files (Arnaldo Carvalho de Melo)
> 
> - Error handling fixes (resource release on exit) for 'perf script'
>   and 'perf kmem' (Christophe JAILLET)
> 
> - Make some 'perf event attr' tests optional on virtual machines, where
>   tested counters are not available (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (12):
>       perf vendor events: Update JSON metrics for Broadwell
>       perf vendor events: Update JSON metrics for Broadwell Server
>       perf vendor events: Update JSON metrics for Haswell
>       perf vendor events: Update JSON metrics for Haswell Server
>       perf vendor events: Update JSON metrics for IvyBridge
>       perf vendor events: Update JSON metrics for IvyTown
>       perf vendor events: Update JSON metrics for JakeTown
>       perf vendor events: Update JSON metrics for Sandy Bridge
>       perf vendor events: Update JSON metrics for Skylake
>       perf vendor events: Update JSON metrics for Skylake Server
>       perf list: Fix group description in the man page
>       perf vendor events: Fix incorrect cmask syntax for some Intel metrics
> 
> Arnaldo Carvalho de Melo (7):
>       perf mmap: Move perf_mmap and methods to separate mmap.[ch] files
>       perf record: Make record__mmap_read generic
>       perf mmap: Adopt push method from builtin-record.c
>       perf tools: Do not check ABI headers in a detached tarball build
>       perf tools: Introduce binary__fprintf()
>       perf script: Use fprintf like printing uniformly
>       perf namespaces: Add more appropriate set of headers
> 
> Christophe JAILLET (2):
>       perf script: Fix error handling path
>       perf kmem: Perform some cleanup if '--time' is given an invalid value
> 
> Jiri Olsa (2):
>       perf tests attr: Make hw events optional
>       perf annotate: Remove arch::cpuid_parse callback
> 
> Kan Liang (1):
>       perf vendor events: Add Goldmont Plus V1 event file
> 
>  tools/perf/Documentation/perf-list.txt             |    2 +-
>  tools/perf/arch/arm/annotate/instructions.c        |    3 +-
>  tools/perf/arch/arm64/annotate/instructions.c      |    3 +-
>  tools/perf/arch/powerpc/annotate/instructions.c    |    4 +-
>  tools/perf/arch/s390/annotate/instructions.c       |    4 +-
>  tools/perf/arch/x86/annotate/instructions.c        |   14 +
>  tools/perf/builtin-kmem.c                          |    3 +-
>  tools/perf/builtin-record.c                        |  104 +-
>  tools/perf/builtin-script.c                        |  527 +++----
>  tools/perf/builtin-trace.c                         |   14 +-
>  tools/perf/check-headers.sh                        |    5 +
>  .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   18 +-
>  .../arch/x86/broadwellx/bdx-metrics.json           |   18 +-
>  .../pmu-events/arch/x86/goldmontplus/cache.json    | 1453 ++++++++++++++++++++
>  .../pmu-events/arch/x86/goldmontplus/frontend.json |   62 +
>  .../pmu-events/arch/x86/goldmontplus/memory.json   |   38 +
>  .../pmu-events/arch/x86/goldmontplus/other.json    |   98 ++
>  .../pmu-events/arch/x86/goldmontplus/pipeline.json |  544 ++++++++
>  .../arch/x86/goldmontplus/virtual-memory.json      |  218 +++
>  .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   16 +-
>  .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   16 +-
>  .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   18 +-
>  .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   18 +-
>  .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   12 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv         |    1 +
>  .../arch/x86/sandybridge/snb-metrics.json          |   12 +-
>  .../pmu-events/arch/x86/skylake/skl-metrics.json   |   20 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   42 +-
>  tools/perf/tests/attr/test-stat-C0                 |    1 +
>  tools/perf/tests/attr/test-stat-basic              |    1 +
>  tools/perf/tests/attr/test-stat-default            |    4 +
>  tools/perf/tests/attr/test-stat-detailed-1         |    8 +
>  tools/perf/tests/attr/test-stat-detailed-2         |   13 +
>  tools/perf/tests/attr/test-stat-detailed-3         |   13 +
>  tools/perf/tests/attr/test-stat-no-inherit         |    1 +
>  tools/perf/util/Build                              |    1 +
>  tools/perf/util/annotate.c                         |   10 +-
>  tools/perf/util/debug.c                            |   31 +-
>  tools/perf/util/evlist.c                           |  248 ----
>  tools/perf/util/evlist.h                           |   76 +-
>  tools/perf/util/mmap.c                             |  352 +++++
>  tools/perf/util/mmap.h                             |   97 ++
>  tools/perf/util/namespaces.h                       |    5 +-
>  tools/perf/util/print_binary.c                     |   30 +-
>  tools/perf/util/print_binary.h                     |   18 +-
>  tools/perf/util/python-ext-sources                 |    1 +
>  46 files changed, 3367 insertions(+), 830 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
>  create mode 100644 tools/perf/util/mmap.c
>  create mode 100644 tools/perf/util/mmap.h

Pulled, thanks a lot Arnaldo!

	Ingo
