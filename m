From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 15:12:25 -0500
Message-ID: <20110124201225.GA14635@Krystal>
References: <201101241704.01021.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:37114 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752444Ab1AXUM1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jan 2011 15:12:27 -0500
Content-Disposition: inline
In-Reply-To: <201101241704.01021.trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: tardyp@gmail.com, jean.pihet@newoldbits.com, acme@ghostprotocols.net, fweisbec@gmail.com, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>

[ added Ingo, Steven, Thomas and Peter to CC list ]

* Thomas Renninger (trenn@suse.de) wrote:
> Hi,
> 
> as I recently cleaned up the power events with
> some format/abi adjustings...
> 
> I realized that it was rather easy to adjust
> the stuff in drivers/tools/perf, because there
> are some nice facilities to query which events
> are available.
> 
> I looked at pytimechart, there it's not that nice
> and convenient would be some kind of version number.
> 
> pytimechart can parse traces which are simply copied
> away from /sys/kernel/debug/trace and to check for
> available events and their format, one would have to
> do a separate, ugly to implement, iteration of parsing.
> 
> Would it make sense to introduce a trace
> ABI version number?
> It would be enough to increase it by one every time
> any event (don't know about other perf facilities) is
> added, removed or modified.
> Ideally the modifications are tracked with a short
> description in a file like Documentation/trace/format.changes
> 
> Untested, but the patch at the end should simply add
> a version number on top of
> /sys/kernel/debug/trace file
> 
> While this should be enough for the kernel, perf record
> would need to include it into it's binary perf.data format
> as well?
> 
> Then userspace apps could easily test whether supported
> events would be included at all, whether only a subset of
> supported events were made available and which format they have.
> 
> Does this make sense?

Hi Thomas,

I think it might make more sense to make pytimechart read the
/sys/kernel/debug/tracing/events/*/*/format files to find out if the
print-format for the events are as expected. I think this is much more adapted
to a development scheme where subsystem maintainers are responsible for changing
the content of their own events than a single global version number that needs
to be bumped synchronously for everything.

I would agree, though, about the need for a version number on the way
/sys/kernel/debug/tracing/events exports the binary event type and text-output
formatting information: in order to cope with changes to the way this metadata
is exported, we'd need such a versioning number.

But again, trying to version every tiny change to the fields per se won't scale
with the development process given that we pull instrumentation changes from
many different repository concurrently. The field layout information is there to
deal with this problem, pytimechart should perhaps start using it.

Thanks,

Mathieu

> 
> Thanks,
> 
>     Thomas

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
