From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v6 2/5] perf/jevents: Add new structure to pass json
 fields.
Date: Tue, 1 Sep 2020 11:32:45 +0530
Message-ID: <e0cd9e5c-2e9a-5198-108e-14998a757d62@linux.ibm.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-3-kjain@linux.ibm.com> <20200831084357.GC287892@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200831084357.GC287892@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com
List-Id: linux-perf-users.vger.kernel.org



On 8/31/20 2:13 PM, Jiri Olsa wrote:
> On Thu, Aug 27, 2020 at 06:39:55PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> -	if (!*field)						\
>> +#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
>> +	je->field = strdup(es->field);				\
>> +	if (!je->field)						\
>>  		return -ENOMEM;					\
>>  } } while (0)
>>  
>> @@ -428,11 +440,7 @@ static void free_arch_std_events(void)
>>  	}
>>  }
>>  
>> -static int save_arch_std_events(void *data, char *name, char *event,
>> -				char *desc, char *long_desc, char *pmu,
>> -				char *unit, char *perpkg, char *metric_expr,
>> -				char *metric_name, char *metric_group,
>> -				char *deprecated, char *metric_constraint)
>> +static int save_arch_std_events(void *data, struct json_event *je)
>>  {
>>  	struct event_struct *es;
>>  
>> @@ -486,17 +494,16 @@ static char *real_event(const char *name, char *event)
>>  		return NULL;
>>  
>>  	for (i = 0; fixed[i].name; i++)
>> -		if (!strcasecmp(name, fixed[i].name))
>> -			return (char *)fixed[i].event;
>> +		if (!strcasecmp(name, fixed[i].name)) {
>> +			strcpy(event, fixed[i].event);
> 
> hum what's this strcpy for in here? we're just replacing separated
> variables with struct members, why do you need to copy the event in
> here?
> 

Hi Jiri,
    Actually, initially when events is not part of 'json_event' structure, we are not
assigning result of function `real_event` to event field. But as we are not passing
event filed separately in functions like 'save_arch_std_events', freeing event
memory was giving me issue as we are returning pointer from real_event function in some cases.
So, that's why I replace it to strcpy to make sure we free je.event memory. Or should I remove
free(je.event) part?

-		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated, metric_constraint);
+		je.event = real_event(je.name, je.event);

This is the part, I am referring, here we are assigning result of real_event into je.event field.

Thanks,
Kajol Jain
> thanks,
> jirka
> 
