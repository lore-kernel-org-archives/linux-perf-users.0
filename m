From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] perf record: add time-of-day option
Date: Tue, 01 Mar 2011 17:37:15 +0100
Message-ID: <1298997435.5226.890.camel@laptop>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>
	 <1298865151-23656-4-git-send-email-daahern@cisco.com>
	 <1298989751.5226.863.camel@laptop>  <4D6D0438.2090901@cisco.com>
	 <1298993714.5226.871.camel@laptop>  <4D6D13C6.5020807@cisco.com>
	 <1298995250.5226.882.camel@laptop>  <4D6D1A4C.1090009@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:48626 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab1CAQft (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2011 11:35:49 -0500
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PuSY9-0000rL-05
	for linux-perf-users@vger.kernel.org; Tue, 01 Mar 2011 16:35:49 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PuSY6-00042p-F0
	for linux-perf-users@vger.kernel.org; Tue, 01 Mar 2011 16:35:46 +0000
In-Reply-To: <4D6D1A4C.1090009@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de

On Tue, 2011-03-01 at 09:09 -0700, David Ahern wrote:
> 
> I did not code it create samples of a realtime-clock event; I coded it
> to add an event to the stream on demand -- whatever event the fd is
> tied to.
> 
> 
Well yes, but aside from you and the realtime clock stuff, who'd ever
want to do this particular thing?

I'd much rather expose the whole
local_clock()/perf_clock()/trace_clock() (should all be the same anyway)
as a posix clock using CLOCK_TRACING or whatever would be an appropriate
name.

[ Since the whole thing is NMI safe it should be well possible to make a
VDSO version as well. ]

Anyway, once its visible as a posix clock you can sync up from
userspace. And this clock is indeed wanted for other things too, like
user-space tracing etc.
