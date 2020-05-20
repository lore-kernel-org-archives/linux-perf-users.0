From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 5/7] perf metricgroup: Remove duped metric group events
Date: Wed, 20 May 2020 15:48:47 +0200
Message-ID: <20200520134847.GM157452@krava>
References: <20200520072814.128267-1-irogers@google.com>
 <20200520072814.128267-6-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200520072814.128267-6-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 20, 2020 at 12:28:12AM -0700, Ian Rogers wrote:

SNIP

>  
> @@ -157,7 +183,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  	int i = 0;
>  	int ret = 0;
>  	struct egroup *eg;
> -	struct evsel *evsel;
> +	struct evsel *evsel, *tmp;
>  	unsigned long *evlist_used;
>  
>  	evlist_used = bitmap_alloc(perf_evlist->core.nr_entries);
> @@ -173,7 +199,8 @@ static int metricgroup__setup_events(struct list_head *groups,
>  			ret = -ENOMEM;
>  			break;
>  		}
> -		evsel = find_evsel_group(perf_evlist, &eg->pctx, metric_events,
> +		evsel = find_evsel_group(perf_evlist, &eg->pctx,
> +					eg->has_constraint, metric_events,
>  					evlist_used);
>  		if (!evsel) {
>  			pr_debug("Cannot resolve %s: %s\n",
> @@ -200,6 +227,12 @@ static int metricgroup__setup_events(struct list_head *groups,
>  		list_add(&expr->nd, &me->head);
>  	}
>  
> +	evlist__for_each_entry_safe(perf_evlist, tmp, evsel) {
> +		if (!test_bit(evsel->idx, evlist_used)) {
> +			evlist__remove(perf_evlist, evsel);
> +			evsel__delete(evsel);
> +		}

is the groupping still enabled when we merge groups? could part
of the metric (events) be now computed in different groups?

I was wondering if we could merge all the hasmaps into single
one before the parse the evlist.. this way we won't need removing
later.. but I did not thought this through completely, so it
might not work at some point

jirka
