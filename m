From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Mon, 21 Feb 2011 18:16:41 -0700
Message-ID: <4D630E79.7030106@cisco.com>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com> <20110221213740.GC3583@nowhere> <4D62DC21.4070407@cisco.com> <20110221215533.GD3583@nowhere> <4D62E2B0.1070607@cisco.com> <20110221222104.GE3583@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:47236 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1BVBQv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Feb 2011 20:16:51 -0500
In-Reply-To: <20110221222104.GE3583@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de



On 02/21/11 15:21, Frederic Weisbecker wrote:
>> All of the changes to perf-report are related strictly to this feature -
>> generating the timestamp and printing the sample including walking the
>> callchain.
> 
> This is the actual drawback: it's only useful for your feature. My wish
> is to have something more broadly useful. And support for callchains or
> other things like this in perf script is desired and has been requested
> by the past.

I don't agree with the conclusion. The ability to take a realtime-clock
sample + a perf_clock time stamps and prepend it to a dump of perf
samples is not limited to perf-report. To date, it's the only command
setup to use it - or maybe a better phrasing is that it is the command I
most use today.

perf-script is new. I created this timehist patch back in August and
submitted it to linux-perf-users at the end of November. The version I
sent today is the 3rd incarnation.

If it is a question of code location then I can move the function
additions from builtin-report.c to util/timehist.c. Then as other
commands are ready they can pick it up.

> 
>> perf-script needs to have features added to it:
>>   1. working with all samples,
> 
> Why do you need that? You seem to be only interested in tracepoint
> events.

I am *not* interested in tracepoints at all -- at least so far. I have
rarely used them, mainly just trying out the options to see what is
available and how much data comes pouring in. (tracepoints are not
available on the kernel version we use.)

Rather, I have been focused on the S/W events such as the context-switch
event and H/W counters. In fact, one request I have received on my end
is for a time history of H/W counters - record periodically during
specific tests and dump the samples with timestamps.

> 
> Sure I would appreciate that perf script can support any event as a bonus
> but that doesn't seem mandatory here.
> 
>>   2. support for callchains,
> 
> What does it take more than what you did in perf report, namely
> calling perf_session_resolve_callchain and walking the cursor?

It's not rocket science, nonetheless its code that needs to be brought
into perf-script.


> 
>>   3. more?
> 
> ?

There always seems to be unexpected gotchas that have to be dealt with.


David
