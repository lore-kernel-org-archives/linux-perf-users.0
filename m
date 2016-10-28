From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Fri, 28 Oct 2016 18:28:44 +0200
Message-ID: <20161028162844.GJ3142@twins.programming.kicks-ass.net>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
 <20161027210012.GN3102@twins.programming.kicks-ass.net>
 <20161028135325.GB26852@two.firstfloor.org>
 <20161028140354.GH3142@twins.programming.kicks-ass.net>
 <20161028154012.GC26852@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937846AbcJ1Q2p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2016 12:28:45 -0400
Content-Disposition: inline
In-Reply-To: <20161028154012.GC26852@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Taylor Andrews <andrewst@vmware.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Fri, Oct 28, 2016 at 08:40:12AM -0700, Andi Kleen wrote:
> > No, it was about the (mis)guide-line having fundamental races and the
> > belief that the BIOS has no business what so ever using these resources
> > to begin with.
> 
> In this case it's not the BIOS, but a hypervisor who allocates the
> counter. I believe there are valid use cases here. 
> 
> The same issue can also happen when people use user space perfmon
> tools, like PCM or likwid, and potentially with other non BIOS users.

User space writing of the MSRs is not supported and people who do this
get to keep all pieces.

But the thing is still racy, and therefore useless.
