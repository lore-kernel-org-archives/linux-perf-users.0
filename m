From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Sun, 18 Oct 2015 16:14:54 -0700
Message-ID: <87a8rf6a6p.fsf@tassilo.jf.intel.com>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
	<C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
	<1445166916.9672.10.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48608 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbbJRXOz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 18 Oct 2015 19:14:55 -0400
In-Reply-To: <1445166916.9672.10.camel@synopsys.com> (Alexey Brodkin's message
	of "Sun, 18 Oct 2015 11:15:16 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Aabid Rushdi <Aabid.Rushdi@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "acme@redhat.com" <acme@redhat.com>

Alexey Brodkin <Alexey.Brodkin@synopsys.com> writes:
>
> So the best we may do is to implement detection of atomics in the toolchain and if there's no atomics hard stop with
> perf building.

If your target is single cpu only you can always simulate them in C.

-Andi
