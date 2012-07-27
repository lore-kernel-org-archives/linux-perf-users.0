From: Ingo Molnar <mingo@kernel.org>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jul 2012 09:26:47 +0200
Message-ID: <20120727072647.GA3965@gmail.com>
References: <501121D3.3060700@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38921 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2G0H0w (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 03:26:52 -0400
Received: by weyx8 with SMTP id x8so1884133wey.19
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jul 2012 00:26:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <501121D3.3060700@mentor.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Iegorov Oleg <oleg_iegorov@mentor.com>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, a.p.zijlstra@chello.nl, acme@ghostprotocols.net, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>


* Iegorov Oleg <oleg_iegorov@mentor.com> wrote:

> as there was no proposed solution that helped me in response to the
> same post by Andrew Steets, I would like to know if it is possible
> to disable/enable perf event counters from the source code?
> 
> calling prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect, nor does
> compiling with -fno-omit-frame-pointer option.
> 
> It would be extremely useful to disable perf event counters for some
> parts of code and re-enable them for other parts of code, like:
> 
> prctl(PR_TASK_PERF_EVENTS_DISABLE);
> // not important for performance analysis code
> prctl(PR_TASK_PERF_EVENTS_ENABLE);
> // code that needs to be analysed
> 
> and then, run perf:
> 
> $ perf record ./program
> $ perf report
> 
> Can anyone tell me how can I enable such functionality?

So, the kernel bits to do this in a pretty quirky way are there, 
see:

    https://lkml.org/lkml/2012/1/30/99

but the librarization bits are definitely non-obvious to do and 
it's no surprise that it has not been done yet.

Regular 'perf record' in itself is not self-profiling - it's 
another task profiling you, so we cannot blanket allow 
PR_TASK_PERF_EVENTS_DISABLE to disable profiling.

What we might want to do instead on the kernel side to offer the 
functionality you are asking for is to enable 'public/weak' 
events be created by the profiler on an opt-in basis, which can 
be turned off by child tasks as well via 
PR_TASK_PERF_EVENTS_DISABLE.

On the profiling workflow side it would work in a very simple 
way, like this:

    perf record --self-profiling ./my-app

In your app you stick in appropriately placed 
PR_TASK_PERF_EVENTS_DISABLE/ENABLE calls.

On the technical side perf record creates events with that 
struct perf_event_attr::self_profiling flag set to 1. (the flag 
is disabled by default)

The PR_TASK_PERF_EVENTS_DISABLE code in the modified kernel then 
iterates through all events and disables those that have this 
flag set, not just the ones owned by this task.

Maybe someone on Cc: would be interested in implementing this 
new perf events feature?

Thanks,

	Ingo
