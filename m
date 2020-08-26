From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Wed, 26 Aug 2020 12:57:05 +0200
Message-ID: <20200826105705.GD703542@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> index 2afc8304529e..e696edf70e9a 100644
> --- a/tools/perf/pmu-events/jevents.h
> +++ b/tools/perf/pmu-events/jevents.h
> @@ -2,14 +2,28 @@
>  #ifndef JEVENTS_H
>  #define JEVENTS_H 1
>  
> +#include "pmu-events.h"
> +
> +struct json_event {
> +	char *name;
> +	char *event;
> +	char *desc;
> +	char *topic;
> +	char *long_desc;
> +	char *pmu;
> +	char *unit;
> +	char *perpkg;
> +	char *metric_expr;
> +	char *metric_name;
> +	char *metric_group;
> +	char *deprecated;
> +	char *metric_constraint;
> +};
> +
>  int json_events(const char *fn,
> -		int (*func)(void *data, char *name, char *event, char *desc,
> -				char *long_desc,
> -				char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint),
> -		void *data);
> +		int (*func)(void *data, struct json_event *je),
> +			void *data);

please also add typedef for the function,
it's used in other places as well

thanks,
jirka
