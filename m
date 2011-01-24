From: Thomas Renninger <trenn@suse.de>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 22:49:13 +0100
Message-ID: <201101242249.14471.trenn@suse.de>
References: <201101241704.01021.trenn@suse.de> <20110124203449.GC2318@nowhere> <20110124212838.GB13724@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56933 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab1AXVs6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jan 2011 16:48:58 -0500
In-Reply-To: <20110124212838.GB13724@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, tardyp@gmail.com, jean.pihet@newoldbits.com, acme@ghostprotocols.net, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Monday 24 January 2011 22:28:38 Ingo Molnar wrote:
> 
> * Frederic Weisbecker <fweisbec@gmail.com> wrote:
> 
> > This may be generally useful to help dealing with tracepoint ABI changes.
> > 
> > But instead of a global tracing ABI number, I would rather suggest one number per 
> > tracepoint subsystem (sched, power, etc...).
> 
> Nooooooooooo ... !!! :-)
> 
> Please lets stop this madness before it gets too serious: we dont do ABI version 
> numbering in Linux, full stop.
Ok... :)
 
> We use 'natural' ABIs where the lack of an ABI component triggers some sort of 
> clean, finegrained error. Like a -EINVAL on a not-yet-implemented ABI component, a 
> non-existent file entry, or -ENOSYS on a non-existent syscall.
If the whole stuff matures, someone might think about a nice concept to be able
to shift around perf.data binaries which can be processed by userspace tools,
independent of the kernel version running below on which the perf.data
was produced.

Was just an idea, I agree that it's far away from being practical,
please ignore the thread...

Sorry for the noise,

   Thomas
