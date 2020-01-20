From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Mon, 20 Jan 2020 14:23:19 +0530
Message-ID: <dde66abd-6025-31e3-9bda-a6eb1986eea8@linux.ibm.com>
References: <20200108065844.4030-1-kjain@linux.ibm.com>
 <e866c12a-7328-8524-fd0e-668301da6875@linux.intel.com>
 <822bcb9d-4c08-39c5-e6e7-9c3e20d77852@linux.ibm.com>
 <20200108160249.GD402774@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200108160249.GD402774@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org


On 1/8/20 9:32 PM, Jiri Olsa wrote:
> On Wed, Jan 08, 2020 at 02:41:35PM +0530, kajoljain wrote:
>
> SNIP
>
>>>> -    int i = 0;
>>>> +    int i = 0, j = 0;
>>>>        bool leader_found;
>>>>          evlist__for_each_entry (perf_evlist, ev) {
>>>> +        j++;
>>>> +        if (j <= iterator_perf_evlist)
>>>> +            continue;
>>>>            if (!strcmp(ev->name, ids[i])) {
>>>>                if (!metric_events[i])
>>>>                    metric_events[i] = ev;
>>>> @@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struct
>>>> evlist *perf_evlist,
>>>>                }
>>>>            }
>>>>        }
>>>> +    iterator_perf_evlist = j;
>>>>          return metric_events[0];
>>>>    }
>>>>
>>> Thanks for reporting and fixing this issue.
>>>
>>> I just have one question, do we really need a *static variable* to track
>>> the matched events? Perhaps using an input parameter?
>> Hi Jin,
>>
>> The other way I come up with to solve this issue is, making change in
>> perf_evlist itself by adding some flag in event name, to keep track of
>> matched events.
>>
>> As if we change event name itself, next time when we compare it won't
>> matched. But in that case we need to remove those flag later. Which will
>> increase the
>>
>> complexity. If you have any suggestions, please let me know.
> we already keep evsel::cpu_iter for similar concept
>
> so I guess we could have some iterator_perf_evlist variable in evlist..
> that is if we don't find other solution (other than static varable)

Hi Jiri,

          Thanks for reviewing the patch. I checked 'evsel::cpu_iter' 
variable, I think it added recently and I am not able to find any 
similar kind of variable in

          evlist. Please let me know if my understanding is fine. Do you 
want me to add new variable in evlist itself or there is any other way 
possible.

Thanks,

Kajol




> thanks,
> jirka
>
