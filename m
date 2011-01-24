From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 21:40:44 +0100
Message-ID: <20110124204042.GD2318@nowhere>
References: <201101241704.01021.trenn@suse.de>
 <20110124203449.GC2318@nowhere>
 <1295901543.28776.475.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1295901543.28776.475.camel@laptop>
Sender: linux-trace-users-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Renninger <trenn@suse.de>, tardyp@gmail.com, jean.pihet@newoldbits.com, acme@ghostprotocols.net, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 24, 2011 at 09:39:03PM +0100, Peter Zijlstra wrote:
> On Mon, 2011-01-24 at 21:34 +0100, Frederic Weisbecker wrote:
> > 
> > But instead of a global tracing ABI number, I would rather suggest
> > one number per tracepoint subsystem (sched, power, etc...).
> > 
> > Ideally it would be per event, but sometimes those events tend to be
> > renamed or a whole tracepoint subsystem refactored (see workqueue
> > lately). Hence it might be better per subsystem. 
> 
> What's wrong with what we have? the /format file is pretty unique to
> function as a version number of you use a hash over it.

Yeah we could in fact use it to find if fields have been added,
removed. Right, all in one that looks enough to me.
