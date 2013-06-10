From: Rick Jones <rick.jones2@hp.com>
Subject: Re: measuring and/or dealing with "idleness" and variable frequency
Date: Mon, 10 Jun 2013 15:28:09 -0700
Message-ID: <51B652F9.4020402@hp.com>
References: <51B0CADF.8040508@hp.com> <51B3F4A3.3020502@gmail.com> <51B63847.1010008@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:2031 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab3FJW2L (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 10 Jun 2013 18:28:11 -0400
In-Reply-To: <51B63847.1010008@hp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 06/10/2013 01:34 PM, Rick Jones wrote:
> On 06/08/2013 08:21 PM, David Ahern wrote:
>> On 6/6/13 11:46 AM, Rick Jones wrote:
>>> I am coming to "perf" (record -e cycles and report) from an old-time
>>> background where one could see the "idle routine" in a profile and know
>>> how "idle" (in terms of classic reporting a la top) a CPU was.  Back
>>> then the frequency was fixed, the idle loop was always "running" when
>>> the CPU was idle and there were no hardware threads.  Life was simple
>>> and good.
>>
>> You could use the scheduling events or context-switches to know when a
>> CPU is idle. Idle time for a CPU is one of the stats my perf-timehist
>> command shows. I just dumped it to LKML:
>>     https://lkml.org/lkml/2013/6/7/656
>>
>> It's an RFC from an inclusion upstream but it has been used for over 2
>> years.
>
> I think I could get what I want from that - assuming I could get that to
> a kernel I can use in my test env, but am guessing it is rather more
> than I"m looking for at the moment.  I'm wondering if there might be a
> simpler way to go - just get the idle loop to keep looping rather than
> halt (?) the thread, so there would still be cycle events in the PMU?
> (And perhaps set the system to a static, high-performance mode to avoid
> frequency changes and maybe even disable HT?)

Or, after having found 
https://www.kernel.org/doc/Documentation/kernel-parameters.txt, perhaps 
idle=poll?

rick jones
