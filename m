From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Tue, 20 Oct 2015 12:11:33 +0200
Message-ID: <20151020101133.GA17308@twins.programming.kicks-ass.net>
References: <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
 <1445166916.9672.10.camel@synopsys.com>
 <87a8rf6a6p.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
 <8761235rwe.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44CAFF9@IN01WEMBXA.internal.synopsys.com>
 <20151019093549.GK3816@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F44CB023@IN01WEMBXA.internal.synopsys.com>
 <20151019095157.GM3816@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F44CB43D@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52457 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbJTKLr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Oct 2015 06:11:47 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44CB43D@IN01WEMBXA.internal.synopsys.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Noam Camus <noamc@ezchip.com>, Andi Kleen <andi@firstfloor.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Gilad Ben Yossef <giladb@ezchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "acme@redhat.com" <acme@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Oct 20, 2015 at 08:00:46AM +0000, Vineet Gupta wrote:
> On Monday 19 October 2015 03:22 PM, Peter Zijlstra wrote:
> > On Mon, Oct 19, 2015 at 09:46:35AM +0000, Vineet Gupta wrote:
> >> On ARC we could use the atomic EXchange to implement a user space only binary
> >> semaphore - these atomic ops will be small duration so it is OK to spin wait for a
> >> little bit. That's how the old pthread library worked for ARC w/o any atomic support.
> > That has the obvious problem of lock-holder-preemption and the horrible
> > performance issues that result from that.
> >
> > I think the syscall at least has deterministic behaviour, whereas that
> > userspace spin loop has this abysmal worst case thing.
> 
> I don't have issue with adding the syscall per-se. But that comes with it's own
> headaches of ABI change - more importantly it requires several things to match,
> libc, kernel...  It would be easier if change was confined to say perf.

OTOH fixing all those would get you a 'sane' system :-)

> Can we use existing syscall(s) - again this is what our good old pthread library
> code did.
> 
> static void __pthread_acquire(int * spinlock)
> {
>   int cnt = 0;
>   struct timespec tm;
> 
>   READ_MEMORY_BARRIER();
> 
>   while (testandset(spinlock)) {   <---- atomic EXchange
>     if (cnt < 50) {
>       sched_yield();
>       cnt++;
>     } else {
>       tm.tv_sec = 0;
>       tm.tv_nsec = 2000001;
>       nanosleep(&tm, ((void *)0));
>       cnt = 0;
>     }
>   }

*shudder* that is quite horrible.

This means all your 'atomics' are broken for anything SCHED_FIFO and the
like. You simply _cannot_ run a realtime system.

(also, for ACQUIRE you want the READ_MEMORY_BARRIER() _after_ the
test-and-set control dependency.)

But its your arch..
