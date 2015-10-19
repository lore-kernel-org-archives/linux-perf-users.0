From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Sun, 18 Oct 2015 22:49:53 -0700
Message-ID: <8761235rwe.fsf@tassilo.jf.intel.com>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
	<C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
	<1445166916.9672.10.camel@synopsys.com>
	<87a8rf6a6p.fsf@tassilo.jf.intel.com>
	<C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19572 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbbJSFuH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Oct 2015 01:50:07 -0400
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
	(Vineet Gupta's message of "Mon, 19 Oct 2015 04:58:46 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Aabid Rushdi <Aabid.Rushdi@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "acme@redhat.com" <acme@redhat.com>

Vineet Gupta <Vineet.Gupta1@synopsys.com> writes:
>
> But this user space - so IMHO UP/SMP doesn't matter and we can't simulate them in
> C just by itself.

It matters when you access the perf ring buffer which is updated by kernel.
Also perf is now multi threaded to some degree.

-Andi
