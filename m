From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC v2 1/5] perf/pmu-events/jevents: Add enum to store
 aggregation like PerPkg
Date: Tue, 14 Jul 2020 14:39:20 +0530
Message-ID: <38d2fd54-41aa-61b0-c396-c58fc1da70da@linux.ibm.com>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
 <20200707122314.624400-2-kjain@linux.ibm.com> <20200712185534.GB147742@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200712185534.GB147742@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 7/13/20 12:25 AM, Jiri Olsa wrote:
> On Tue, Jul 07, 2020 at 05:53:10PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>>  			}
>>  
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 93fe72a9dc0b..3cafbb320d68 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -306,7 +306,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>>  static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>  				 char *desc, char *val,
>>  				 char *long_desc, char *topic,
>> -				 char *unit, char *perpkg,
>> +				 char *unit, char *aggr_mode,
>>  				 char *metric_expr,
>>  				 char *metric_name,
>>  				 char *deprecated)
>> @@ -378,7 +378,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>  			return -1;
>>  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>>  	}
>> -	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>> +	alias->per_pkg = aggr_mode && sscanf(aggr_mode, "%d", &num) == 1 && num == 1;
> 
> should you rather use 'num == PerPkg' instead 'num == 1' ?

Hi Jiri,
     Thanks for reviewing the patchset. Sure I will update it.

Thanks,
Kajol Jain
> 
> jirka
> 
