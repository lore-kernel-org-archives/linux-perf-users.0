From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/7] perf metricgroup: Delay events string creation
Date: Wed, 20 May 2020 11:22:22 -0700
Message-ID: <CAP-5=fXHRiahLZjQHcFiWW=zdXc7r+=WdMpzeCj-+xPcqB2khQ@mail.gmail.com>
References: <20200520072814.128267-1-irogers@google.com> <20200520072814.128267-4-irogers@google.com>
 <20200520131412.GK157452@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200520131412.GK157452@krava>
Sender: netdev-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>li
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 20, 2020 at 6:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 12:28:10AM -0700, Ian Rogers wrote:
> > Currently event groups are placed into groups_list at the same time as
> > the events string containing the events is built. Separate these two
> > operations and build the groups_list first, then the event string from
> > the groups_list. This adds an ability to reorder the groups_list that
> > will be used in a later patch.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c | 38 +++++++++++++++++++++++------------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 7a43ee0a2e40..afd960d03a77 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -90,6 +90,7 @@ struct egroup {
> >       const char *metric_expr;
> >       const char *metric_unit;
> >       int runtime;
> > +     bool has_constraint;
> >  };
> >
> >  static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> > @@ -485,8 +486,8 @@ int __weak arch_get_runtimeparam(void)
> >       return 1;
> >  }
> >
> > -static int __metricgroup__add_metric(struct strbuf *events,
> > -             struct list_head *group_list, struct pmu_event *pe, int runtime)
> > +static int __metricgroup__add_metric(struct list_head *group_list,
> > +                                  struct pmu_event *pe, int runtime)
> >  {
> >       struct egroup *eg;
> >
> > @@ -499,6 +500,7 @@ static int __metricgroup__add_metric(struct strbuf *events,
> >       eg->metric_expr = pe->metric_expr;
> >       eg->metric_unit = pe->unit;
> >       eg->runtime = runtime;
> > +     eg->has_constraint = metricgroup__has_constraint(pe);
> >
> >       if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
> >               expr__ctx_clear(&eg->pctx);
> > @@ -506,14 +508,6 @@ static int __metricgroup__add_metric(struct strbuf *events,
> >               return -EINVAL;
> >       }
> >
> > -     if (events->len > 0)
> > -             strbuf_addf(events, ",");
> > -
> > -     if (metricgroup__has_constraint(pe))
> > -             metricgroup__add_metric_non_group(events, &eg->pctx);
> > -     else
> > -             metricgroup__add_metric_weak_group(events, &eg->pctx);
> > -
> >       list_add_tail(&eg->nd, group_list);
> >
> >       return 0;
> > @@ -524,6 +518,7 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
> >  {
> >       struct pmu_events_map *map = perf_pmu__find_map(NULL);
> >       struct pmu_event *pe;
> > +     struct egroup *eg;
> >       int i, ret = -EINVAL;
> >
> >       if (!map)
> > @@ -542,7 +537,8 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
> >                       pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> >
> >                       if (!strstr(pe->metric_expr, "?")) {
> > -                             ret = __metricgroup__add_metric(events, group_list, pe, 1);
> > +                             ret = __metricgroup__add_metric(group_list,
> > +                                                             pe, 1);
> >                       } else {
> >                               int j, count;
> >
> > @@ -553,13 +549,29 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
> >                                * those events to group_list.
> >                                */
> >
> > -                             for (j = 0; j < count; j++)
> > -                                     ret = __metricgroup__add_metric(events, group_list, pe, j);
> > +                             for (j = 0; j < count; j++) {
> > +                                     ret = __metricgroup__add_metric(
> > +                                             group_list, pe, j);
> > +                             }
> >                       }
> >                       if (ret == -ENOMEM)
> >                               break;
> >               }
> >       }
> > +     if (!ret) {
>
> could you please do instead:
>
>         if (ret)
>                 return ret;
>
> so the code below cuts down one indent level and you
> don't need to split up the lines

Done, broken out as a separate patch in v2:
https://lore.kernel.org/lkml/20200520182011.32236-3-irogers@google.com/

Thanks,
Ian

> thanks,
> jirka
>
> > +             list_for_each_entry(eg, group_list, nd) {
> > +                     if (events->len > 0)
> > +                             strbuf_addf(events, ",");
> > +
> > +                     if (eg->has_constraint) {
> > +                             metricgroup__add_metric_non_group(events,
> > +                                                               &eg->pctx);
> > +                     } else {
> > +                             metricgroup__add_metric_weak_group(events,
> > +                                                                &eg->pctx);
> > +                     }
> > +             }
> > +     }
> >       return ret;
> >  }
> >
> > --
> > 2.26.2.761.g0e0b3e54be-goog
> >
>
