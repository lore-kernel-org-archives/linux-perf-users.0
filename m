From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/13] perf/core improvements and fixes
Date: Tue, 25 Sep 2018 11:21:00 +0200
Message-ID: <20180925092100.GA20981@gmail.com>
References: <20180919142537.29985-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Ding Xiang <dingxiang@cmss.chinamobile.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Jeremie Galarneau <jeremie.galarneau@efficios.com>, Jiri Olsa <jolsa@redhat.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kim Phillips <kim.phillips@arm.com>, Markus T Metzger <markus.t.metzger@intel.com>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 7f16023bfcc4b1f2bbccf86219dc97473db6e0d6:
> 
>   Merge remote-tracking branch 'acme/perf/urgent' into perf/core (2018-09-18 17:20:41 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.20-20180919
> 
> for you to fetch changes up to 24ef0fd0a1f389b156e6ef0edd71072728831bd9:
> 
>   perf python: Use -Wno-redundant-decls to build with PYTHON=python3 (2018-09-19 10:25:13 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf test:
> 
> - Add watchpoint entry (Ravi Bangoria)
> 
> Build fixes:
> 
> - Initialize perf_data_file fd field to fix building the CTF (trace format)
>   converter with with gcc 4.8.4 on Ubuntu 14.04 (Jérémie Galarneau)
> 
> - Use -Wno-redundant-decls to build with PYTHON=python3 to
>   build the python binding, fixing the build in systems such
>   as Clear Linux (Arnaldo Carvalho de Melo)
> 
> Hardware tracing:
> 
> - Suppress AUX/OVERWRITE records (Alexander Shishkin)
> 
> Infrastructure:
> 
> - Adopt PTR_ERR_OR_ZERO from the kernel and use it in
>   the bpf-loader instead of open coded equivalent (Ding Xiang)
> 
> - Improve the event ordering code to make it clear and fix
>   a bug related to freeing of events when using pipe mode
>   from 'record' to 'inject' (Jiri Olsa)
> 
> - Some prep work to facilitate per-cpu threads to write
>   record data to per-cpu files (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexander Shishkin (1):
>       perf: Suppress AUX/OVERWRITE records
> 
> Arnaldo Carvalho de Melo (1):
>       perf python: Use -Wno-redundant-decls to build with PYTHON=python3
> 
> Ding Xiang (2):
>       tools include: Adopt PTR_ERR_OR_ZERO from the kernel err.h header
>       perf bpf-loader: use PTR_ERR_OR_ZERO inetead of return code
> 
> Jiri Olsa (7):
>       perf ordered_events: Add 'struct ordered_events_buffer' layer
>       perf ordered_events: Prevent crossing max_alloc_size
>       perf tools: Remove perf_tool from event_op2
>       perf tools: Remove perf_tool from event_op3
>       perf auxtrace: Pass struct perf_mmap into mmap__read* functions
>       perf tools: Add 'struct perf_mmap' arg to record__write()
>       perf util: Make copyfile_offset() global
> 
> Jérémie Galarneau (1):
>       perf tools: Initialize perf_data_file fd field
> 
> Ravi Bangoria (1):
>       perf test: Add watchpoint test
> 
>  kernel/events/ring_buffer.c       |  14 ++-
>  tools/include/linux/err.h         |   7 ++
>  tools/perf/builtin-annotate.c     |   7 +-
>  tools/perf/builtin-inject.c       |  37 +++---
>  tools/perf/builtin-record.c       |  51 +++++----
>  tools/perf/builtin-report.c       |   9 +-
>  tools/perf/builtin-script.c       |  38 +++----
>  tools/perf/builtin-stat.c         |  23 ++--
>  tools/perf/tests/Build            |   1 +
>  tools/perf/tests/builtin-test.c   |   9 ++
>  tools/perf/tests/tests.h          |   3 +
>  tools/perf/tests/wp.c             | 229 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/auxtrace.c        |  30 +++--
>  tools/perf/util/auxtrace.h        |  21 ++--
>  tools/perf/util/bpf-loader.c      |   2 +-
>  tools/perf/util/data-convert-bt.c |   2 +-
>  tools/perf/util/header.c          |  16 ++-
>  tools/perf/util/header.h          |  15 +--
>  tools/perf/util/mmap.c            |   6 +-
>  tools/perf/util/mmap.h            |   2 +-
>  tools/perf/util/ordered-events.c  |  87 ++++++++++++---
>  tools/perf/util/ordered-events.h  |  37 +++---
>  tools/perf/util/session.c         |  75 ++++++-------
>  tools/perf/util/session.h         |   5 +-
>  tools/perf/util/setup.py          |   2 +-
>  tools/perf/util/stat.c            |   5 +-
>  tools/perf/util/stat.h            |   5 +-
>  tools/perf/util/tool.h            |   7 +-
>  tools/perf/util/util.c            |   2 +-
>  tools/perf/util/util.h            |   2 +
>  30 files changed, 519 insertions(+), 230 deletions(-)
>  create mode 100644 tools/perf/tests/wp.c

Pulled, thanks a lot Arnaldo!

	Ingo
