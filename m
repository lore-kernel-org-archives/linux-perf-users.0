From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Mon, 21 Feb 2011 23:21:06 +0100
Message-ID: <20110221222104.GE3583@nowhere>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com>
 <20110221213740.GC3583@nowhere>
 <4D62DC21.4070407@cisco.com>
 <20110221215533.GD3583@nowhere>
 <4D62E2B0.1070607@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bw0-f51.google.com ([209.85.214.51]:62035 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab1BUW3G (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Feb 2011 17:29:06 -0500
Content-Disposition: inline
In-Reply-To: <4D62E2B0.1070607@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

On Mon, Feb 21, 2011 at 03:09:52PM -0700, David Ahern wrote:
> 
> 
> On 02/21/11 14:55, Frederic Weisbecker wrote:
> > On Mon, Feb 21, 2011 at 02:41:53PM -0700, David Ahern wrote:
> >>
> >>
> >> On 02/21/11 14:37, Frederic Weisbecker wrote:
> >>
> >>> The goal is actually to extend perf script to handle more than just raw data.
> >>> So that it can handle the rest of what we can find in an event: time, ip, stacktraces...
> >>>
> >>> You've added 200 lines in perf report to add the dump support. It wouldn't
> >>> require more to extend perf script to do that. And the result is going to be
> >>> much more powerful.
> >>>
> >>> Look at struct scripting_ops::process_event().
> >>
> >> I actually have a draft of perf-script - essentially duplicating sample
> >> processing done in perf-report. When it got to the point of having to
> >> add a lot of code -- other features essentially -- just to get it to the
> >> point of being ready for this feature I stopped.
> > 
> > 
> > I don't understand why it's harder to extend print_event() rather than
> > perf report.
> 
> All of the changes to perf-report are related strictly to this feature -
> generating the timestamp and printing the sample including walking the
> callchain.

This is the actual drawback: it's only useful for your feature. My wish
is to have something more broadly useful. And support for callchains or
other things like this in perf script is desired and has been requested
by the past.

> perf-script needs to have features added to it:
>   1. working with all samples,

Why do you need that? You seem to be only interested in tracepoint
events.

Sure I would appreciate that perf script can support any event as a bonus
but that doesn't seem mandatory here.

>   2. support for callchains,

What does it take more than what you did in perf report, namely
calling perf_session_resolve_callchain and walking the cursor?

>   3. more?

?
