From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Fri, 28 Oct 2016 06:53:25 -0700
Message-ID: <20161028135325.GB26852@two.firstfloor.org>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
 <20161027210012.GN3102@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:55673 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbcJ1Nx2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2016 09:53:28 -0400
Content-Disposition: inline
In-Reply-To: <20161027210012.GN3102@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Taylor Andrews <andrewst@vmware.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Thu, Oct 27, 2016 at 11:00:12PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 27, 2016 at 11:11:24AM -0700, Andi Kleen wrote:
> > 
> > Taylor Andrews <andrewst@vmware.com> writes:
> > 
> > > First some background:
> > >
> > > VMware's virtual x86 performance counter implementation aims to expose
> > > in-use (unavailable) performance counters to the guest operating
> > > system in the hopes that software agents will recognize it as an
> > > "in-use" resource and follow the PMU sharing guidelines outlined in
> > > Intel's Performance Monitoring Unit Sharing Guide
> > > (https://software.intel.com/en-us/articles/performance-monitoring-unit-guidelines/).
> 
> I would have to dig out the thread, but that wasn't followed on purpose
> and is unlikely to ever be followed.

If I remember correctly it was about difficulty of implementation.

An already used generic counter could be just handled like a pinned
counter. The only change needed would be a hook into the scheduler to
allocate a specific counter. I don't think it would be that difficult
frankly.

The only open question is how often this would need to be rechecked. But
we already have some code to reserve the PMU when it is first used after
being idle (for the old oprofile code). This would probably be the right
place to (re-)do such a check.

-Andi
