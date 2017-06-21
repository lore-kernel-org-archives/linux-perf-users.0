From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 20/37] perf script: Add 'synth' event type for
 synthesized events
Date: Wed, 21 Jun 2017 23:20:03 +0300
Message-ID: <0d5f93ef-f5c9-5185-c1f6-f176f8f533ea@intel.com>
References: <1495786658-18063-21-git-send-email-adrian.hunter@intel.com>
 <1498040239-32418-1-git-send-email-adrian.hunter@intel.com>
 <20170621135145.GO13640@kernel.org>
 <66cdc4e6-58a4-e365-8a76-112daf71baf9@intel.com>
 <20170621172911.GQ13640@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170621172911.GQ13640@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, David Ahern <dsahern@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 06/21/2017 08:29 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 21, 2017 at 07:41:04PM +0300, Adrian Hunter escreveu:
>> On 06/21/2017 04:51 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Jun 21, 2017 at 01:17:19PM +0300, Adrian Hunter escreveu:
>>>> +++ b/tools/perf/util/event.h
>>>> @@ -252,6 +252,9 @@ enum auxtrace_error_type {
>>>>        PERF_AUXTRACE_ERROR_MAX
>>>> };
>>>
>>>> +/* Attribute type for custom synthesized events */
>>>> +#define PERF_TYPE_SYNTH		3000000000
>>>
>>> Why don't you make it PERF_TYPE_MAX and bump PERF_TYPE_MAX by one? I.e.
>>> this way we have what can be in attr.type in a nice enumeration, can
>>> validate it more easily (attr.type < PERF_TYPE_MAX) and will not need to 
>>> do those conversions to/from OUTPUT_TYPE_/PERF_TYPE_).
>  
>> PERF_TYPE_ is dynamically allocated above PERF_TYPE_MAX for PMUs.  Presently
>> perf_pmu_register() calls idr_alloc() with end=0 which limits the allocation
>> to INT_MAX.
> 
> Oh, forgot about that, guess a comment right beside PERF_TYPE_MAX is in
> demand :-\
> 
> So why not:
> 
> /*
>  * PERF_TYPE_ is dynamically allocated above PERF_TYPE_MAX for PMUs.  Presently
>  * perf_pmu_register() calls idr_alloc() with end=0 which limits the allocation
>  * to INT_MAX.
>  */
> #define PERF_TYPE_SYNTH		(INT_MAX + 1L)
> 
> I.e. wouldn't be some arbitrarily huge value, but one right after what
> was defined as the area for the dynamicly allocated PERF_TYPE_
> "namespace" for PMUs, right?

That seems fine.  Pedantically it should be (INT_MAX + 1U) otherwise it will
be negative on a 32-bit system.

> 
>>> Peter: now its not the PERF_RECORD_ namespace that userspaces want a
>>> chunk of, its PERF_TYPE_, which so far has been pretty stable, grabing
>>> _one_ for event synthesizing things like Intel PT (and ARM's coresight,
>>> I think) directly at include/uapi/linux/perf_event.h's perf_type_id enum
>>> looks cleaner, no?
> 
> - Arnaldo
> 
