From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] perf record: add time-of-day option
Date: Tue, 01 Mar 2011 23:28:09 +0100
Message-ID: <1299018489.5226.940.camel@laptop>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>
	 <1298865151-23656-4-git-send-email-daahern@cisco.com>
	 <1298989751.5226.863.camel@laptop>  <4D6D0438.2090901@cisco.com>
	 <1298993714.5226.871.camel@laptop>  <4D6D13C6.5020807@cisco.com>
	 <1298995250.5226.882.camel@laptop>  <4D6D1A4C.1090009@cisco.com>
	 <1298997435.5226.890.camel@laptop>  <4D6D22A7.6000000@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56796 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815Ab1CAW0k (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2011 17:26:40 -0500
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PuY1f-0003Ty-J0
	for linux-perf-users@vger.kernel.org; Tue, 01 Mar 2011 22:26:39 +0000
In-Reply-To: <4D6D22A7.6000000@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de

On Tue, 2011-03-01 at 09:45 -0700, David Ahern wrote:

> One example would be a system watchdog that decided for some reason or
> another to force an event sample because of some event it detected.

That would be a design error, there already is an event, use that.

> > 
> > I'd much rather expose the whole
> > local_clock()/perf_clock()/trace_clock() (should all be the same anyway)
> > as a posix clock using CLOCK_TRACING or whatever would be an appropriate
> > name.
> > 
> > [ Since the whole thing is NMI safe it should be well possible to make a
> > VDSO version as well. ]
> > 
> > Anyway, once its visible as a posix clock you can sync up from
> > userspace. And this clock is indeed wanted for other things too, like
> > user-space tracing etc.
> > 
> 
> And for some silly reason I sense a time trap here (pun intended) .....
> 
> So your pushback is:
> 1. throw out the realtime-clock event patch,

Well, no, you need continues samples to keep in sync, so having this is
required [*].

> 2. add a new CLOCK_TRACING type to clock_gettime with VDSO hook,

Right, that is something we need anyway at some point in time.

> 3. and use a synthesized event from userspace for snapshotting
> perf_clock to time-of-day -- similar to what I have now, but one that
> will guarantee a time-of-day to perf_clock correlation (versus the
> current one which hopes that perf_clock is the monotonic clock).

I guess you could do that if we have full userspace tracing support, but
it wouldn't need synthesized events, it would need a pure userspace
event stream.

Thing is, I really dislike the ioctl() trigger
