From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5 08/11] perf/tools: Refactoring metricgroup__add_metric
 function
Date: Wed, 18 Mar 2020 17:11:04 +0530
Message-ID: <8597c6e5-d604-e60d-e666-3420b20bd3fc@linux.ibm.com>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-9-kjain@linux.ibm.com> <20200317150945.GC757893@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317150945.GC757893@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org



On 3/17/20 8:39 PM, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 11:53:30AM +0530, Kajol Jain wrote:
>> This patch refactor metricgroup__add_metric function where
>> some part of it move to function metricgroup__add_metric_param.
>> No logic change.
> 
> can't compile this change:
> 
> [jolsa@krava perf]$ make JOBS=1
>   BUILD:   Doing 'make -j1' parallel build
>   CC       util/metricgroup.o
> util/metricgroup.c: In function ‘metricgroup__add_metric_param’:
> util/metricgroup.c:486:6: error: too many arguments to function ‘expr__find_other’
>   486 |  if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, 1) < 0)
>       |      ^~~~~~~~~~~~~~~~
> In file included from util/metricgroup.c:14:
> util/expr.h:25:5: note: declared here
>    25 | int expr__find_other(const char *expr, const char *one, const char ***other,
>       |     ^~~~~~~~~~~~~~~~
> mv: cannot stat 'util/.metricgroup.o.tmp': No such file or directory
> make[4]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: util/metricgroup.o] Error 1
> make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:616: perf-in.o] Error 2
> make[1]: *** [Makefile.perf:225: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2

Hi Jiri,
      I made a mistake while arranging the patches in the series. I'll re-arrange it
and send it again.

Thanks,
Kajol

> 
> jirka
> 
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  tools/perf/util/metricgroup.c | 63 +++++++++++++++++++++--------------
>>  1 file changed, 38 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index c3a8c701609a..b4919bcfbd8b 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -474,6 +474,41 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>>  	return false;
>>  }
>>  
>> +static int metricgroup__add_metric_param(struct strbuf *events,
>> +			struct list_head *group_list, struct pmu_event *pe)
>> +{
>> +
>> +	const char **ids;
>> +	int idnum;
>> +	struct egroup *eg;
>> +	int ret = -EINVAL;
>> +
>> +	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, 1) < 0)
>> +		return ret;
>> +
>> +	if (events->len > 0)
>> +		strbuf_addf(events, ",");
>> +
>> +	if (metricgroup__has_constraint(pe))
>> +		metricgroup__add_metric_non_group(events, ids, idnum);
>> +	else
>> +		metricgroup__add_metric_weak_group(events, ids, idnum);
>> +
>> +	eg = malloc(sizeof(*eg));
>> +	if (!eg)
>> +		ret = -ENOMEM;
>> +
>> +	eg->ids = ids;
>> +	eg->idnum = idnum;
>> +	eg->metric_name = pe->metric_name;
>> +	eg->metric_expr = pe->metric_expr;
>> +	eg->metric_unit = pe->unit;
>> +	list_add_tail(&eg->nd, group_list);
>> +	ret = 0;
>> +
>> +	return ret;
>> +}
>> +
>>  static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>>  				   struct list_head *group_list)
>>  {
>> @@ -493,35 +528,13 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>>  			continue;
>>  		if (match_metric(pe->metric_group, metric) ||
>>  		    match_metric(pe->metric_name, metric)) {
>> -			const char **ids;
>> -			int idnum;
>> -			struct egroup *eg;
>>  
>>  			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>>  
>> -			if (expr__find_other(pe->metric_expr,
>> -					     NULL, &ids, &idnum) < 0)
>> +			ret = metricgroup__add_metric_param(events,
>> +							group_list, pe);
>> +			if (ret == -EINVAL)
>>  				continue;
>> -			if (events->len > 0)
>> -				strbuf_addf(events, ",");
>> -
>> -			if (metricgroup__has_constraint(pe))
>> -				metricgroup__add_metric_non_group(events, ids, idnum);
>> -			else
>> -				metricgroup__add_metric_weak_group(events, ids, idnum);
>> -
>> -			eg = malloc(sizeof(struct egroup));
>> -			if (!eg) {
>> -				ret = -ENOMEM;
>> -				break;
>> -			}
>> -			eg->ids = ids;
>> -			eg->idnum = idnum;
>> -			eg->metric_name = pe->metric_name;
>> -			eg->metric_expr = pe->metric_expr;
>> -			eg->metric_unit = pe->unit;
>> -			list_add_tail(&eg->nd, group_list);
>> -			ret = 0;
>>  		}
>>  	}
>>  	return ret;
>> -- 
>> 2.18.1
>>
> 
