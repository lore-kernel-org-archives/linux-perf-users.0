From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Date: Tue, 24 Mar 2020 14:11:12 +0100
Message-ID: <20200324131112.GU1534489@krava>
References: <20200320125406.30995-1-kjain@linux.ibm.com>
 <20200320125406.30995-10-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200320125406.30995-10-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 20, 2020 at 06:24:04PM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 52fb119d25c8..b4b91d8ad5be 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -474,8 +474,13 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>  	return false;
>  }
>  
> +int __weak arch_get_runtimeparam(void)
> +{
> +	return 1;
> +}
> +
>  static int metricgroup__add_metric_param(struct strbuf *events,
> -			struct list_head *group_list, struct pmu_event *pe)
> +		struct list_head *group_list, struct pmu_event *pe, int param)
>  {
>  
>  	const char **ids;
> @@ -483,7 +488,7 @@ static int metricgroup__add_metric_param(struct strbuf *events,

could you please call this function __metricgroup__add_metric instead?

>  	struct egroup *eg;
>  	int ret = -EINVAL;
>  
> -	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum) < 0)
> +	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, param) < 0)
>  		return ret;
>  
>  	if (events->len > 0)
> @@ -502,11 +507,21 @@ static int metricgroup__add_metric_param(struct strbuf *events,
>  
>  	eg->ids = ids;
>  	eg->idnum = idnum;
> -	eg->metric_name = pe->metric_name;
> +	if (strstr(pe->metric_expr, "?")) {
> +		char value[PATH_MAX];
> +
> +		sprintf(value, "%s%c%d", pe->metric_name, '_', param);
> +		eg->metric_name = strdup(value);

how is eg->metric_name getting released?

> +		if (!eg->metric_name) {
> +			ret = -ENOMEM;
> +			return ret;

		return -ENOMEM; ??

> +		}
> +	}
> +	else
> +		eg->metric_name = pe->metric_name;
>  	eg->metric_expr = pe->metric_expr;
>  	eg->metric_unit = pe->unit;
>  	list_add_tail(&eg->nd, group_list);
> -
>  	return 0;
>  }
>  

SNIP

thanks,
jirka
