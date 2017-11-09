From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf utility question: "Sky high iTLB-load-misses"
Date: Thu, 9 Nov 2017 10:53:25 -0300
Message-ID: <20171109135325.GJ4333@kernel.org>
References: <20171108163440.GA10004@redhat.com>
 <alpine.DEB.2.20.1711081152280.1975@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdKINx2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Nov 2017 08:53:28 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1711081152280.1975@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Peter Zijlstra <peterz@infradead.org>, Jan =?iso-8859-1?Q?Pokorn=FD?= <poki@redhat.com>, linux-perf-users@vger.kernel.org

Em Wed, Nov 08, 2017 at 11:55:02AM -0500, Vince Weaver escreveu:
> On Wed, 8 Nov 2017, Jan Pokorný wrote:
> 
> > Is iTLB-load-misses > 100% reported because of some deficiency
> > of the platform, a bug in perf, or an expected behaviour?
> 
> If you look into the kernel, the two events being measured are
> 	[ C(RESULT_ACCESS) ] = 0x2085,  /* ITLB_MISSES.STLB_HIT */
> 	[ C(RESULT_MISS)   ] = 0xe85,   /* ITLB_MISSES.WALK_COMPLETED */
> 
> If you look this up in Intel Vol3b you can see that the "access" metric
> measures First level ITLB misses that hit in the Second-level TLB
> 
> Wheras the miss metric is a list of accesses from any level that caused a 
> walk of the page tables.
> 
> So the events don't necessarily sound like they match up very well, so 
> it's beleivable you will get odd results when trying to calculate 
> percentages based on them.

Andi, is this something you can help in figuring out a fix? Peter?

- Arnaldo
