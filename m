From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v4 00/12] perf metric fixes and test
Date: Thu, 7 May 2020 13:00:07 -0300
Message-ID: <20200507160007.GC32641@kernel.org>
References: <20200501173333.227162-1-irogers@google.com>
 <20200507084445.GA2447905@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200507084445.GA2447905@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, May 07, 2020 at 10:44:45AM +0200, Jiri Olsa escreveu:
> On Fri, May 01, 2020 at 10:33:21AM -0700, Ian Rogers wrote:
> > Add a test that all perf metrics (for your architecture) are parsable
> > with the simple expression parser. Attempt to parse all events in
> > metrics but only fail if the metric is for the current CPU. Fix bugs
> > in the expr parser, x86 and powerpc metrics. Improve debug messages
> > around add PMU config term failures.
> > 
> > v4 rebases after Kajol Jain's patches and fixes an asprintf warning.
> > v3 adds parse event testing of ids and improves debug messages for add
> >   PMU. These messages are paticular visible with 'perf test 10
> >   -vvv'. It moves the testing logic from tests/expr.c to
> >   tests/pmu-events.c as suggested by John Garry
> >   <john.garry@huawei.com>.  
> > v2 adds Fixes tags to commit messages for when broken metrics were
> >   first added. Adds a debug warning for division by zero in expr, and
> >   adds a workaround for id values in the expr test necessary for
> >   powerpc. It also fixes broken power8 and power9 metrics.
> > 
> > Ian Rogers (12):
> >   perf expr: unlimited escaped characters in a symbol
> >   perf metrics: fix parse errors in cascade lake metrics
> >   perf metrics: fix parse errors in skylake metrics
> >   perf expr: allow ',' to be an other token
> >   perf expr: increase max other
> >   perf expr: parse numbers as doubles
> >   perf expr: debug lex if debugging yacc
> >   perf metrics: fix parse errors in power8 metrics
> >   perf metrics: fix parse errors in power9 metrics
> >   perf expr: print a debug message for division by zero
> 
> heya,
> could we please get the 1st 10 patches in? they are important,

Ok sir, processing these now,

- Arnaldo

> and let's not block them with new versions for patches 11/12
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
