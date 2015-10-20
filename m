From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Tue, 20 Oct 2015 10:45:25 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44CB4BF@IN01WEMBXA.internal.synopsys.com>
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
 <20151020101133.GA17308@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:47870 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbJTKpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Oct 2015 06:45:31 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Noam Camus <noamc@ezchip.com>, Andi Kleen <andi@firstfloor.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Gilad Ben Yossef <giladb@ezchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "acme@redhat.com" <acme@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Tuesday 20 October 2015 03:41 PM, Peter Zijlstra wrote:
>> > Can we use existing syscall(s) - again this is what our good old pthread library
>> > code did.
>> > 
>> > static void __pthread_acquire(int * spinlock)
>> > {
>> >   int cnt = 0;
>> >   struct timespec tm;
>> > 
>> >   READ_MEMORY_BARRIER();
>> > 
>> >   while (testandset(spinlock)) {   <---- atomic EXchange
>> >     if (cnt < 50) {
>> >       sched_yield();
>> >       cnt++;
>> >     } else {
>> >       tm.tv_sec = 0;
>> >       tm.tv_nsec = 2000001;
>> >       nanosleep(&tm, ((void *)0));
>> >       cnt = 0;
>> >     }
>> >   }
> *shudder* that is quite horrible.
>
> This means all your 'atomics' are broken for anything SCHED_FIFO and the
> like. You simply _cannot_ run a realtime system.

The code above is from uClibc old threading library which we don't use anymore.
The NPTL version doesn't have all of this song-n-dance and relies on futexes. The
change we are talking about is only for the atomics in perf itself. I do
understand your POV though.

> (also, for ACQUIRE you want the READ_MEMORY_BARRIER() _after_ the
> test-and-set control dependency.)

Absolutely and in this case it will have to be added both inside the loop and one
at the end to cover both the scenarios !
