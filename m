From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main kernel
 map chunks
Date: Mon, 10 Feb 2020 16:46:49 +0530
Message-ID: <5d1387c8-70bc-ceaf-901f-96903868b8a3@linux.ibm.com>
References: <20191223133241.8578-1-acme@kernel.org>
 <20191223133241.8578-4-acme@kernel.org>
 <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
 <20200209150108.GA1784847@krava> <20200209193238.GA1907700@krava>
 <20200210003757.GB1907700@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200210003757.GB1907700@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 2/10/20 6:07 AM, Jiri Olsa wrote:
> On Sun, Feb 09, 2020 at 08:32:38PM +0100, Jiri Olsa wrote:
> 
> SNIP
> 
>>>>
>>>> perf top from perf/core has started crashing at __map__is_kernel():
>>>>
>>>>    (gdb) bt
>>>>    #0  __map__is_kernel (map=<optimized out>) at util/map.c:935
>>>>    #1  0x000000000045551d in perf_event__process_sample (machine=0xbab8f8,
>>>>        sample=0x7fffe5ffa6d0, evsel=0xba7570, event=0xbcac50, tool=0x7fffffff84e0)
>>>>        at builtin-top.c:833
>>>>    #2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
>>>>    #3  0x000000000050b9fb in do_flush (show_progress=false, oe=0x7fffffff87e0)
>>>>        at util/ordered-events.c:244
>>>>    #4  __ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP,
>>>>        timestamp=timestamp@entry=0) at util/ordered-events.c:323
>>>>    #5  0x000000000050c1b5 in __ordered_events__flush (timestamp=<optimized out>,
>>>>        how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
>>>>    #6  ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff87e0) at util/ordered-events.c:341
>>>>    #7  ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP)
>>>>        at util/ordered-events.c:339
>>>>    #8  0x0000000000454e21 in process_thread (arg=0x7fffffff84e0) at builtin-top.c:1104
>>>>    #9  0x00007ffff7f2c4e2 in start_thread () from /lib64/libpthread.so.0
>>>>    #10 0x00007ffff76086d3 in clone () from /lib64/libc.so.6
>>>>
>>>> I haven't debugged it much but seems like the actual patch that's causing the
>>>> crash is de90d513b246 ("perf map: Use map->dso->kernel + map__kmaps() in
>>>> map__kmaps()").
>>>>
>>>> Did you face this / aware of it?
>>>
>>> hum, looks like there are few more places where we don't set
>>> kmaps pointer, patch below fixes that for me
>>>
>>> I'll still need to do more checking and I'll send a fix
>>>
>>> jirka
>>>
>>>
>>> ---
>>
>> I found one more place.. please check the attached patch
> 
> and third time's the charm.. hopefully ;-)
> 
> I made the fix more central.. it still needs to be split
> into several small fixes, but I'm running perf top for
> few hours now without the crash

I also kept it running for ~20 mins but didn't see the crash.
Feel free to add:

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
