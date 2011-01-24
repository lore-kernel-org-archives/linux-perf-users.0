From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 22:28:38 +0100
Message-ID: <20110124212838.GB13724@elte.hu>
References: <201101241704.01021.trenn@suse.de>
 <20110124203449.GC2318@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110124203449.GC2318@nowhere>
Sender: linux-trace-users-owner@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, tardyp@gmail.com, jean.pihet@newoldbits.com, acme@ghostprotocols.net, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

> This may be generally useful to help dealing with tracepoint ABI changes.
> 
> But instead of a global tracing ABI number, I would rather suggest one number per 
> tracepoint subsystem (sched, power, etc...).

Nooooooooooo ... !!! :-)

Please lets stop this madness before it gets too serious: we dont do ABI version 
numbering in Linux, full stop.

We use 'natural' ABIs where the lack of an ABI component triggers some sort of 
clean, finegrained error. Like a -EINVAL on a not-yet-implemented ABI component, a 
non-existent file entry, or -ENOSYS on a non-existent syscall.

Such a design is arbitrarily backportable or forward portable, it's extensible and 
it is actually maintainable.

In the ABI version numbering direction lies Windows madness ...

Thanks,

	Ingo
