From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 3/5] perf jevents: Add support for parsing
 perchip/percore events
Date: Mon, 31 Aug 2020 10:44:04 +0200
Message-ID: <20200831084404.GD287892@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-4-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200827130958.189146-4-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Aug 27, 2020 at 06:39:56PM +0530, Kajol Jain wrote:
> Initially, every time we want to add new terms like chip, core thread etc,
> we need to create corrsponding fields in pmu_events and event struct.
> This patch adds an enum called 'aggr_mode_class' which store all these
> aggregation like perchip/percore. It also adds new field 'aggr_mode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c    | 16 ++++++++++++++++
>  tools/perf/pmu-events/pmu-events.h |  6 ++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index b205cd904a4f..f4ad2d403533 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -48,6 +48,7 @@
>  #include <linux/list.h>
>  #include "jsmn.h"
>  #include "json.h"
> +#include "pmu-events.h"
>  
>  int verbose;
>  char *prog;
> @@ -60,6 +61,7 @@ struct json_event {
>  	char *pmu;
>  	char *unit;
>  	char *perpkg;
> +	char *aggr_mode;
>  	char *metric_expr;
>  	char *metric_name;
>  	char *metric_group;
> @@ -74,6 +76,14 @@ struct json_event {
>  	(void)(&_min1 == &_min2);		\
>  	_min1 < _min2 ? _min1 : _min2; })
>  #endif

please add new line in here

> +enum aggr_mode_class convert(const char *aggr_mode)
> +{
> +	if (!strcmp(aggr_mode, "PerCore"))
> +		return PerCore;
> +	else if (!strcmp(aggr_mode, "PerChip"))
> +		return PerChip;
> +	return -1;

should we display some warning in here?

thanks,
jirka
