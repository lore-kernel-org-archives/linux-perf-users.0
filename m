From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 00/12] perf metric fixes and test
Date: Fri, 1 May 2020 12:35:19 +0200
Message-ID: <20200501103519.GB1789042@krava>
References: <20200430075144.132716-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 30, 2020 at 12:51:32AM -0700, Ian Rogers wrote:
> Add a test that all perf metrics (for your architecture) are parsable
> with the simple expression parser. Attempt to parse all events in
> metrics but only fail if the metric is for the current CPU. Fix bugs
> in the expr parser, x86 and powerpc metrics. Improve debug messages
> around add PMU config term failures.
> 
> v3 adds parse event testing of ids and improves debug messages for add
>   PMU. These messages are paticular visible with 'perf test 10
>   -vvv'. It moves the testing logic from tests/expr.c to
>   tests/pmu-events.c as suggested by John Garry
>   <john.garry@huawei.com>.  
> v2 adds Fixes tags to commit messages for when broken metrics were
>   first added. Adds a debug warning for division by zero in expr, and
>   adds a workaround for id values in the expr test necessary for
>   powerpc. It also fixes broken power8 and power9 metrics.
> 
> Ian Rogers (12):
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
>   perf parse-events: expand add PMU error/verbose messages
>   perf test: improve pmu event metric testing

this does not apply on top of changes from Kajol Jain
which are now in Arnaldo's perf/core.. could you please
rebase?

thanks,
jirka
