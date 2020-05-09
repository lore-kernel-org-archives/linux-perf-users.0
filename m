From: Ian Rogers <irogers@google.com>
Subject: Re: [RFC PATCH v3 12/14] perf metricgroup: order event groups by size
Date: Fri, 8 May 2020 17:40:00 -0700
Message-ID: <CAP-5=fWYO2e9yVPuXGVKZ7TBP4PP6MjyEFiSd+20DOxYSLC--w@mail.gmail.com>
References: <20200508053629.210324-1-irogers@google.com> <20200508053629.210324-13-irogers@google.com>
 <20200509002518.GF3538@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200509002518.GF3538@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim
List-Id: linux-perf-users.vger.kernel.org

On Fri, May 8, 2020 at 5:25 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Thu, May 07, 2020 at 10:36:27PM -0700, Ian Rogers wrote:
> > When adding event groups to the group list, insert them in size order.
> > This performs an insertion sort on the group list. By placing the
> > largest groups at the front of the group list it is possible to see if a
> > larger group contains the same events as a later group. This can make
> > the later group redundant - it can reuse the events from the large group.
> > A later patch will add this sharing.
>
> I'm not sure if size is that great an heuristic. The dedup algorithm should
> work in any case even if you don't order by size, right?

Consider two metrics:
 - metric 1 with events {A,B}
 - metric 2 with events {A,B,C,D}
If the list isn't sorted then as the matching takes the first group
with all the events, metric 1 will match {A,B} and metric 2 {A,B,C,D}.
If the order is sorted to {A,B,C,D},{A,B} then metric 1 matches within
the {A,B,C,D} group as does metric 2. The events in metric 1 aren't
used and are removed.

The dedup algorithm is very naive :-)

> I suppose in theory some kind of topological sort would be better.

We could build something more complex, such as a directed acyclic
graph where metrics with a subset of events are children of parent
metrics. Children could have >1 parent for example
{A,B,C,D},{A,B,E},{A,B} where {A,B} is a subset of both {A,B,C,D} and
{A,B,E} and so a child of both. Presumably in that case it'd be better
to match {A,B} with {A,B,E} to reduce multiplexing. As we're merging
smaller groups into bigger, the sorting of the list is a quick and
dirty approximation of this.

Thanks,
Ian

> -Andi
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 2a6456fa178b..69fbff47089f 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -520,7 +520,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
> >               return -EINVAL;
> >       }
> >
> > -     list_add_tail(&eg->nd, group_list);
> > +     if (list_empty(group_list))
> > +             list_add(&eg->nd, group_list);
> > +     else {
> > +             struct list_head *pos;
> > +
> > +             /* Place the largest groups at the front. */
> > +             list_for_each_prev(pos, group_list) {
> > +                     struct egroup *old = list_entry(pos, struct egroup, nd);
> > +
> > +                     if (hashmap__size(&eg->pctx.ids) <=
> > +                         hashmap__size(&old->pctx.ids))
> > +                             break;
> > +             }
> > +             list_add(&eg->nd, pos);
> > +     }
> >
> >       return 0;
> >  }
> > --
> > 2.26.2.645.ge9eca65c58-goog
> >
