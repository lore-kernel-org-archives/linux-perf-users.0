From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Mon, 2 Mar 2020 16:08:47 +0100
Message-ID: <20200302150847.GB259142@krava>
References: <20200229094159.25573-1-kjain@linux.ibm.com>
 <20200229094159.25573-7-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200229094159.25573-7-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Sat, Feb 29, 2020 at 03:11:57PM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 02aee946b6c1..f629828cc0de 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -399,6 +399,11 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  	strlist__delete(metriclist);
>  }
>  
> +int __weak arch_get_runtimeparam(void)
> +{
> +	return 1;
> +}
> +
>  static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  				   struct list_head *group_list)
>  {
> @@ -419,52 +424,77 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  			continue;
>  		if (match_metric(pe->metric_group, metric) ||
>  		    match_metric(pe->metric_name, metric)) {
> -			const char **ids;
> -			int idnum;
> -			struct egroup *eg;
> -			bool no_group = false;
> +			int k, count;

two things in here.. there's already ack-ed patchset from Kan Liang:
  Support metric group constraint
    >[PATCH V2 2/5] perf metricgroup: Factor out metricgroup__add_metric_weak_group()

that's changing this place, so you might want to synchronize with that


> +
> +			if (strstr(pe->metric_expr, "?"))
> +				count = arch_get_runtimeparam();
> +			else
> +				count = 1;
> +
> +			/* This loop is added to create multiple
> +			 * events depend on count value and add
> +			 * those events to group_list.
> +			 */
> +			for (k = 0; k < count; k++) {
> +				const char **ids;
> +				int idnum;
> +				struct egroup *eg;
> +				bool no_group = false;
> +				char value[PATH_MAX];
> +
> +				pr_debug("metric expr %s for %s\n",
> +					 pe->metric_expr, pe->metric_name);
> +				expr__runtimeparam = k;

the other thing is that I don't really follow what's going on in here

you're setting expr__runtimeparam to the loop index,
which you get from some arch related file

we should do this in arch-specific way.. I think that Kan's change is
already moving some bits into separate function and that should make
all this more readable, but perhaps we might need more, so all the
'repeating' code will be in a function

please either separate this to arch code, or make it understandable
for people from other archs ;-)

jirka

> +				if (expr__find_other(pe->metric_expr, NULL,
> +						     &ids, &idnum) < 0)
> +					continue;
> +				if (events->len > 0)
> +					strbuf_addf(events, ",");
> +				for (j = 0; j < idnum; j++) {
> +					pr_debug("found event %s\n", ids[j]);
> +					/*
> +					 * Duration time maps to a software
> +					 * event and can make groups not count.
> +					 * Always use it outside a group.
> +					 */
> +					if (!strcmp(ids[j], "duration_time")) {
> +						if (j > 0)
> +							strbuf_addf(events,
> +								    "}:W,");
> +						strbuf_addf(events,
> +							    "duration_time");
> +						no_group = true;
> +						continue;
> +					}
> +					strbuf_addf(events, "%s%s",
> +						    j == 0 || no_group ? "{" :
> +						    ",", ids[j]);
> +					no_group = false;
> +				}
> +				if (!no_group)
> +					strbuf_addf(events, "}:W");
>  
> -			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> +				eg = malloc(sizeof(struct egroup));
> +				if (!eg) {
> +					ret = -ENOMEM;
> +					break;
> +				}
> +				eg->ids = ids;
> +				eg->idnum = idnum;
>  
> -			if (expr__find_other(pe->metric_expr,
> -					     NULL, &ids, &idnum) < 0)
> -				continue;
> -			if (events->len > 0)
> -				strbuf_addf(events, ",");
> -			for (j = 0; j < idnum; j++) {
> -				pr_debug("found event %s\n", ids[j]);
> -				/*
> -				 * Duration time maps to a software event and can make
> -				 * groups not count. Always use it outside a
> -				 * group.
> -				 */
> -				if (!strcmp(ids[j], "duration_time")) {
> -					if (j > 0)
> -						strbuf_addf(events, "}:W,");
> -					strbuf_addf(events, "duration_time");
> -					no_group = true;
> -					continue;
> +				if (strstr(pe->metric_expr, "?")) {
> +					sprintf(value, "%s%c%d",
> +						pe->metric_name, '_', k);
> +				} else {
> +					strcpy(value, pe->metric_name);
>  				}
> -				strbuf_addf(events, "%s%s",
> -					j == 0 || no_group ? "{" : ",",
> -					ids[j]);
> -				no_group = false;
> -			}
> -			if (!no_group)
> -				strbuf_addf(events, "}:W");
>  
> -			eg = malloc(sizeof(struct egroup));
> -			if (!eg) {
> -				ret = -ENOMEM;
> -				break;
> +				eg->metric_name = strdup(value);
> +				eg->metric_expr = pe->metric_expr;
> +				eg->metric_unit = pe->unit;
> +				list_add_tail(&eg->nd, group_list);
> +				ret = 0;
>  			}
> -			eg->ids = ids;
> -			eg->idnum = idnum;
> -			eg->metric_name = pe->metric_name;
> -			eg->metric_expr = pe->metric_expr;
> -			eg->metric_unit = pe->unit;
> -			list_add_tail(&eg->nd, group_list);
> -			ret = 0;
>  		}
>  	}
>  	return ret;

SNIP
