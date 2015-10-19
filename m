From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Mon, 19 Oct 2015 04:58:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
 <1445166916.9672.10.camel@synopsys.com> <87a8rf6a6p.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:52007 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbbJSE6v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Oct 2015 00:58:51 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Aabid Rushdi <Aabid.Rushdi@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "acme@redhat.com" <acme@redhat.com>

On Monday 19 October 2015 04:45 AM, Andi Kleen wrote:
> Alexey Brodkin <Alexey.Brodkin@synopsys.com> writes:
>> So the best we may do is to implement detection of atomics in the toolchain and if there's no atomics hard stop with
>> perf building.
> If your target is single cpu only you can always simulate them in C.
>
> -Andi

But this user space - so IMHO UP/SMP doesn't matter and we can't simulate them in
C just by itself.

-Vineet
