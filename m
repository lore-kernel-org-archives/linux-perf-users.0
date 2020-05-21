From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH v3 09/14] perf metricgroup: free metric_events on
 error
Date: Thu, 21 May 2020 14:07:04 -0300
Message-ID: <20200521170704.GC14034@kernel.org>
References: <20200508053629.210324-1-irogers@google.com>
 <20200508053629.210324-10-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200508053629.210324-10-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim Phillips <ki>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, May 07, 2020 at 10:36:24PM -0700, Ian Rogers escreveu:
> Avoid a simple memory leak.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4f7e36bc49d9..7e1725d61c39 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -186,6 +186,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  		if (!evsel) {
>  			pr_debug("Cannot resolve %s: %s\n",
>  					eg->metric_name, eg->metric_expr);
> +			free(metric_events);
>  			continue;
>  		}
>  		for (i = 0; metric_events[i]; i++)
> @@ -193,11 +194,13 @@ static int metricgroup__setup_events(struct list_head *groups,
>  		me = metricgroup__lookup(metric_events_list, evsel, true);
>  		if (!me) {
>  			ret = -ENOMEM;
> +			free(metric_events);
>  			break;
>  		}
>  		expr = malloc(sizeof(struct metric_expr));
>  		if (!expr) {
>  			ret = -ENOMEM;
> +			free(metric_events);
>  			break;
>  		}
>  		expr->metric_expr = eg->metric_expr;
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

-- 

- Arnaldo
