From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Fri, 1 Feb 2019 13:24:19 +0530
Message-ID: <4e816b25-1763-ec23-0642-19e6258e6ac5@linux.ibm.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava> <20190131082711.GC24233@krava>
 <20190201074353.GA8778@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201074353.GA8778@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Jiri,

On 2/1/19 1:13 PM, Jiri Olsa wrote:
> On Thu, Jan 31, 2019 at 09:27:11AM +0100, Jiri Olsa wrote:
>> On Wed, Jan 30, 2019 at 07:36:48PM +0100, Jiri Olsa wrote:
>>
>> SNIP
>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 280a72b3a553..22ec63a0782e 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -4969,6 +4969,26 @@ static void __perf_event_period(struct perf_event *event,
>>>  	}
>>>  }
>>>  
>>> +static int check_period(struct perf_event *event, u64 value)
>>> +{
>>> +	u64 sample_period_attr = event->attr.sample_period;
>>> +	u64 sample_period_hw   = event->hw.sample_period;
>>> +	int ret;
>>> +
>>> +	if (event->attr.freq) {
>>> +		event->attr.sample_freq = value;
>>> +	} else {
>>> +		event->attr.sample_period = value;
>>> +		event->hw.sample_period = value;
>>> +	}
>>
>> hm, I think we need to check the period without changing the event,
>> because we don't disable pmu, so it might get picked up by bts code
>>
>> will check
> 
> with attached patch I did not trigger the fuzzer crash
> for over a day now, could you guys try?

I ran fuzzer for couple of hours but I didn't see any crash with
your previous patch.

I'll try this newer one as well.

Thanks.
