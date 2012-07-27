From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFD] perf: events defined contexts (was Re: perf:
 prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect)
Date: Fri, 27 Jul 2012 14:45:38 +0200
Message-ID: <20120727124538.GB917@krava.brq.redhat.com>
References: <501121D3.3060700@mentor.com>
 <20120727072647.GA3965@gmail.com>
 <20120727115633.GL1173@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11613 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077Ab2G0Mqc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 08:46:32 -0400
Content-Disposition: inline
In-Reply-To: <20120727115633.GL1173@somewhere.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, a.p.zijlstra@chello.nl, acme@ghostprotocols.net, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jul 27, 2012 at 01:56:36PM +0200, Frederic Weisbecker wrote:

SNIP

> 
> The problem is more general than that I think.
> We need to be able to define finer grained contexts than just
> "task" and/or "CPU".
> 
> And reusing events themselves would be a nice interface.
> 
> For example create 3 events:
> 
> A = irq entry tracepoint
> B = irq exit tracepoint
> C = cpu-cycles
> 
> And say: I want to count cpu-cycles when event A fires and stop counting
> when B fires.
> 
> With that you can count cpu cycles on irqs.
> 
> You could use any event you want to define your contexts: lock, functions, etc...
> 
> And even uprobes to define areas in userspace to profile. Would that solve
> the initial problem in the thread? Like hook on function library entry/exit?
> 
> I talked about that to Jiri Olsa several times. May be he would be interested
> in implementing this. I posted some patchets one year ago but got sidetracked.
> 
> This can give you an idea from where we can start: https://lkml.org/lkml/2011/3/14/346
> 
> Jiri, would you be interested in working on this?

yep, I remember also talking about A/B being functions entry/exit

I think that was also the initial push for having ftrace perf events
support, which already got in.

I'll check ;)

jirka
