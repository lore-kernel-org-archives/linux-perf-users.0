From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Tue, 20 Aug 2019 21:39:53 +0200
Message-ID: <20190820193953.GA12100@gmail.com>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit cfb104ca8a26affb28d81720a4ed49c30b2a3b01:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190816' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-08-16 22:43:42 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190820
> 
> for you to fetch changes up to b81d39c7a1efb83caa3f4419939a46e96191abb6:
> 
>   libperf: Fix arch include paths (2019-08-20 12:29:36 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> callchains:
> 
>    Alexey Budankov:
> 
>   - Allow collecting LBR together with DWARF callchains, for workloads
>     where the userspace stack size collected is not big enough for
>     pure DWARF based unwinding.
> 
>   - Dump the LBR call stack in 'perf report -D'.
> 
> perf top:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Show visual cue at start to state that the minimal set of samples
>     are being collected prior to sorting/bucketizing/displaying.
> 
> CoreSight (ARM hardware tracing):
> 
>   Leo Yan:
> 
>   - Support sample flags 'insn' and 'insnlen'.
> 
> core:
> 
>   Adrian Hunter:
> 
>   - Add comment for 'idx' member in 'struct perf_sample_id.
> 
> tools headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Synchronize linux/bits.h, which required grabbing a copy of the kernel
>     const.h headers and some changes in the ordering of header directories.
> 
>   - Sync x86's asm/cpufeatures.h with the with the kernel, no change in
>     any of the tools.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Fix arch include paths.
> 
> libtraceevent:
> 
>   Steven Rostedt (VMware):
> 
>   - Fix "robust" test of do_generate_dynamic_list_file.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf evsel: Add comment for 'idx' member in 'struct perf_sample_id
> 
> Alexey Budankov (3):
>       perf record: Enable LBR callstack capture jointly with thread stack
>       perf report: Dump LBR callstack data by -D jointly with thread stack
>       perf report: Prefer DWARF callstacks to LBR ones when captured both
> 
> Arnaldo Carvalho de Melo (10):
>       tools headers: Add limits.h to access __WORDSIZE
>       perf tools: tools/include should come before tools/uapi/include
>       tools headers: Grab copy of linux/const.h, needed by linux/bits.h
>       tools headers: Synchronize linux/bits.h with the kernel sources
>       tools arch x86: Sync asm/cpufeatures.h with the with the kernel
>       perf ui: Make 'exit_msg' optional in ui__question_window()
>       perf ui: Introduce non-interactive ui__info_window() function
>       perf ui browser: Allow specifying message to show when no samples are available to display
>       perf top: Show info message while collecting samples
>       tools headers: Fixup bitsperlong per arch includes
> 
> Jiri Olsa (1):
>       libperf: Fix arch include paths
> 
> Leo Yan (1):
>       perf cs-etm: Support sample flags 'insn' and 'insnlen'
> 
> Steven Rostedt (VMware) (1):
>       tools lib traceevent: Fix "robust" test of do_generate_dynamic_list_file
> 
>  tools/arch/x86/include/asm/cpufeatures.h |  3 +++
>  tools/include/linux/bitops.h             |  1 +
>  tools/include/linux/bits.h               | 17 +++++++++------
>  tools/include/linux/const.h              |  9 ++++++++
>  tools/include/uapi/asm/bitsperlong.h     | 18 ++++++++--------
>  tools/include/uapi/linux/const.h         | 31 ++++++++++++++++++++++++++
>  tools/lib/traceevent/Makefile            |  4 ++--
>  tools/perf/Makefile.config               |  2 +-
>  tools/perf/builtin-report.c              |  2 ++
>  tools/perf/check-headers.sh              |  2 ++
>  tools/perf/lib/Makefile                  |  2 +-
>  tools/perf/ui/browser.c                  |  2 ++
>  tools/perf/ui/browser.h                  |  1 +
>  tools/perf/ui/browsers/hists.c           |  3 +++
>  tools/perf/ui/tui/util.c                 | 37 ++++++++++++++++++++++----------
>  tools/perf/ui/util.h                     |  2 ++
>  tools/perf/util/cs-etm.c                 | 35 +++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h                  |  7 ++++++
>  tools/perf/util/parse-branch-options.c   |  1 +
>  tools/perf/util/session.c                | 31 +++++++++++++++-----------
>  20 files changed, 166 insertions(+), 44 deletions(-)
>  create mode 100644 tools/include/linux/const.h
>  create mode 100644 tools/include/uapi/linux/const.h

Pulled, thanks a lot Arnaldo!

This one's very nice:

> Arnaldo Carvalho de Melo (10):
>       perf top: Show info message while collecting samples

:-)

	Ingo
