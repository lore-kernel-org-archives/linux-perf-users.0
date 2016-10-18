From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Tue, 18 Oct 2016 11:58:26 -0700
Message-ID: <9e22e4b1-7e36-1a74-3620-a4790a5d1bfd@synopsys.com>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
 <1445166916.9672.10.camel@synopsys.com> <87a8rf6a6p.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
 <8761235rwe.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44CAFF9@IN01WEMBXA.internal.synopsys.com>
 <20151019093549.GK3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:51160 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbcJRS6h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2016 14:58:37 -0400
In-Reply-To: <20151019093549.GK3816@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, arcml <linux-snps-arc@lists.infradead.org>, "acme@redhat.com" <acme@redhat.com>

On 10/19/2015 02:35 AM, Peter Zijlstra wrote:
> On Mon, Oct 19, 2015 at 09:28:43AM +0000, Vineet Gupta wrote:
>> On Monday 19 October 2015 11:20 AM, Andi Kleen wrote:
>>> Vineet Gupta <Vineet.Gupta1@synopsys.com> writes:
>>>> But this user space - so IMHO UP/SMP doesn't matter and we can't simulate them in
>>>> C just by itself.
>>> It matters when you access the perf ring buffer which is updated by kernel.
>> That's part of the problem. The issue is with atomic_* APIs proliferation in perf
>> user space code which assumes native atomix r-m-w support which is not always
>> true. So I think we still need a feature detection mechanism and if absent leave
>> the ball in arch court by calling arch_atomic_* which can use creative or half
>> working measures so perf will work to some extent atleast and not bomb outright.
>>
>> Also can u please elaborate a bit on "simulate them in C" - u mean just simple
>> unprotected LD, OP, ST or do u fancy usage of futex etc?
> Doesn't ARMv5 have a cmpxchg syscall to deal with this? It does an
> IRQ-disabled load-op-store sequence.

So I got around to addressing this - now that someone actually is trying to use
NPTL (which uses llock/scond) on ARC700 lacking those instructions. However given
that we are going this route, FWIW ARM kernel got rid of this syscall with
db695c0509d6ec ("ARM: remove user cmpxchg syscall") citing some security hole.
Even of we were to disregard, the code at the time had some open code MM trickery,
which I'd rather not replicate. My use case is simple - I only need to support UP
config - and a simple {get,put}_user would suffice - given that that can
potentially take a TLB refill Miss or worse still a full page fault. I'm going to
cook that patch to add that syscall, but wanted to get some thoughts ahead of that.

-Vineet
