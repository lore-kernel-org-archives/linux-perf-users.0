From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v8 3/5] perf jevents: Add support for parsing
 perchip/percore events
Date: Sun, 6 Sep 2020 14:55:52 +0200
Message-ID: <20200906125552.GC1199773@krava>
References: <20200906112004.49574-1-kjain@linux.ibm.com>
 <20200906112004.49574-4-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200906112004.49574-4-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Sun, Sep 06, 2020 at 04:50:02PM +0530, Kajol Jain wrote:

SNIP

>  typedef int (*func)(void *data, struct json_event *je);
>  
>  int eprintf(int level, int var, const char *fmt, ...)
> @@ -355,6 +368,8 @@ static int print_events_table_entry(void *data, struct json_event *je)
>  		fprintf(outfp, "\t.unit = \"%s\",\n", je->unit);
>  	if (je->perpkg)
>  		fprintf(outfp, "\t.perpkg = \"%s\",\n", je->perpkg);
> +	if (je->aggr_mode)
> +		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(je->aggr_mode));
>  	if (je->metric_expr)
>  		fprintf(outfp, "\t.metric_expr = \"%s\",\n", je->metric_expr);
>  	if (je->metric_name)
> @@ -379,6 +394,7 @@ struct event_struct {
>  	char *pmu;
>  	char *unit;
>  	char *perpkg;
> +	char *aggr_mode;
>  	char *metric_expr;
>  	char *metric_name;
>  	char *metric_group;
> @@ -408,6 +424,7 @@ struct event_struct {
>  	op(pmu);						\
>  	op(unit);						\
>  	op(perpkg);						\
> +	op(aggr_mode);						\
>  	op(metric_expr);					\
>  	op(metric_name);					\
>  	op(metric_group);					\
> @@ -613,6 +630,8 @@ static int json_events(const char *fn,
>  				addfield(map, &je.unit, "", "", val);
>  			} else if (json_streq(map, field, "PerPkg")) {
>  				addfield(map, &je.perpkg, "", "", val);
> +			} else if (json_streq(map, field, "AggregationMode")) {
> +				addfield(map, &je.aggr_mode, "", "", val);

I think you should free je.aggr_mode

jirka

>  			} else if (json_streq(map, field, "Deprecated")) {
>  				addfield(map, &je.deprecated, "", "", val);
>  			} else if (json_streq(map, field, "MetricName")) {
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index c8f306b572f4..7da1a3743b77 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -2,6 +2,11 @@
>  #ifndef PMU_EVENTS_H
>  #define PMU_EVENTS_H
>  
> +enum aggr_mode_class {
> +	PerChip = 1,
> +	PerCore
> +};
> +
>  /*
>   * Describe each PMU event. Each CPU has a table of PMU events.
>   */
> @@ -14,6 +19,7 @@ struct pmu_event {
>  	const char *pmu;
>  	const char *unit;
>  	const char *perpkg;
> +	const char *aggr_mode;
>  	const char *metric_expr;
>  	const char *metric_name;
>  	const char *metric_group;
> -- 
> 2.26.2
> 
