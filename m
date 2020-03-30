From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v7 3/6] perf/tools: Refactoring metricgroup__add_metric
 function
Date: Mon, 30 Mar 2020 21:36:20 +0200
Message-ID: <20200330193620.GE2490231@krava>
References: <20200327102528.4267-1-kjain@linux.ibm.com>
 <20200327102528.4267-4-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200327102528.4267-4-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 27, 2020 at 03:55:25PM +0530, Kajol Jain wrote:
> This patch refactor metricgroup__add_metric function where
> some part of it move to function metricgroup__add_metric_param.
> No logic change.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/util/metricgroup.c | 61 +++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 926449a7cdbf..b905eaa907a7 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -485,6 +485,40 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>  	return false;
>  }
>  
> +static int __metricgroup__add_metric(struct strbuf *events,
> +			struct list_head *group_list, struct pmu_event *pe)
> +{
> +
> +	const char **ids;
> +	int idnum;
> +	struct egroup *eg;
> +	int ret = -EINVAL;
> +
> +	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum) < 0)
> +		return ret;

no need for ret variable, return -EINVAL directly

jirka
