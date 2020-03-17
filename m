From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Date: Tue, 17 Mar 2020 16:06:47 +0100
Message-ID: <20200317150647.GA757893@krava>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317062333.14555-10-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 0938ad166ece..7786829b048b 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -17,12 +17,13 @@ struct expr_parse_ctx {
>  
>  struct expr_scanner_ctx {
>  	int start_token;
> +	int expr__runtimeparam;

no need for expr__ prefix in here.. jsut runtime_param

> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 402af3e8d287..85ac6d913782 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -336,7 +336,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
>  		metric_events = counter->metric_events;
>  		if (!metric_events) {
>  			if (expr__find_other(counter->metric_expr, counter->name,
> -						&metric_names, &num_metric_names) < 0)
> +						&metric_names, &num_metric_names, 1) < 0)
>  				continue;
>  
>  			metric_events = calloc(sizeof(struct evsel *),
> @@ -777,7 +777,15 @@ static void generic_metric(struct perf_stat_config *config,
>  	}
>  
>  	if (!metric_events[i]) {
> -		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
> +		int param = 1;
> +		if (strstr(metric_expr, "?")) {
> +			char *tmp = strrchr(metric_name, '_');
> +
> +			tmp++;
> +			param = strtol(tmp, &tmp, 10);
> +		}

so, if metric_expr contains '?' you go and search metric_name for '_'
and use the number after '_' ... ugh.. what's the logic? 

I understand you create as many metrics as the magic runtime param
tells you.. but what's the connection to this?

could you please outline in the changelog or comment the whole scheme
of how this all should work? like step by step on some simple example?

thanks,
jirka
