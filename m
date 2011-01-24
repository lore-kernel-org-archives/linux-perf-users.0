From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 23:46:12 +0100
Message-ID: <20110124224610.GF2318@nowhere>
References: <201101241704.01021.trenn@suse.de>
 <201101242249.14471.trenn@suse.de>
 <20110124215755.GE6367@ghostprotocols.net>
 <201101242330.03008.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201101242330.03008.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Ingo Molnar <mingo@elte.hu>, tardyp@gmail.com, jean.pihet@newoldbits.com, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 24, 2011 at 11:30:01PM +0100, Thomas Renninger wrote:
> On Monday 24 January 2011 22:57:55 Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 24, 2011 at 10:49:13PM +0100, Thomas Renninger escreveu:
> ... 
> > Using the /format file hashed as peterz said is elegant, fine grained
> > content based ABI number :-)
> Ok thanks, I should have had a closer look at the binary format.
> 
> It may make sense at some time to provide a library so that other tools
> can make use of the most convenient functions in tools/perf/utils/*
> as well?

I personally wish the other way around: having Pytimechart merged in perf :)
If I remember correctly, the problem was that we don't have support for
trace_printk with perf?

But sure if more out of tree tools show up and want to use tracepoints,
we can think about librarizing it.

(Even though my secret hope is that
we build a nice one tool that can answer most tracing needs together rather
than many scattered ad hoc pieces.)
