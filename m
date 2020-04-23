From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 00/11] perf metric fixes and test
Date: Thu, 23 Apr 2020 13:28:25 +0200
Message-ID: <20200423112825.GD1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:19PM -0700, Ian Rogers wrote:
> Add a test that all perf metrics (for your architecture) are
> parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
> architectures other than x86.
> 
> v2 adds Fixes tags to commit messages for when broken metrics were
>   first added. Adds a debug warning for division by zero in expr, and
>   adds a workaround for id values in the expr test necessary for
>   powerpc. It also fixes broken power8 and power9 metrics.

looks good to me

Jin Yao, is there a metric that's not working for you with this patchset
applied?

thanks,
jirka

> 
> Ian Rogers (11):
>   perf expr: unlimited escaped characters in a symbol
>   perf metrics: fix parse errors in cascade lake metrics
>   perf metrics: fix parse errors in skylake metrics
>   perf expr: allow ',' to be an other token
>   perf expr: increase max other
>   perf expr: parse numbers as doubles
>   perf expr: debug lex if debugging yacc
>   perf metrics: fix parse errors in power8 metrics
>   perf metrics: fix parse errors in power9 metrics
>   perf expr: print a debug message for division by zero
>   perf test: add expr test for pmu metrics
> 
>  .../arch/powerpc/power8/metrics.json          |  4 +-
>  .../arch/powerpc/power9/metrics.json          |  2 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    | 10 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  4 +-
>  tools/perf/tests/builtin-test.c               |  5 +
>  tools/perf/tests/expr.c                       | 96 ++++++++++++++++++-
>  tools/perf/tests/tests.h                      |  2 +
>  tools/perf/util/expr.c                        |  1 +
>  tools/perf/util/expr.h                        |  2 +-
>  tools/perf/util/expr.l                        | 16 ++--
>  tools/perf/util/expr.y                        | 16 +++-
>  11 files changed, 135 insertions(+), 23 deletions(-)
> 
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 
