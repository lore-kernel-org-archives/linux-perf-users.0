From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 3/6] perf record: add time-of-day option
Date: Tue, 01 Mar 2011 15:35:36 -0700
Message-ID: <4D6D74B8.4010607@cisco.com>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>	 <1298865151-23656-4-git-send-email-daahern@cisco.com>	 <1298989751.5226.863.camel@laptop>  <4D6D0438.2090901@cisco.com>	 <1298993714.5226.871.camel@laptop>  <4D6D13C6.5020807@cisco.com>	 <1298995250.5226.882.camel@laptop>  <4D6D1A4C.1090009@cisco.com>	 <1298997435.5226.890.camel@laptop>  <4D6D22A7.6000000@cisco.com> <1299018489.5226.940.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:4017 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526Ab1CAWfV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2011 17:35:21 -0500
In-Reply-To: <1299018489.5226.940.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de



On 03/01/2011 03:28 PM, Peter Zijlstra wrote:

>> And for some silly reason I sense a time trap here (pun intended) .....
>>
>> So your pushback is:
>> 1. throw out the realtime-clock event patch,
> 
> Well, no, you need continues samples to keep in sync, so having this is
> required [*].
> 
>> 2. add a new CLOCK_TRACING type to clock_gettime with VDSO hook,
> 
> Right, that is something we need anyway at some point in time.
> 
>> 3. and use a synthesized event from userspace for snapshotting
>> perf_clock to time-of-day -- similar to what I have now, but one that
>> will guarantee a time-of-day to perf_clock correlation (versus the
>> current one which hopes that perf_clock is the monotonic clock).
> 
> I guess you could do that if we have full userspace tracing support, but
> it wouldn't need synthesized events, it would need a pure userspace
> event stream.


I still don't see how this solves the need to trigger the initial sample
into the event stream.

David

> 
> Thing is, I really dislike the ioctl() trigger
> 
> 
> 
