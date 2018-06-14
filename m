From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/12] perf/urgent fixes and improvements
Date: Thu, 14 Jun 2018 08:13:15 +0200
Message-ID: <20180614061315.GA28715@gmail.com>
References: <20180611174810.14815-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 2696ec4566f598ab483a6bebc4ec841b2efb88ec:
> 
>   Merge tag 'perf-core-for-mingo-4.18-20180606' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-06-07 07:18:51 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180611
> 
> for you to fetch changes up to fad76d4333fe73cf3f73704aa34d4ce523b1c458:
> 
>   perf script: Show hw-cache events (2018-06-08 13:41:30 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes and improvements:
> 
> perf stat:
> 
> . Add --interval-clear option, to provide a 'watch' like printing (Jiri Olsa)
> 
> . Fix metric column header display alignment (Jiri Olsa)
> 
> . Improve error messages for default attributes, providing better output
>   for error in command lines such as:
> 
>   $ perf stat -T
>   Cannot set up transaction events
>   event syntax error: '..cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}'
>                                     \___ unknown term
> 
>   Where the "event syntax error" line now appears (Jiri Olsa)
> 
> perf script:
> 
> . Show hw-cache events too (Seeteena Thoufeek)
> 
> perf c2c:
> 
> . Fix data dependency problem in layout of 'struct c2c_hist_entry', where
>   its member 'struct hist_entry' must be at the end because it has a ZLA
>   as its last member, that gets space when handling callchains (Jiri Olsa)
> 
> Core:
> 
> - We cannot assume that a 'struct perf_evsel'  is to be obtained from a
>   container_of operation on a 'struct hists' as there are tools, such as
>   'perf c2c' that uses 'struct hist' instances without having them in
>   container structs that also have 'struct perf_evsel' in a particular
>   layout, so provide a different way of figuring out if a 'struct hists'
>   and 'struct hist_entry' have callchains (Arnaldo Carvalho de Melo)
> 
> - Fix error index in the PMU event parser, so that error messages can
>   point to the problematic token (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf hists: Save the callchain_size in struct hist_entry
>       perf hists: Make hist_entry__has_callchains() work with 'perf c2c'
>       perf hists browser gtk: Use hist_entry__has_callchains()
>       perf hists: Reimplement hists__has_callchains()
> 
> Jiri Olsa (7):
>       perf tools: Fix error index for pmu event parser
>       perf stat: Add --interval-clear option
>       perf stat: Use only color_fprintf call in print_metric_only
>       perf stat: Fix metric column header display alignment
>       perf stat: Allow to specify specific metric column len
>       perf stat: Add event parsing error handling to add_default_attributes
>       perf c2c: Keep struct hist_entry at the end of struct c2c_hist_entry
> 
> Seeteena Thoufeek (1):
>       perf script: Show hw-cache events
> 
>  tools/perf/Documentation/perf-stat.txt |  3 +++
>  tools/perf/builtin-c2c.c               | 10 +++----
>  tools/perf/builtin-script.c            | 12 +++++++++
>  tools/perf/builtin-stat.c              | 48 ++++++++++++++++++++--------------
>  tools/perf/ui/gtk/hists.c              |  2 +-
>  tools/perf/util/hist.c                 | 12 ++++++---
>  tools/perf/util/hist.h                 |  4 +--
>  tools/perf/util/parse-events.y         |  5 ++++
>  tools/perf/util/sort.h                 |  4 ++-
>  9 files changed, 67 insertions(+), 33 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
