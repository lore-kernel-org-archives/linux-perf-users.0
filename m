From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Tue, 25 Aug 2020 09:14:11 +0100
Message-ID: <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org
Cc: jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 25/08/2020 08:40, Kajol Jain wrote:
> This patch adds new structure called 'json_event' inside jevents.h
> file to improve the callback prototype inside jevent files.
> Initially, whenever user want to add new field, they need to update
> in all function callback which make it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.
> 
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>   tools/perf/pmu-events/jevents.c | 188 +++++++++++++-------------------
>   tools/perf/pmu-events/jevents.h |  28 +++--
>   2 files changed, 94 insertions(+), 122 deletions(-)
> 
> This is the initial prototype to include structure for passing
> json fileds. Please, Let me know if this is the right direction
> to go forward.
> This patch doen't include all the changes, like percore/perchip
> field addition. If this looks fine I can send new patch set with
> those changes.
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..606805af69fe 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -318,12 +318,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>   	close_table = 1;
>   }
>   
> -static int print_events_table_entry(void *data, char *name, char *event,
> -				    char *desc, char *long_desc,
> -				    char *pmu, char *unit, char *perpkg,
> -				    char *metric_expr,
> -				    char *metric_name, char *metric_group,
> -				    char *deprecated, char *metric_constraint)

Right, too many paramaetrs of the same type, so looks reasonable to pass 
a struct

[...]

>   		if (arch_std) {
>   			/*
>   			 * An arch standard event is referenced, so try to
>   			 * fixup any unassigned values.
>   			 */
> -			err = try_fixup(fn, arch_std, &event, &desc, &name,
> -					&long_desc, &pmu, &filter, &perpkg,
> -					&unit, &metric_expr, &metric_name,
> -					&metric_group, eventcode,
> -					&deprecated, &metric_constraint);
> +			err = try_fixup(fn, arch_std, eventcode, je);
>   			if (err)
>   				goto free_strings;
>   		}
> -		err = func(data, name, real_event(name, event), desc, long_desc,
> -			   pmu, unit, perpkg, metric_expr, metric_name,
> -			   metric_group, deprecated, metric_constraint);
> +		je->event = real_event(je->name, je->event);
> +		err = func(data, je);
>   free_strings:
> -		free(event);
> -		free(desc);
> -		free(name);
> -		free(long_desc);
>   		free(extra_desc);
> -		free(pmu);
>   		free(filter);
> -		free(perpkg);
> -		free(deprecated);
> -		free(unit);
> -		free(metric_expr);
> -		free(metric_name);
> -		free(metric_group);
> -		free(metric_constraint);
>   		free(arch_std);
> +		free(je);
>   
>   		if (err)
>   			break;
> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> index 2afc8304529e..e696edf70e9a 100644
> --- a/tools/perf/pmu-events/jevents.h
> +++ b/tools/perf/pmu-events/jevents.h

Somewhat unrelated - this file only seems to be included in jevents.c, 
so I don't see why it exists...

> @@ -2,14 +2,28 @@
>   #ifndef JEVENTS_H
>   #define JEVENTS_H 1
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

This looks very much like struct event_struct, so could look to consolidate:

struct event_struct {
	struct list_head list;
	char *name;
	char *event;
	char *desc;
	char *long_desc;
	char *pmu;
	char *unit;
	char *perpkg;
	char *metric_expr;
	char *metric_name;
	char *metric_group;
	char *deprecated;
	char *metric_constraint;
};

> +};
> +
>   int json_events(const char *fn,
> -		int (*func)(void *data, char *name, char *event, char *desc,
> -				char *long_desc,
> -				char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint),
> -		void *data);
> +		int (*func)(void *data, struct json_event *je),
> +			void *data);
> +
>   char *get_cpu_str(void);
>   
>   #ifndef min
> 
