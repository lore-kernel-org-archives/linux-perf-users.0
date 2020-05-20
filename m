From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/7] perf metricgroup: Change evlist_used to a bitmap
Date: Wed, 20 May 2020 10:35:42 -0300
Message-ID: <20200520133542.GG32678@kernel.org>
References: <20200520072814.128267-1-irogers@google.com>
 <20200520072814.128267-2-irogers@google.com>
 <20200520131422.GL157452@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200520131422.GL157452@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Vince
List-Id: linux-perf-users.vger.kernel.org

Em Wed, May 20, 2020 at 03:14:22PM +0200, Jiri Olsa escreveu:
> On Wed, May 20, 2020 at 12:28:08AM -0700, Ian Rogers wrote:
> > Use a bitmap rather than an array of bools.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/metricgroup.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 6772d256dfdf..a16f60da06ab 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -95,7 +95,7 @@ struct egroup {
> >  static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >  				      struct expr_parse_ctx *pctx,
> >  				      struct evsel **metric_events,
> > -				      bool *evlist_used)
> > +				      unsigned long *evlist_used)
> >  {
> >  	struct evsel *ev;
> >  	bool leader_found;
> > @@ -105,7 +105,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >  	double *val_ptr;
> >  
> >  	evlist__for_each_entry (perf_evlist, ev) {
> > -		if (evlist_used[j++])
> > +		if (test_bit(j++, evlist_used))
> >  			continue;
> >  		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
> >  			if (!metric_events[i])
> > @@ -141,7 +141,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >  			j++;
> >  		}
> >  		ev = metric_events[i];
> > -		evlist_used[ev->idx] = true;
> > +		set_bit(ev->idx, evlist_used);
> >  	}
> >  
> >  	return metric_events[0];
> > @@ -157,13 +157,11 @@ static int metricgroup__setup_events(struct list_head *groups,
> >  	int ret = 0;
> >  	struct egroup *eg;
> >  	struct evsel *evsel;
> > -	bool *evlist_used;
> > +	unsigned long *evlist_used;
> >  
> > -	evlist_used = calloc(perf_evlist->core.nr_entries, sizeof(bool));
> > -	if (!evlist_used) {
> > -		ret = -ENOMEM;
> > -		return ret;
> > -	}
> > +	evlist_used = bitmap_alloc(perf_evlist->core.nr_entries);
> > +	if (!evlist_used)
> > +		return -ENOMEM;
> >  
> >  	list_for_each_entry (eg, groups, nd) {
> >  		struct evsel **metric_events;
> > @@ -201,7 +199,7 @@ static int metricgroup__setup_events(struct list_head *groups,
> >  		list_add(&expr->nd, &me->head);
> >  	}
> >  
> > -	free(evlist_used);
> > +	bitmap_free(evlist_used);
> >  
> >  	return ret;
> >  }
> > -- 
> > 2.26.2.761.g0e0b3e54be-goog
> > 
> 

-- 

- Arnaldo
