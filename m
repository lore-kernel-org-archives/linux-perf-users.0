From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Wed, 26 Aug 2020 12:33:12 +0100
Message-ID: <ac9acc5f-7ce1-c9c9-91f5-598ca13a4a89@huawei.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
 <20200826110046.GF703542@krava>
 <5d91b929-cffd-265a-dd0c-f63bc3d1565d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d91b929-cffd-265a-dd0c-f63bc3d1565d@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 26/08/2020 12:24, kajoljain wrote:
> 
> 
> On 8/26/20 4:30 PM, Jiri Olsa wrote:
>> On Tue, Aug 25, 2020 at 09:14:11AM +0100, John Garry wrote:
>>
>> SNIP
>>
>>>>    				goto free_strings;
>>>>    		}
>>>> -		err = func(data, name, real_event(name, event), desc, long_desc,
>>>> -			   pmu, unit, perpkg, metric_expr, metric_name,
>>>> -			   metric_group, deprecated, metric_constraint);
>>>> +		je->event = real_event(je->name, je->event);
>>>> +		err = func(data, je);
>>>>    free_strings:
>>>> -		free(event);
>>>> -		free(desc);
>>>> -		free(name);
>>>> -		free(long_desc);
>>>>    		free(extra_desc);
>>>> -		free(pmu);
>>>>    		free(filter);
>>>> -		free(perpkg);
>>>> -		free(deprecated);
>>>> -		free(unit);
>>>> -		free(metric_expr);
>>>> -		free(metric_name);
>>>> -		free(metric_group);
>>>> -		free(metric_constraint);

Hi Kajol Jain,

Do we need to free je->metric_name and the rest still? From a glance, 
that memory is still separately alloc'ed in addfield.

>>>>    		free(arch_std);
>>>> +		free(je);
>>>>    		if (err)
>>>>    			break;
>>>> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>>>> index 2afc8304529e..e696edf70e9a 100644
>>>> --- a/tools/perf/pmu-events/jevents.h
>>>> +++ b/tools/perf/pmu-events/jevents.h
>>>
>>> Somewhat unrelated - this file only seems to be included in jevents.c, so I
>>> don't see why it exists...
>>
>> ah right.. I won't mind getting rid of it
> 
> Hi John and  Jiri
>       Thanks for reviewing the patch. I can remove this file and add these structure inside jevents.c

thanks

> 
> Thanks,
> Kajol Jain
>>   
>>>> @@ -2,14 +2,28 @@
>>>>    #ifndef JEVENTS_H
>>>>    #define JEVENTS_H 1
>>>> +#include "pmu-events.h"
>>>> +
>>>> +struct json_event {
>>>> +	char *name;
>>>> +	char *event;
>>>> +	char *desc;
>>>> +	char *topic;
>>>> +	char *long_desc;
>>>> +	char *pmu;
>>>> +	char *unit;
>>>> +	char *perpkg;
>>>> +	char *metric_expr;
>>>> +	char *metric_name;
>>>> +	char *metric_group;
>>>> +	char *deprecated;
>>>> +	char *metric_constraint;
>>>
>>> This looks very much like struct event_struct, so could look to consolidate:
>>>
>>> struct event_struct {
>>> 	struct list_head list;
>>> 	char *name;
>>> 	char *event;
>>> 	char *desc;
>>> 	char *long_desc;
>>> 	char *pmu;
>>> 	char *unit;
>>> 	char *perpkg;
>>> 	char *metric_expr;
>>> 	char *metric_name;
>>> 	char *metric_group;
>>> 	char *deprecated;
>>> 	char *metric_constraint;
>>> };
>>
>> as Andi said they come from different layers, I think it's
>> better to keep them separated even if they share some fields

I was just suggesting to make:
  struct event_struct {
	struct list_head list;
	struct json_event je;
  }

No biggie if against this.

Cheers,
John
