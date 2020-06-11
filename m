From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 2/2] perf expr: Add < and > operators
Date: Thu, 11 Jun 2020 10:38:58 +0200
Message-ID: <20200611083858.GB1786122@krava>
References: <20200610235823.52557-1-irogers@google.com>
 <20200610235823.52557-2-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200610235823.52557-2-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jun 10, 2020 at 04:58:23PM -0700, Ian Rogers wrote:
> These are broadly useful but required to handle TMA metrics. For
> example encoding Ports_Utilization from:
> https://download.01.org/perfmon/TMA_Metrics.csv
> requires '<'.
> 
> {
>   "BriefDescription": "This metric estimates fraction of cycles the CPU performance was potentially limited due to Core computation issues (non divider-related).  Two distinct categories can be attributed into this metric: (1) heavy data-dependency among contiguous instructions would manifest in this metric - such cases are often referred to as low Instruction Level Parallelism (ILP). (2) Contention on some hardware execution unit other than Divider. For example; when there are too many multiply operations.",
>   "MetricExpr": "( ( cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY.1_PORTS_UTIL@ + ( cpu@EXE_ACTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.RETIRE_SLOTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.000000 ) ) ) ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) if ( cpu@ARITH.DIVIDER_ACTIVE\\,cmask\\=1@ < cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ ) else ( ( cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY.1_PORTS_UTIL@ + ( cpu@EXE_ACTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.RETIRE_SLOTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.000000 ) ) ) ) - cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) )",
>   "MetricGroup": "Topdown_Group_Ports_Utilization",
>   "MetricName": "Topdown_Metric_Ports_Utilization"
> },
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/expr.c | 6 ++++++
>  tools/perf/util/expr.l  | 2 ++
>  tools/perf/util/expr.y  | 5 ++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index c4877b36ab58..b7e5ef3007fc 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -41,6 +41,12 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	ret |= test(&ctx, ".1 + 2.", 2.1);
>  	ret |= test(&ctx, "d_ratio(1, 2)", 0.5);
>  	ret |= test(&ctx, "d_ratio(2.5, 0)", 0);
> +	ret |= test(&ctx, "1.1 < 2.2", 1);
> +	ret |= test(&ctx, "2.2 > 1.1", 1);
> +	ret |= test(&ctx, "1.1 < 1.1", 0);
> +	ret |= test(&ctx, "2.2 > 2.2", 0);
> +	ret |= test(&ctx, "2.2 < 1.1", 0);
> +	ret |= test(&ctx, "1.1 > 2.2", 0);
>  
>  	if (ret)
>  		return ret;
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 298d86660a96..13e5e3c75f56 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -111,6 +111,8 @@ else		{ return ELSE; }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
>  "&"		{ return '&'; }
> +"<"		{ return '<'; }
> +">"		{ return '>'; }
>  "-"		{ return '-'; }
>  "+"		{ return '+'; }
>  "*"		{ return '*'; }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index fe145344bb39..5fcb98800f9c 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -41,6 +41,7 @@ static double d_ratio(double val0, double val1)
>  %left '|'
>  %left '^'
>  %left '&'
> +%left '<' '>'
>  %left '-' '+'
>  %left '*' '/' '%'
>  %left NEG NOT
> @@ -73,7 +74,7 @@ other: ID
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
>  |
> -D_RATIO
> +'<' | '>' | D_RATIO
>  
>  all_expr: if_expr			{ *final_val = $1; }
>  	;
> @@ -94,6 +95,8 @@ expr:	  NUMBER
>  	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
>  	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
>  	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
> +	| expr '<' expr		{ $$ = $1 < $3; }
> +	| expr '>' expr		{ $$ = $1 > $3; }
>  	| expr '+' expr		{ $$ = $1 + $3; }
>  	| expr '-' expr		{ $$ = $1 - $3; }
>  	| expr '*' expr		{ $$ = $1 * $3; }
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 
