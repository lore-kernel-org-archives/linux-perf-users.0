From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Fri, 30 Oct 2015 06:19:21 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44CE67A@IN01WEMBXA.internal.synopsys.com>
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
 <C2D7FE5348E1B147BCA15975FBA23075F44CB4BF@IN01WEMBXA.internal.synopsys.com>
 <1446134296.3203.27.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:51708 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758525AbbJ3GT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 30 Oct 2015 02:19:26 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "andi@firstfloor.org" <andi@firstfloor.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "acme@redhat.com" <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "giladb@ezchip.com" <giladb@ezchip.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "noamc@ezchip.com" <noamc@ezchip.com>

On Thursday 29 October 2015 09:28 PM, Alexey Brodkin wrote:
> Hi Vineet,
>
> On Tue, 2015-10-20 at 10:45 +0000, Vineet Gupta wrote:
>> On Tuesday 20 October 2015 03:41 PM, Peter Zijlstra wrote:
>>>>> Can we use existing syscall(s) - again this is what our good old pthread library
>>>>> code did.
>>>>>
>>>>> static void __pthread_acquire(int * spinlock)
>>>>> {
>>>>>   int cnt = 0;
>>>>>   struct timespec tm;
>>>>>
>>>>>   READ_MEMORY_BARRIER();
>>>>>
>>>>>   while (testandset(spinlock)) {   <---- atomic EXchange
>>>>>     if (cnt < 50) {
>>>>>       sched_yield();
>>>>>       cnt++;
>>>>>     } else {
>>>>>       tm.tv_sec = 0;
>>>>>       tm.tv_nsec = 2000001;
>>>>>       nanosleep(&tm, ((void *)0));
>>>>>       cnt = 0;
>>>>>     }
>>>>>   }
>>> *shudder* that is quite horrible.
>>>
>>> This means all your 'atomics' are broken for anything SCHED_FIFO and the
>>> like. You simply _cannot_ run a realtime system.
>> The code above is from uClibc old threading library which we don't use anymore.
>> The NPTL version doesn't have all of this song-n-dance and relies on futexes. The
>> change we are talking about is only for the atomics in perf itself. I do
>> understand your POV though.
>>
>>> (also, for ACQUIRE you want the READ_MEMORY_BARRIER() _after_ the
>>> test-and-set control dependency.)
>> Absolutely and in this case it will have to be added both inside the loop and one
>> at the end to cover both the scenarios !
>>
> I'm wondering what are our plans for now?
> Are we going to accept proposed fix just for ARC in 4.4 (and to all stables then)
> or we'll try to come up with more general solution?

I agree with the current solution to add -atomic to for arc700 builds.
Although making that default for arc700 tools will be better but that will not fix
things before next release of tools etc.

But we *do* need to improve generic solution
1. Add atomics detection in perf to add fall back arch stubs
2. ARC needs to add syscall for facilitating atomic r-m-w !

-Vineet
