From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Mon, 19 Oct 2015 10:04:29 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44CB056@IN01WEMBXA.internal.synopsys.com>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
 <1445166916.9672.10.camel@synopsys.com>
 <87a8rf6a6p.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
 <8761235rwe.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44CAFF9@IN01WEMBXA.internal.synopsys.com>
 <20151019093549.GK3816@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F44CB023@IN01WEMBXA.internal.synopsys.com>
 <20151019095157.GM3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:50714 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbJSKEe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Oct 2015 06:04:34 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Aabid Rushdi <Aabid.Rushdi@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "acme@redhat.com" <acme@redhat.com>

On Monday 19 October 2015 03:22 PM, Peter Zijlstra wrote:
> On Mon, Oct 19, 2015 at 09:46:35AM +0000, Vineet Gupta wrote:
>> > On ARC we could use the atomic EXchange to implement a user space only binary
>> > semaphore - these atomic ops will be small duration so it is OK to spin wait for a
>> > little bit. That's how the old pthread library worked for ARC w/o any atomic support.
> That has the obvious problem of lock-holder-preemption and the horrible
> performance issues that result from that.
>
> I think the syscall at least has deterministic behaviour, whereas that
> userspace spin loop has this abysmal worst case thing.

I agree - we can add that syscall trivially and use it based on build time feature
detection for atomics !
