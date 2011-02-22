From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Tue, 22 Feb 2011 03:50:04 +0100
Message-ID: <20110222025001.GA5475@nowhere>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com>
 <20110221213740.GC3583@nowhere>
 <4D62DC21.4070407@cisco.com>
 <20110221215533.GD3583@nowhere>
 <4D62E2B0.1070607@cisco.com>
 <20110221222104.GE3583@nowhere>
 <4D630E79.7030106@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51547 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1BVCuI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Feb 2011 21:50:08 -0500
Content-Disposition: inline
In-Reply-To: <4D630E79.7030106@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

On Mon, Feb 21, 2011 at 06:16:41PM -0700, David Ahern wrote:
> 
> 
> On 02/21/11 15:21, Frederic Weisbecker wrote:
> >> All of the changes to perf-report are related strictly to this feature -
> >> generating the timestamp and printing the sample including walking the
> >> callchain.
> > 
> > This is the actual drawback: it's only useful for your feature. My wish
> > is to have something more broadly useful. And support for callchains or
> > other things like this in perf script is desired and has been requested
> > by the past.
> 
> I don't agree with the conclusion. The ability to take a realtime-clock
> sample + a perf_clock time stamps and prepend it to a dump of perf
> samples is not limited to perf-report. To date, it's the only command
> setup to use it - or maybe a better phrasing is that it is the command I
> most use today.

Sure it's useful. But it doesn't integrate well.

With your proposition we have two seperate tools to look at events
sequentially: perf report to look at wall clock, normal clock, ip and sym.
And perf script to look at normal clock, pid, cpu and trace.

This split is simply a mistake. How tracing users are going to join
both outputs?

This is even more sad if you consider that the events that most need to
be displayed sequentially are the tracepoints. Sure we want to treat every
events the same, but if tracepoints traces can't be added up with
these new features, your thing is just half useful.

I don't see any good reason for that.

 
> perf-script is new. I created this timehist patch back in August and
> submitted it to linux-perf-users at the end of November. The version I
> sent today is the 3rd incarnation.

perf-script is not new, it was there in november already, although named
perf trace at that time.

> 
> If it is a question of code location then I can move the function
> additions from builtin-report.c to util/timehist.c. Then as other
> commands are ready they can pick it up.

It's not a question of file, it's a question on where it integrates
logically and if it does coherently.

> > 
> >> perf-script needs to have features added to it:
> >>   1. working with all samples,
> > 
> > Why do you need that? You seem to be only interested in tracepoint
> > events.
> 
> I am *not* interested in tracepoints at all -- at least so far. I have
> rarely used them, mainly just trying out the options to see what is
> available and how much data comes pouring in. (tracepoints are not
> available on the kernel version we use.)

Fine, that doesn't change much anyway. If you follow my idea on passing
the whole event to the process_event() callback, there is no big things
to change compared to integrate that to perf report.

For event that don't have raw trace, just don't print raw trace, that's
the only difference.

I'm not even asking you to handle that for scripts, the python and perf
part can ignore that. It just needs to be handled for the print_event()
case.

It's barely a bit more in your diff compared to the perf-report
case.


> Rather, I have been focused on the S/W events such as the context-switch
> event and H/W counters. In fact, one request I have received on my end
> is for a time history of H/W counters - record periodically during
> specific tests and dump the samples with timestamps.

Fine.

> > 
> > Sure I would appreciate that perf script can support any event as a bonus
> > but that doesn't seem mandatory here.
> > 
> >>   2. support for callchains,
> > 
> > What does it take more than what you did in perf report, namely
> > calling perf_session_resolve_callchain and walking the cursor?
> 
> It's not rocket science, nonetheless its code that needs to be brought
> into perf-script.

No difference compared to perf report integration then.

> >>   3. more?
> > 
> > ?
> 
> There always seems to be unexpected gotchas that have to be dealt with.

Sure, I suspect we are not talking about hundred of lines of code though.
