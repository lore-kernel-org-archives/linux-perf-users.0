From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 1/3] perf/core: store context switch out type into Perf
 trace
Date: Mon, 9 Apr 2018 12:56:00 +0300
Message-ID: <37886fed-e39f-3aa1-d909-0c91e746adc7@linux.intel.com>
References: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
 <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
 <20180409092603.GY4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409092603.GY4043@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 09.04.2018 12:26, Peter Zijlstra wrote:
> On Mon, Apr 09, 2018 at 10:25:32AM +0300, Alexey Budankov wrote:
>>
>> Store preempting context switch out event into Perf trace as a part of 
>> PERF_RECORD_SWITCH[_CPU_WIDE] record.
>>
>> Percentage of preempting and non-preempting context switches help 
>> understanding the nature of workloads (CPU or IO bound) that are running 
>> on a machine;
>>
>> The event is treated as preemption one when task->state value of the 
>> thread being switched out is TASK_RUNNING. Event type encoding is 
>> implemented using PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit;
>> 	
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acme, I'm thinking you should route this, since most of the changes are
> actually to the tool.
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index fc1c330c6bd6..872a5aaa77eb 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7584,6 +7584,10 @@ static void perf_event_switch(struct task_struct *task,
>>  		},
>>  	};
>>  
>> +	if (!sched_in && task->state == TASK_RUNNING)
>> +		switch_event.event_id.header.misc |=
>> +				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
> 
> I typically prefer {} over any multi-line expression.

Yep, makes sense. Sorry for missing that here.

> 
>>  	perf_iterate_sb(perf_event_switch_output,
>>  		       &switch_event,
>>  		       NULL);
> 
