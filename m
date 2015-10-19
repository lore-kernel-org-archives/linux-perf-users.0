From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Mon, 19 Oct 2015 11:35:49 +0200
Message-ID: <20151019093549.GK3816@twins.programming.kicks-ass.net>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
 <1445166916.9672.10.camel@synopsys.com>
 <87a8rf6a6p.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
 <8761235rwe.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44CAFF9@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51409 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbbJSJfw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Oct 2015 05:35:52 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44CAFF9@IN01WEMBXA.internal.synopsys.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Andi Kleen <andi@firstfloor.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Aabid Rushdi <Aabid.Rushdi@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "acme@redhat.com" <acme@redhat.com>

On Mon, Oct 19, 2015 at 09:28:43AM +0000, Vineet Gupta wrote:
> On Monday 19 October 2015 11:20 AM, Andi Kleen wrote:
> > Vineet Gupta <Vineet.Gupta1@synopsys.com> writes:
> >> But this user space - so IMHO UP/SMP doesn't matter and we can't simulate them in
> >> C just by itself.
> > It matters when you access the perf ring buffer which is updated by kernel.
> 
> That's part of the problem. The issue is with atomic_* APIs proliferation in perf
> user space code which assumes native atomix r-m-w support which is not always
> true. So I think we still need a feature detection mechanism and if absent leave
> the ball in arch court by calling arch_atomic_* which can use creative or half
> working measures so perf will work to some extent atleast and not bomb outright.
> 
> Also can u please elaborate a bit on "simulate them in C" - u mean just simple
> unprotected LD, OP, ST or do u fancy usage of futex etc?

Doesn't ARMv5 have a cmpxchg syscall to deal with this? It does an
IRQ-disabled load-op-store sequence.
