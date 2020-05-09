From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH v3 13/14] perf metricgroup: remove duped metric group
 events
Date: Fri, 8 May 2020 17:38:30 -0700
Message-ID: <20200509003830.GG3538@tassilo.jf.intel.com>
References: <20200508053629.210324-1-irogers@google.com>
 <20200508053629.210324-14-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200508053629.210324-14-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim
List-Id: linux-perf-users.vger.kernel.org

>  static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  				      struct expr_parse_ctx *pctx,
> +				      bool has_constraint,
>  				      struct evsel **metric_events,
>  				      unsigned long *evlist_used)
>  {
> -	struct evsel *ev;
> -	bool leader_found;
> -	const size_t idnum = hashmap__size(&pctx->ids);
> -	size_t i = 0;
> -	int j = 0;
> +	struct evsel *ev, *current_leader = NULL;
>  	double *val_ptr;
> +	int i = 0, matched_events = 0, events_to_match;
> +	const int idnum = (int)hashmap__size(&pctx->ids);

BTW standard perf data structure would be a rblist or strlist

I think it would be really better to do the deduping in a separate
pass than trying to add it to find_evsel_group. This leads
to very complicated logic.

This will likely make it easier to implement more sophisticated
algorithms too.

-Andi
