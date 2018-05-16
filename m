From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/11] perf/core improvements and fixes
Date: Wed, 16 May 2018 17:58:19 +0200
Message-ID: <20180516155819.GA16354@gmail.com>
References: <20180516144908.22212-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, David Ahern <dsahern@gmail.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, "H . Peter Anvin" <hpa@zytor.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>, Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, netdev@vger.kernel.orgPeter
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, more to come as I go thru Adrian's x86
> PTI series and the C++ support improvements to 'perf probe', from
> Holger,
> 
> Best Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
>   
> The following changes since commit 291c161f6c65530092903fbea58eb07a62b220ba:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-05-15 10:30:17 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.18-20180516
> 
> for you to fetch changes up to 7a36a287de9fbb1ba906e70573d3f2315f7fd609:
> 
>   perf bpf: Fix NULL return handling in bpf__prepare_load() (2018-05-16 10:01:55 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Add '-e intel_pt//u' test to the 'parse-events' 'perf test' entry,
>   to help avoiding regressions in the events parser such as one
>   that caused a revert in v4.17-rc (Arnaldo Carvalho de Melo)
> 
> - Fix NULL return handling in bpf__prepare_load() (YueHaibing)
> 
> - Warn about 'perf buildid-cache --purge-all' failures (Ravi Bangoria)
> 
> - Add infrastructure to help in writing eBPF C programs to be used
>   with '-e name.c' type events in tools such as 'record' and 'trace',
>   with headers for common constructs and an examples directory that
>   will get populated as we add more such helpers and the 'perf bpf'
>   branch that Jiri Olsa has been working on (Arnaldo Carvalho de Melo)
> 
> - Handle uncore event aliases in small groups properly (Kan Liang)
> 
> - Use the "_stest" symbol to identify the kernel map when loading kcore (Adrian Hunter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf tools: Use the "_stest" symbol to identify the kernel map when loading kcore
> 
> Arnaldo Carvalho de Melo (7):
>       perf tests parse-events: Add intel_pt parse test
>       perf llvm-utils: Add bpf include path to clang command line
>       perf bpf: Add 'examples' directories
>       perf bpf: Add bpf.h to be used in eBPF proggies
>       perf bpf: Add kprobe example to catch 5s naps
>       perf bpf: Add license(NAME) helper
>       perf bpf: Add probe() helper to reduce kprobes boilerplate
> 
> Kan Liang (1):
>       perf parse-events: Handle uncore event aliases in small groups properly
> 
> Ravi Bangoria (1):
>       perf buildid-cache: Warn --purge-all failures
> 
> YueHaibing (1):
>       perf bpf: Fix NULL return handling in bpf__prepare_load()
> 
>  tools/perf/Makefile.config         |  14 ++++
>  tools/perf/Makefile.perf           |   8 +++
>  tools/perf/builtin-buildid-cache.c |   8 ++-
>  tools/perf/examples/bpf/5sec.c     |  49 ++++++++++++++
>  tools/perf/examples/bpf/empty.c    |   3 +
>  tools/perf/include/bpf/bpf.h       |  13 ++++
>  tools/perf/tests/parse-events.c    |  13 ++++
>  tools/perf/util/Build              |   2 +
>  tools/perf/util/bpf-loader.c       |   6 +-
>  tools/perf/util/evsel.h            |   1 +
>  tools/perf/util/llvm-utils.c       |  19 ++++--
>  tools/perf/util/parse-events.c     | 130 ++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/parse-events.h     |   7 +-
>  tools/perf/util/parse-events.y     |   8 +--
>  tools/perf/util/symbol.c           |  16 ++---
>  15 files changed, 270 insertions(+), 27 deletions(-)
>  create mode 100644 tools/perf/examples/bpf/5sec.c
>  create mode 100644 tools/perf/examples/bpf/empty.c
>  create mode 100644 tools/perf/include/bpf/bpf.h

Pulled, thanks a lot Arnaldo!

	Ingo
