From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v4 00/12] perf metric fixes and test
Date: Mon, 11 May 2020 09:12:03 -0700
Message-ID: <CAP-5=fUEz6iBYfiwHgyGCuVNuPGAQN+Fgbcd4ZSn5cV_VAsFvw@mail.gmail.com>
References: <20200501173333.227162-1-irogers@google.com> <20200507084445.GA2447905@krava>
 <20200511153207.GD28888@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200511153207.GD28888@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kajoljain <kjain@linux.ibm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@goog>
List-Id: linux-perf-users.vger.kernel.org

On Mon, May 11, 2020 at 8:32 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, May 07, 2020 at 10:44:45AM +0200, Jiri Olsa escreveu:
> > On Fri, May 01, 2020 at 10:33:21AM -0700, Ian Rogers wrote:
> > > Add a test that all perf metrics (for your architecture) are parsable
> > > with the simple expression parser. Attempt to parse all events in
> > > metrics but only fail if the metric is for the current CPU. Fix bugs
> > > in the expr parser, x86 and powerpc metrics. Improve debug messages
> > > around add PMU config term failures.
> > >
> > > v4 rebases after Kajol Jain's patches and fixes an asprintf warning.
> > > v3 adds parse event testing of ids and improves debug messages for add
> > >   PMU. These messages are paticular visible with 'perf test 10
> > >   -vvv'. It moves the testing logic from tests/expr.c to
> > >   tests/pmu-events.c as suggested by John Garry
> > >   <john.garry@huawei.com>.
> > > v2 adds Fixes tags to commit messages for when broken metrics were
> > >   first added. Adds a debug warning for division by zero in expr, and
> > >   adds a workaround for id values in the expr test necessary for
> > >   powerpc. It also fixes broken power8 and power9 metrics.
> > >
> > > Ian Rogers (12):
> > >   perf expr: unlimited escaped characters in a symbol
> > >   perf metrics: fix parse errors in cascade lake metrics
> > >   perf metrics: fix parse errors in skylake metrics
> > >   perf expr: allow ',' to be an other token
> > >   perf expr: increase max other
> > >   perf expr: parse numbers as doubles
> > >   perf expr: debug lex if debugging yacc
> > >   perf metrics: fix parse errors in power8 metrics
> > >   perf metrics: fix parse errors in power9 metrics
> > >   perf expr: print a debug message for division by zero
> >
> > heya,
> > could we please get the 1st 10 patches in? they are important,
> > and let's not block them with new versions for patches 11/12
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> The first ten patches are in, can we go with what Ian suggested for the
> last two patches?

It seems sad not to make this test fail for broken event encodings, as
perf test does a good job of swallowing the test's debug output
(fork...). I was thinking that I'll split out the test and various
fixes in:
https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/
The test will only do something if there is a MetricExpr for an
architecture. There are currently only MetricExpr for x86 and powerpc.
I've tested power 9 with the test, which tests the expressions for
power 8 but not the events, and everything passes. The area the test
can fail is x86 and I should be able to get reasonable coverage there
by grabbing cloud machines. When an x86 test fails it is hard to know
what to do. In Jiri's Skylake case naively 'fixing' the expression to
remove 'thresh=1' yields an expression that will only give the value
1. Perhaps a better 'fix' is just to remove the expressions in those
cases and wait for someone like Intel to refresh them? If that
expression will only work on a newer kernel then we need to identify a
constraint, etc. However, we couldn't see thresh as an event parameter
in a recent tree. Removing the expression seems like the most
expedient fix to get the test in, so that new expressions don't break
things :-)

Thanks Arnaldo for following up on this!

Ian

> - Arnaldo
>
> > thanks,
> > jirka
> >
> > >   perf parse-events: expand add PMU error/verbose messages
> > >   perf test: improve pmu event metric testing
> > >
> > >  tools/perf/arch/x86/util/intel-pt.c           |  32 ++--
> > >  .../arch/powerpc/power8/metrics.json          |   2 +-
> > >  .../arch/powerpc/power9/metrics.json          |   2 +-
> > >  .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
> > >  .../arch/x86/skylakex/skx-metrics.json        |   4 +-
> > >  tools/perf/tests/builtin-test.c               |   5 +
> > >  tools/perf/tests/expr.c                       |   1 +
> > >  tools/perf/tests/pmu-events.c                 | 156 +++++++++++++++++-
> > >  tools/perf/tests/pmu.c                        |   4 +-
> > >  tools/perf/tests/tests.h                      |   2 +
> > >  tools/perf/util/expr.c                        |   1 +
> > >  tools/perf/util/expr.h                        |   2 +-
> > >  tools/perf/util/expr.l                        |  16 +-
> > >  tools/perf/util/expr.y                        |  16 +-
> > >  tools/perf/util/parse-events.c                |  29 +++-
> > >  tools/perf/util/pmu.c                         |  33 ++--
> > >  tools/perf/util/pmu.h                         |   2 +-
> > >  17 files changed, 262 insertions(+), 55 deletions(-)
> > >
> > > --
> > > 2.26.2.526.g744177e7f7-goog
> > >
> >
>
> --
>
> - Arnaldo
