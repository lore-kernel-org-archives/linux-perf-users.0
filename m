From: Ian Rogers <irogers@google.com>
Subject: Re: [RFC PATCH 0/7] Share events between metrics
Date: Thu, 7 May 2020 07:11:13 -0700
Message-ID: <CAP-5=fWyV_tcEe_zss7HE7u_3JLkkBeJ5JYLVbWWuO3Q2RpRnw@mail.gmail.com>
References: <20200507081436.49071-1-irogers@google.com> <20200507134939.GA2804092@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200507134939.GA2804092@krava>
Sender: netdev-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Ki
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 7, 2020 at 6:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, May 07, 2020 at 01:14:29AM -0700, Ian Rogers wrote:
> > Metric groups contain metrics. Metrics create groups of events to
> > ideally be scheduled together. Often metrics refer to the same events,
> > for example, a cache hit and cache miss rate. Using separate event
> > groups means these metrics are multiplexed at different times and the
> > counts don't sum to 100%. More multiplexing also decreases the
> > accuracy of the measurement.
> >
> > This change orders metrics from groups or the command line, so that
> > the ones with the most events are set up first. Later metrics see if
> > groups already provide their events, and reuse them if
> > possible. Unnecessary events and groups are eliminated.
> >
> > RFC because:
> >  - without this change events within a metric may get scheduled
> >    together, after they may appear as part of a larger group and be
> >    multiplexed at different times, lowering accuracy - however, less
> >    multiplexing may compensate for this.
> >  - libbpf's hashmap is used, however, libbpf is an optional
> >    requirement for building perf.
> >  - other things I'm not thinking of.
>
> hi,
> I can't apply this, what branch/commit is this based on?
>
>         Applying: perf expr: migrate expr ids table to libbpf's hashmap
>         error: patch failed: tools/perf/tests/pmu-events.c:428
>         error: tools/perf/tests/pmu-events.c: patch does not apply
>         error: patch failed: tools/perf/util/expr.h:2
>         error: tools/perf/util/expr.h: patch does not apply
>         error: patch failed: tools/perf/util/expr.y:73
>         error: tools/perf/util/expr.y: patch does not apply
>         Patch failed at 0001 perf expr: migrate expr ids table to libbpf's hashmap
>
> thanks,
> jirka

Thanks for trying! I have resent the entire patch series here:
https://lore.kernel.org/lkml/20200507140819.126960-1-irogers@google.com/
It is acme's perf/core tree + metric fix/test CLs + some minor fixes.
Details in the cover letter.

Thanks,
Ian

> >
> > Thanks!
> >
> > Ian Rogers (7):
> >   perf expr: migrate expr ids table to libbpf's hashmap
> >   perf metricgroup: change evlist_used to a bitmap
> >   perf metricgroup: free metric_events on error
> >   perf metricgroup: always place duration_time last
> >   perf metricgroup: delay events string creation
> >   perf metricgroup: order event groups by size
> >   perf metricgroup: remove duped metric group events
> >
> >  tools/perf/tests/expr.c       |  32 ++---
> >  tools/perf/tests/pmu-events.c |  22 ++--
> >  tools/perf/util/expr.c        | 125 ++++++++++--------
> >  tools/perf/util/expr.h        |  22 ++--
> >  tools/perf/util/expr.y        |  22 +---
> >  tools/perf/util/metricgroup.c | 242 +++++++++++++++++++++-------------
> >  tools/perf/util/stat-shadow.c |  46 ++++---
> >  7 files changed, 280 insertions(+), 231 deletions(-)
> >
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
>
