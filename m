From: Rick Jones <rick.jones2@hp.com>
Subject: Re: measuring and/or dealing with "idleness" and variable frequency
Date: Wed, 12 Jun 2013 14:21:30 -0700
Message-ID: <51B8E65A.7090102@hp.com>
References: <51B0CADF.8040508@hp.com> <51B3F4A3.3020502@gmail.com> <51B63847.1010008@hp.com> <51B652F9.4020402@hp.com> <51B65430.8050501@gmail.com> <51B65589.5030700@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:13217 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab3FLVVb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 12 Jun 2013 17:21:31 -0400
In-Reply-To: <51B65589.5030700@hp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 06/10/2013 03:39 PM, Rick Jones wrote:
> On 06/10/2013 03:33 PM, David Ahern wrote:
>> On 6/10/13 4:28 PM, Rick Jones wrote:
>>>> I think I could get what I want from that - assuming I could get
>>>> that to
>>>> a kernel I can use in my test env, but am guessing it is rather more
>>>> than I"m looking for at the moment.  I'm wondering if there might be a
>>>> simpler way to go - just get the idle loop to keep looping rather than
>>>> halt (?) the thread, so there would still be cycle events in the PMU?
>>>> (And perhaps set the system to a static, high-performance mode to avoid
>>>> frequency changes and maybe even disable HT?)
>>>
>>> Or, after having found
>>> https://www.kernel.org/doc/Documentation/kernel-parameters.txt, perhaps
>>> idle=poll?
>>
>> Yes, that should turn the server into a power-sucking space heater and
>> keep the cycles counter firing.
>
> Excellent - I can live with the server being a power-sucking space
> heater for the duration of my profiling.  Heck, many of the servers I
> used to work on were always power-sucking space heaters :)

Just for the archives and anyone looking to go "space heater" in the 
future - it is a Good Idea (tm) to disable hyper threads (at least with 
this sort of hyper threading in E5-2670 processors) or you can have what 
I presume are two HT's battling one another in the idle loop.

rick jones
