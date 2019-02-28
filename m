From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Thu, 28 Feb 2019 08:31:15 +0100
Message-ID: <20190228073115.GB59852@gmail.com>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Mansour Alharthi <malharthi9@gatech.edu>, Mathieu Poirier <mathieu.poirier@linaro.org>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Tony Jones <tonyj@suse.de>, Wei Li <liwei391@huawei.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, this is on top of my previous pull
> request, perf-core-for-mingo-5.1-20190220.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b4409ae112caa6315f6ee678e953b9fc93e6919c:
> 
>   perf tools: Make rm_rf() remove single file (2019-02-20 17:09:28 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190225
> 
> for you to fetch changes up to de667cce7f4f96b6e22da8fd9c065b961f355080:
> 
>   perf script python: Add Python3 support to syscall-counts-by-pid.py (2019-02-25 17:17:13 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf annotate:
> 
>   Wei Li:
> 
>   - Fix getting source line failure.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Handle missing fields with -F +...
> 
> perf data:
> 
>   Jiri Olsa:
> 
>   - Prep work to support per-cpu files in a directory.
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Improve thread_stack__no_call_return()
> 
>   - Hide x86 retpolines in thread stacks.
> 
>   - exported SQL viewer refactorings, new 'top calls' report.
> 
>   Alexander Shishkin:
> 
>   - Copy parent's address filter offsets on clone.
> 
>   - Fix address filters for vmas with non-zero offset. Applies to
>     ARM's CoreSight as well.
> 
> python scripts:
> 
>   Tony Jones:
> 
>   - Python3 support for several 'perf script' python scripts.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (13):
>       perf thread-stack: Improve thread_stack__no_call_return()
>       perf thread-stack: Hide x86 retpolines
>       perf scripts python: exported-sql-viewer.py: Fix missing shebang
>       perf scripts python: exported-sql-viewer.py: Remove leftover debugging prints
>       perf scripts python: exported-sql-viewer.py: Hide Call Graph option if no calls table
>       perf scripts python: exported-sql-viewer.py: Move column headers
>       perf scripts python: exported-sql-viewer.py: Factor out ReportDialogBase
>       perf scripts python: exported-sql-viewer.py: Factor out ReportVars
>       perf scripts python: exported-sql-viewer.py: Move report name into ReportVars
>       perf scripts python: exported-sql-viewer.py: Create new dialog data item classes
>       perf scripts python: exported-sql-viewer.py: Remove SQLTableDialogDataItem
>       perf scripts python: exported-sql-viewer.py: Remove no selection error
>       perf scripts python: exported-sql-viewer.py: Add top calls report
> 
> Alexander Shishkin (2):
>       perf: Copy parent's address filter offsets on clone
>       perf, pt, coresight: Fix address filters for vmas with non-zero offset
> 
> Andi Kleen (2):
>       perf script: Handle missing fields with -F +..
>       perf tools: Add perf_exe() helper to find perf binary
> 
> Jiri Olsa (9):
>       perf data: Move size to struct perf_data_file
>       perf data: Add global path holder
>       perf tools: Add depth checking to rm_rf
>       perf tools: Add pattern name checking to rm_rf
>       perf tools: Add rm_rf_perf_data function
>       perf data: Make check_backup work over directories
>       perf data: Fail check_backup in case of error
>       perf data: Add perf_data__(create_dir|close_dir) functions
>       perf data: Add perf_data__open_dir_data function
> 
> Tony Jones (10):
>       perf script python: Add Python3 support to netdev-times.py
>       perf script python: Add Python3 support to failed-syscalls-by-pid.py
>       perf script python: Add Python3 support to mem-phys-addr.py
>       perf script python: Add Python3 support to net_dropmonitor.py
>       perf script python: Add Python3 support to powerpc-hcalls.py
>       perf script python: Add Python3 support to sctop.py
>       perf script python: Add Python3 support to stackcollapse.py
>       perf script python: Add Python3 support to stat-cpi.py
>       perf script python: Add Python3 support to syscall-counts.py
>       perf script python: Add Python3 support to syscall-counts-by-pid.py
> 
> Wei Li (1):
>       perf annotate: Fix getting source line failure
> 
>  arch/x86/events/intel/pt.c                         |   9 +-
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |   7 +-
>  include/linux/perf_event.h                         |   7 +-
>  kernel/events/core.c                               |  90 ++--
>  tools/perf/builtin-annotate.c                      |   4 +-
>  tools/perf/builtin-buildid-cache.c                 |   4 +-
>  tools/perf/builtin-buildid-list.c                  |   8 +-
>  tools/perf/builtin-c2c.c                           |   4 +-
>  tools/perf/builtin-diff.c                          |  12 +-
>  tools/perf/builtin-evlist.c                        |   4 +-
>  tools/perf/builtin-inject.c                        |  10 +-
>  tools/perf/builtin-kmem.c                          |   2 +-
>  tools/perf/builtin-kvm.c                           |   8 +-
>  tools/perf/builtin-lock.c                          |   8 +-
>  tools/perf/builtin-mem.c                           |   8 +-
>  tools/perf/builtin-record.c                        |  11 +-
>  tools/perf/builtin-report.c                        |   6 +-
>  tools/perf/builtin-sched.c                         |  16 +-
>  tools/perf/builtin-script.c                        |  22 +-
>  tools/perf/builtin-stat.c                          |   6 +-
>  tools/perf/builtin-timechart.c                     |   8 +-
>  tools/perf/builtin-trace.c                         |   8 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   | 510 ++++++++++++++-------
>  .../perf/scripts/python/failed-syscalls-by-pid.py  |  21 +-
>  tools/perf/scripts/python/mem-phys-addr.py         |  24 +-
>  tools/perf/scripts/python/net_dropmonitor.py       |  10 +-
>  tools/perf/scripts/python/netdev-times.py          |  82 ++--
>  tools/perf/scripts/python/powerpc-hcalls.py        |  18 +-
>  tools/perf/scripts/python/sctop.py                 |  24 +-
>  tools/perf/scripts/python/stackcollapse.py         |   7 +-
>  tools/perf/scripts/python/stat-cpi.py              |  10 +-
>  tools/perf/scripts/python/syscall-counts-by-pid.py |  22 +-
>  tools/perf/scripts/python/syscall-counts.py        |  18 +-
>  tools/perf/util/annotate.c                         |   4 +-
>  tools/perf/util/data-convert-bt.c                  |   4 +-
>  tools/perf/util/data.c                             | 175 ++++++-
>  tools/perf/util/data.h                             |  16 +-
>  tools/perf/util/header.c                           |  12 +-
>  tools/perf/util/thread-stack.c                     | 161 ++++++-
>  tools/perf/util/util.c                             |  65 ++-
>  tools/perf/util/util.h                             |   3 +
>  41 files changed, 1019 insertions(+), 429 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
