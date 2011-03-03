From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 3/6] perf record: add time-of-day option
Date: Thu, 03 Mar 2011 07:33:24 -0700
Message-ID: <4D6FA6B4.7060407@cisco.com>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com> <1298865151-23656-4-git-send-email-daahern@cisco.com> <alpine.LFD.2.00.1103012359460.2701@localhost6.localdomain6> <4D6E5413.6060500@cisco.com> <20110303085148.GA16832@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:2054 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175Ab1CCOdG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Mar 2011 09:33:06 -0500
In-Reply-To: <20110303085148.GA16832@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, acme@ghostprotocols.net, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul Mackerras <paulus@samba.org>, John Stultz <johnstul@us.ibm.com>, Borislav Petkov <bp@alien8.de>



On 03/03/2011 01:51 AM, Ingo Molnar wrote:
> 
> * David Ahern <daahern@cisco.com> wrote:
> 
>>> How does all that deal with CLOCK_REALTIME being affected by NTP and
>>> settimeofday? Not really, as far as I can tell. It somehow works, but
>>> that depends on the frequency of your event injection.
>>
>> It is sampled at some periodic rate to get NTP changes. Right now it is
>> hardcoded at once an hour. The frequency option can be added to the
>> --tod parameter.
> 
> As Thomas mentioned, we probably need something more complete than that.

Just responded to Thomas' email with a simpler proposal than munging on
tracepoints and trying to track time-of-day implicitly.

> Still your approach is obviously useful and i'd like to stress that explicitly. Have 

Thanks for stating that.

> you considered another related feature, feeding printk lines as special 'string 
> events' into the perf ringbuffer?
> 
> It would round up your scheme very nicely: that way you'd have a single, global, 
> GTOD-correlated event store/flow for basically every system event you might be 
> interested in. You could switch events (and tracepoints) on/off based on need, 
> controlling the type and rate of information in a very finegrained way.
> 
> If the printk approach works out i'd even suggest that such a facility would need a 
> separate tool within perf: 'perf syslog' or 'perf log'. It would heavily reuse 
> perf-script and other perf internal facilities, obviously - but you would not be 
> tied to any particular sub-tool implementation.
> 
> EDAC type events could feed into this as well, giving the tool a broader 'system 
> health' aspect as well, beyond the 'system performance analysis' aspect.

I can look into it (as time allows) once I get the dumping of software
events done.

David

> 
> Thanks,
> 
> 	Ingo
