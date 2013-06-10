From: Rick Jones <rick.jones2@hp.com>
Subject: Re: measuring and/or dealing with "idleness" and variable frequency
Date: Mon, 10 Jun 2013 13:34:15 -0700
Message-ID: <51B63847.1010008@hp.com>
References: <51B0CADF.8040508@hp.com> <51B3F4A3.3020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:31325 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab3FJUeQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 10 Jun 2013 16:34:16 -0400
In-Reply-To: <51B3F4A3.3020502@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 06/08/2013 08:21 PM, David Ahern wrote:
> On 6/6/13 11:46 AM, Rick Jones wrote:
>> I am coming to "perf" (record -e cycles and report) from an old-time
>> background where one could see the "idle routine" in a profile and know
>> how "idle" (in terms of classic reporting a la top) a CPU was.  Back
>> then the frequency was fixed, the idle loop was always "running" when
>> the CPU was idle and there were no hardware threads.  Life was simple
>> and good.
>
> You could use the scheduling events or context-switches to know when a
> CPU is idle. Idle time for a CPU is one of the stats my perf-timehist
> command shows. I just dumped it to LKML:
>     https://lkml.org/lkml/2013/6/7/656
>
> It's an RFC from an inclusion upstream but it has been used for over 2
> years.

I think I could get what I want from that - assuming I could get that to 
a kernel I can use in my test env, but am guessing it is rather more 
than I"m looking for at the moment.  I'm wondering if there might be a 
simpler way to go - just get the idle loop to keep looping rather than 
halt (?) the thread, so there would still be cycle events in the PMU? 
(And perhaps set the system to a static, high-performance mode to avoid 
frequency changes and maybe even disable HT?)

rick

>
> David
>
>
>>
>> Now I have to realign to the present and am wondering where/how to get
>> started.  I've looked at https://perf.wiki.kernel.org/index.php/Tutorial
>>
>> which talks about:
>>
>>> By default, perf record uses the cycles event as the sampling event.
>>> This is a generic hardware event that is mapped to a
>>> hardware-specific PMU event by the kernel. For Intel, it is mapped to
>>> UNHALTED_CORE_CYCLES. This event does not maintain a constant
>>> correlation to time in the presence of CPU frequency scaling. Intel
>>> provides another event, called UNHALTED_REFERENCE_CYCLES but this
>>> event is NOT currently available with perf_events.
>>>
>>> On AMD systems, the event is mapped to CPU_CLK_UNHALTED and this
>>> event is also subject to frequency scaling. On any Intel or AMD
>>> processor, the cycle event does not count when the processor is idle,
>>> i.e., when it calls mwait().
>>
>> And I am wondering if those are all still true.
>>
>> I am running a 3.5.0 kernel in an Ubuntu environment (3.5.0-23-generic
>> #35~precise1-Ubuntu SMP), and among the things I wish to do is sanity
>> check the Idle % being reported by top on one system which is passing
>> traffic back and forth between two others.  Compared to the CPU
>> utilization reported by top on those two systems, the reports for this
>> one look extraordinarily low.
>>
>> The CPU involved here is:
>>
>> Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GHz
>>
>> I am also interested in seeing how the CPU consumption changes as I
>> tweak the setup of the middle box, does it go more or less idle which
>> routines have their consumption change etc etc.  and I am wondering if I
>> can get that all with just perf or if I have to correlate things between
>> multiple tools.
>>
>> thanks, and happy benchmarking,
>>
>> rick jones
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
