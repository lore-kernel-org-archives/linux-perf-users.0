From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC 1/3] perf jevents: Add support for parsing perchip/percore
 events
Date: Tue, 7 Jul 2020 17:01:54 +0530
Message-ID: <d9252cb6-7cb3-9783-a0f2-d879dcc894a7@linux.ibm.com>
References: <20200625114718.229911-1-kjain@linux.ibm.com>
 <20200625114718.229911-2-kjain@linux.ibm.com>
 <CAP-5=fWG9rxObKJ38dQ=VUf3_mQbNDCTzgU1kkyw=9uVfBa+qw@mail.gmail.com>
 <512670c2-bb61-7c2f-68bc-7752499300c6@linux.ibm.com>
 <20200706125757.GA3424581@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200706125757.GA3424581@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Clarke <pc@us.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, "Liang, Kan" <kan.liang@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org



On 7/6/20 6:27 PM, Jiri Olsa wrote:
> On Fri, Jul 03, 2020 at 11:50:28AM +0530, kajoljain wrote:
> 
> SNIP
> 
>>  ]
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index fa86c5f997cc..dd2b14cc147c 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -53,6 +53,23 @@
>>  int verbose;
>>  char *prog;
>>  
>> +enum event_class {
>> +	PerChip = 0,
>> +	PerPkg = 1,
>> +	PerCore = 2
>> +};
> 
> could you please split this into patch that changes perpkg
> into the class type string and another that adds new PerChip/PerCore?
> 

Hi Jiri,
   Thanks for reviewing the prototype changes. Sure I will split it and
and send next version out.

>> +
>> +enum event_class convert(const char* event_class_type) {
>> +
>> +	if (!strcmp(event_class_type, "PerCore"))
>> +		return PerCore;
>> +	else if (!strcmp(event_class_type, "PerChip"))
>> +		return PerChip;
>> +	else if (!strcmp(event_class_type, "PerPkg"))
>> +		return PerPkg;
>> +	return -1;
>> +}
>> +
>>  int eprintf(int level, int var, const char *fmt, ...)
>>  {
>>  
>> @@ -320,7 +337,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>>  
>>  static int print_events_table_entry(void *data, char *name, char *event,
>>  				    char *desc, char *long_desc,
>> -				    char *pmu, char *unit, char *perpkg,
>> +				    char *pmu, char *unit, char *event_class_type,
> 
> maybe 'aggregation' or 'aggr_mode' would be better name than event_class_type?
>

Sure, will update.

Thanks,
Kajol Jain
 
> thanks,
> jirka
> 
